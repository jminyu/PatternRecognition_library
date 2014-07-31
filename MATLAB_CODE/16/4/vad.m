function [x1,x2] = vad(x)
% voice activity detection
%
% input:
%  x -- speech samples from wav file
%
% outputs:
%  x1 -- start position
%  x2 -- end position

%      Copyright (C) Qiang He, 2001
%
%   This file is part of MATLAB speech recognition software. Homepage is at:
%     http://go.163.com/energy/speech.htm
%
%   About the author:
%     Qiang He (Ph.D.)
%     E.E., Tsinghua University, Beijing, P.R.C., 100084
%     Email: obase@163.net
%     WWW  : http://go.163.com/energy
%     Tel  : +86 13910051159
%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You can obtain a copy of the GNU General Public License from
%   ftp://prep.ai.mit.edu/pub/gnu/COPYING-2.0 or by writing to
%   Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% normalize to [-1,1]
x = double(x);
x = x / max(abs(x));

% constants setup: for 8KHz only
FrameLen = 256;
FrameInc = 80;

amp1 = 10;
amp2 = 2;
zcr1 = 10;
zcr2 = 5;

maxsilence = 8;  %  8*10ms =  80ms
minlen  = 15;    % 15*10ms = 150ms
status  = 0;
count   = 0;
silence = 0;

% zero crossing rate
tmp1  = enframe(x(1:end-1), FrameLen, FrameInc);
tmp2  = enframe(x(2:end)  , FrameLen, FrameInc);
signs = (tmp1.*tmp2)<0;
diffs = (tmp1 -tmp2)>0.02;
zcr   = sum(signs.*diffs, 2);

% short time energy in abs
amp = sum(abs(enframe(filter([1 -0.9375], 1, x), FrameLen, FrameInc)), 2);

% adjust energy threshold
amp1 = min(amp1, max(amp)/4);
amp2 = min(amp2, max(amp)/8);

% start endpoint detection
x1 = 0; 
x2 = 0;
for n=1:length(zcr)
   goto = 0;
   switch status
   case {0,1}                   % 0 = silence, 1 = maybe start
      if amp(n) > amp1          % in voice
         x1 = max(n-count-1,1);
         status  = 2;
         silence = 0;
         count   = count + 1;
      elseif amp(n) > amp2 | ... % maybe start
             zcr(n) > zcr2
         status = 1;
         count  = count + 1;
      else                       % in silence
         status  = 0;
         count   = 0;
      end
   case 2,                       % 2 = voice segment
      if amp(n) > amp2 | ...     % remain in voiced
         zcr(n) > zcr2
         count = count + 1;
      else                       % voice is about to end
         silence = silence+1;
         if silence < maxsilence % silence not long enough, voice not ended
            count  = count + 1;
         elseif count < minlen   % voice too short, recognize as noise
            status  = 0;
            silence = 0;
            count   = 0;
         else                    % voice ended
            status  = 3;
         end
      end
   case 3,
      break;
   end
end   

count = count-silence/2;
x2 = x1 + count -1;

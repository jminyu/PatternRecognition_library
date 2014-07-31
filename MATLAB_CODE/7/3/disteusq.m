function d=disteusq(x,y,mode,w)
% DISTEUSQ ��Ŭ�����, �ڽ� ��Ŭ����� Ȥ�� ���ϳ���� �Ÿ��� ����Ѵ�. D=(X,Y,MODE,W)
%
% �Է� ����: 
%  X,Y    �񱳵� ��������. �� ���� ������ ���ͷ� �Ǿ� �ִ�. 
%         X�� Y�� ���� ���� ���� ������.  
%
%  MODE   �ɼ� ���� ���� ���ڿ�:
%         'x' ��� X�� Y�� ������ ��ü �Ÿ� ��� ���. 
%         'd' ���õ� X�� Y�� ������ �Ÿ��� ���. 
%             ���� X�� Y�� ���� ���� ���� ������ ����Ʈ�� 'd'�̰� �׷��� ������ 'x'.
%         's' ��Ŭ����� �Ÿ� ����� �ڽ±��� ���Ѵ�. 
%
%  W      �ɼ� ����ġ ���: ���� �Ÿ��� (x-y)*W*(x-y)'
%         ���� W�� �����̸� ��� diag(W)�� ���ȴ�. 
%           
% ��� ����: 
%  D      ���� MODE='d'�̸� D�� X�� Y���� ���� ���� ���� ���� ���� �� �����̴�. 
%         ���� MODE='x'�̸� D�� X�� ���� ���� ���� Y'�� ���� ���� ���� ���� ����̴�. 
%
%   VOICEBOX �����ҽ� ����
%   VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
[nx,p]=size(x); ny=size(y,1);
if nargin<3 | isempty(mode) mode='0'; end
if any(mode=='d') | (mode~='x' & nx==ny)
   nx=min(nx,ny);
   z=x(1:nx,:)-y(1:nx,:);
   if nargin<4
      d=sum(z.*conj(z),2);
   elseif min(size(w))==1
      wv=w(:).';
      d=sum(z.*wv(ones(size(z,1),1),:).*conj(z),2);
   else
      d=sum(z*w.*conj(z),2);
   end
else
   if p>1
      if nargin<4
         z=permute(x(:,:,ones(1,ny)),[1 3 2])-permute(y(:,:,ones(1,nx)),[3 1 2]);
         d=sum(z.*conj(z),3);
      else
         nxy=nx*ny;
         z=reshape(permute(x(:,:,ones(1,ny)),[1 3 2])-permute(y(:,:,ones(1,nx)),[3 1 2]),nxy,p);
         if min(size(w))==1
            wv=w(:).';
            d=reshape(sum(z.*wv(ones(nxy,1),:).*conj(z),2),nx,ny);
         else
            d=reshape(sum(z*w.*conj(z),2),nx,ny);
         end
      end
   else
      z=x(:,ones(1,ny))-y(:,ones(1,nx)).';
      if nargin<4
         d=z.*conj(z);
      else
         d=w*z.*conj(z);
      end
   end
end
if any(mode=='s')
   d=sqrt(d);
end


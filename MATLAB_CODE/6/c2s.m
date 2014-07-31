function out=c2s(in)
% C2S 셀(cell)을 구조체로 변환한다. 
%
% 사용법:
%  out=c2s(in)
%
% 설명:
%  out=c2s({'a',1,'b',2})는 필드 out.a=1 와 out.b=2인 구조체를 리턴한다.
%  입력 파라메터는 필드명과 필드값의 쌍으로 구성된다고 가정한다.
%   
if iscell(in),
  inx1=1; 
  for i=1:2:length(in),
    a{inx1}=in{i}; b{inx1}=in{i+1};
    inx1=inx1+1;
  end                                                                           
  out=cell2struct(b,a,2);
else
  out=in;
end

return;

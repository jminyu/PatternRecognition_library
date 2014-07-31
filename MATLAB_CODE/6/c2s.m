function out=c2s(in)
% C2S ��(cell)�� ����ü�� ��ȯ�Ѵ�. 
%
% ����:
%  out=c2s(in)
%
% ����:
%  out=c2s({'a',1,'b',2})�� �ʵ� out.a=1 �� out.b=2�� ����ü�� �����Ѵ�.
%  �Է� �Ķ���ʹ� �ʵ��� �ʵ尪�� ������ �����ȴٰ� �����Ѵ�.
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

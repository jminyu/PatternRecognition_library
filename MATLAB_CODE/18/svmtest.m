clear all;    % �޸𸮷� ���� ��� ���� ���� 
close all
% ������ �о���� 
nsample = 100;
%fid = fopen('noise.txt', 'r');  % ���� ����(���� �и� �Ұ����� ������) 
fid = fopen('clean.txt', 'r');  % ���� ����(���� �и� ������ ������)
[Dataset, count] = fscanf(fid, '%f %f', [2, nsample]);% read in examples (x,y) as a 2 * nsample matrix
fclose(fid);           % ���� �ݱ� 
Dataset = Dataset';    % ��ġ
X = Dataset(:,1);      % 1���� X�� ����  
Y = Dataset(:,2);      % Y�� ���� 

sample_plus=X(find(Y>0));
sample_minus=X(find(Y<0));

figure

plot(sample_plus,0,'ro');
hold on
plot(sample_minus,0,'b+');
hold off

% ������ trade-off ����ġ(weights) C ����

C = [0.01, 0.1, 1, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, inf];

Margin = [];    % ����; ��(NULL)�� �ʱ�ȭ 
nSV = [];      % ����Ʈ ������ ��;
nMis = [];      % ���з� ������ ��;
Err = [];       % �н� ����;

for n = 1 : max(size(C)),
    % Hessian ��� ����; Hessian ����� Q ����̶�� �ϰ� Kernel ����̶�� �Ѵ�. 
    H = zeros(nsample, nsample); % H �ʱ�ȭ; H�� nsample * nsample ����ķ� ����
    for i = 1 : nsample,
        for j = 1 : nsample,
            H(i,j) = X(i)*X(j)*Y(i)*Y(j);  % �߿�
        end
    end
    
    H = H+1e-10*eye(size(H));  % H�� �����ϰ� �ϱ� ���� Ʈ������ �ִ밢���п� 1e-10�� ���Ѵ�. 

    F = -ones(nsample,1);     % F' * Alpha�� �����Լ����� sigma_i(Alpha_i)�� ���õ�

    % �׵� �����(equality constraints) ����
    A = Y';  % sigma_i(Alpha_i * Y_i) = 0
    b = 0;

    % alpha�� ���� ���� ���� ����: LB <= Alpha <= UB
    LB = zeros(nsample,1);     % UB�� LB�� nsample * 1 ����ӿ� ���� 
    UB = C(n)*ones(nsample,1); % 

    % alpha�� ������ 
    Alpha0 = zeros(nsample, 1);

    % QP(quadratic programming)�� alpha ����ȭ 
    Alpha = quadprog(H, F, [], [], A, b, LB, UB, Alpha0);
    % Alpha = qp(H, F, A, b, LB, UB, Alpha0, 1);

    % ����Ʈ ���͸� ���ϴ� ������; ���������� ���� ���İ��� ����.  
    tol = 0.0001;

    % ����ġ(weight) ���
    w = 0;
    for i = 1 : nsample,
        w = w + Alpha(i) * Y(i) * X(i);
    end

    % ���̾ ��� 
    bias = 0;
    b1 = 0;
    b2 = 0;
    for i = 1 : nsample,
	if (Alpha(i) > tol & Alpha(i) < C(n) - tol),
	    b1 = b1 + X(i) * w - Y(i);
            b2 = b2 - 1;
        end
    end
   
    if b2 ~= 0,
        bias = b1 / b2;
    else    % unlikely
        b1 = 0;        
        for i = 1 : nsample,
            if Alpha(i) < tol,
	        b1 = b1 + X(i) * w - Y(i);
                b2 = b2 - 1;
            end
        end
        
	if b2 ~= 0,
	    bias = b1 / b2;
        else    % even unlikelier
	    b1 = 0;
            for i = 1 : nsample,
	        b1 = b1 + X(i) * w - Y(i);
                b2 = b2 - 1;
            end
	    if b2 ~= 0,
	        bias = b1 / b2;
            end
        end
    end

    % margin = 2 / ||w||
    Margin = [Margin, 2 / abs(w)]; % A = [A, v] ������ A��Ŀ� v�� �߰� 

    % ����Ʈ ������ ���� 
    nSV = [nSV, size(find(Alpha > tol), 1)];

    % ���з��� �н� ������ ���� ���
    m = 0;
    e = 0;
    for i = 1 : nsample,
	predict = w * X(i) + bias;    % Y = w * X + b
        if predict >= 0 & Y(i) < 0,
            m = m + 1;
        end
        if predict < 0 & Y(i) >= 0,
            m = m + 1;
        end        
        if Alpha(i) > tol,    % ����Ʈ ���͸��� ��� 
	    e = e + 1 - predict * Y(i);
        end  
    end
    nMis = [nMis, m];
    Err = [Err, e];
end

% trade-off ����ġ(weights) C�� �� ���� ����, �н�����, ���з� ������ ��, ����Ʈ ������ �� �׸���

Z = zeros(size(C));
for i = 1 : size(C, 2)
     Z(i) = i;
end

figure
%plot(Z, Margin);
stem(Z, Margin);
title('����');
xlabel('C(i)');

figure
%plot(Z, Err);
stem(Z, Err);
title('�н� ����');
xlabel('C(i)');

figure
%plot(Z, nMis);
stem(Z, nMis);
title('���з� ������ ��');
xlabel('C(i)');

figure
%plot(Z, nSV);
stem(Z, nSV);
title('Support Vector ��');
xlabel('C(i)');

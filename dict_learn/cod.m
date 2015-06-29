function [Z,num_iter] = cod(X, Wd, S, alpha, thres)
%COD Summary of this function goes here
%   Z = cod(X, Wd, alpha, thres)
% S is mutual inhibation matrix S=I-1/L*Wd'*Wd
% L=largest eig value of Wd'*Wd + 0.1
% Because S doesn't change across dataset, you should supply S yourself
% If you want this programm to calculate S, put in S=0;
  Wd=col_norm(Wd,2);
  if all(S==0)
    %L=max(eig(Wd'*Wd))+0.1;
    S=eye(size(Wd'*Wd))-(Wd'*Wd);
  end
  B=Wd'*X;
  Z=zeros(size(B));
  Zd=Inf;
  num_iter=0;
  while any(abs(Zd(:))>=thres)
    num_iter=num_iter+1;
    Z1=h_theta(B,alpha);
    Zd=Z1-Z;
    k1=find(abs((abs(Zd)-max(abs(Zd))))<eps, 1 );
    B=B+S(:,k1)*(Z1(k1)-Z(k1));
    Z(k1)=Z1(k1);
%     if (num_iter==200)
%       figure,plot(Z1), figure, plot(Wd*Z1), pause;
%     end
  end
  Z=h_theta(B,alpha);
end
%Minimize the function 𝑥(𝑥 − 2), 0 ≤ 𝑥 ≤ 1.5 within the interval of uncertainty 0.25L0
%   Ln/Lo = 1/Fn
%   Ln <= 0.25Lo
%   Ln/L0 <=0.25
%   1/Fn <= 0.25
%   Fn >= 4
%   F0=1 F1=1 F2=2 F2=3 (F4=5) F5=8
%   Therefore n=4

clc
clear all
format short g

f=@(x) x*(x-2)

a=0
b=1.5
n=4

F(1)=1;
F(2)=1;

for i=3:n+1
    F(i)=F(i-1)+ F(i-2)
end

table=[];

for k=1:n
    ratio=F(n+1-k)/F(n+2-k);
    x2 = a + (ratio).*(b-a);
    x1 = b + a -x2;
    fx1=f(x1);
    fx2=f(x2);
    table = [table; a b x1 x2 fx1 fx2]

    if(fx1<fx2)
        b=x2
    else
        a=x1
    end
end

disp(table)

opt=(a+b)/2
optimal_value=f(opt)


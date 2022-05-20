clc
clear all
format rat

%   Uncertainity = 0.25
%   Ln/L0<=0.25
%   1/Fn<=0.25
%   Fn>=4
%   F0=1 F1=1 F2=2 F3=3 F4=5 F5=8

%f=@(x) x*(x-2)
f=@(x) x.^2
a=-5
b=15
n=7
F(1)=1
F(2)=1

for i=3:n+1
    F(i)=F(i-1)+F(i-2);
end

F

table=[]

for k=1:n
    ratio=F(n+1-k)/F(n+2-k)
    x2 = a + (ratio).*(b-a)
    x1 = a + b -x2
    fx1=f(x1)
    fx2=f(x2)
    table = [table; ratio a b x1 x2 fx1 fx2]

    if(fx1<fx2)
        b=x2
    else
        a=x1
    end
end

format short
opt=(a+b)/2
opt_val=f(opt)
%weighted using Big M
%https://cbom.atozmath.com/CBOM/Simplex.aspx?q=sm&q1=3%602%60MAX%60Z%60x1%2cx2%2cx3%602%2c3.5%2c3.5%602%2c4%2c1%3b3%2c5%2c4%60%3c%3d%2c%3e%3d%608%2c15%60%60D%60false%60true%60false%60true%60false%60false%60true&do=1#PrevPart

clc
clear all
format short g

%Maximize (3x1 + 2x2 + 4x3)
%Maximize ( x1 + 5x2 + 3x3)
%S.t.      2x1 + 4x2 +  x3 <=  8;
%          3x1 + 5x2 + 4x3 >= 15;

%convert 
%S.t.      2x1 + 4x2 +  x3 +  s1 + 0s2 + 0a2 =   8;
%          3x1 + 5x2 + 4x3 + 0s1 -  s2 + 1a2 = 15;

%Function becomes:
c1=[3 2 4 0 0]
c2=[1 5 3 0 0]
M=1000
c=(c1+c2)/2
%max -> -M
%min -> +M
c=[c -M]
A=[2 4 1 1 0 0; 3 5 4 0 -1 1]
b=[8; 15]
BV=[4 6]
n=size(A,2)
m=size(A,1)

for i=1:50
    B=A(:, BV)
    cb=c(BV)
    Xb=inv(B)*b
    z=cb*Xb
    Y=inv(B)*A
    zjcj=cb*Y-c
    if(zjcj>=0)
        disp('Optimality Achieved')
        break
    else
        [a,EV]=min(zjcj)
        if all(Y(:,EV))<=0
            error('LPP is unbounded')
            break
        end
        for j=1:m
            if(Y(j,EV)<=0)
                ratio(j)=inf
            else
                ratio(j)=Xb(j)/Y(j,EV)
            end
        end
        [l,LV]=min(abs(ratio))
        BV(LV)=EV
    end 
end

disp('Basic Variables: ')
BV

fprintf("fxn: \n")
c(:,BV)
disp('Cost ')
Xb
disp('optimal value ')
z

zjcj=[inf zjcj z; BV' A Xb]
clc
clear all
format short g
    
%Maximize (1x1 + 4x2 + 1x3)
%Maximize (2x1 + 7x2 + 5x3)
%S.t.      1x1 + 1x2 + 1x3 <=  8;
%          1x1 + 5x2 + 4x3 >= 15;

%convert 
%S.t.      1x1 + 1x2 + 1x3 +  s1 + 0s2 + 0a2 =   8;
%          1x1 + 5x2 + 4x3 + 0s1 - 1s2 + 1a2 = 15;

c1=[1 4 1 0 0]
c2=[2 7 5 0 0]
c=(c1+c2)/2
M=1000
c=[c -M]
A= [1 1 1 1 0 0; 1 5 4 0 -1 1]
b=[8;15]
BV=[4 6]

m=size(A,1)     %rows
n=size(A,2)     %cols


for i=1:5
    B=A(:, BV)
    cb=c(BV)
    Xb=inv(B)*b
    Y=inv(B)*A
    z=cb*Xb
    zjcj=cb*Y-c
    if(zjcj>=0)
        disp('Optimality Achieved')
        break;
    else
        [a,EV]=min(zjcj)
        if all(Y(:,EV))<=0
            disp('LPP is Unbounded')
            break;
        end
        for j=1:m
            if(Y(j,EV)>=0)
                ratio(j)=Xb(j)/Y(j,EV)
            else
                ratio(j)=inf
            end
        end
        
        [l,LV]=min(abs(ratio))
        BV(LV)=EV
    end
end

z
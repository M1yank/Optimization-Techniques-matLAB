clc
clear all
format short

%Min. z = 12x1 + 10x2,
%S.T.     5x1  +  1x2 ≥ 10
%         6x1  +  5x2 ≥ 30
%         1x1  +  4x2 ≥  8
%convert to max
%Max. z = -12x1 - 10x2
%S.T.    -5x1  -  1x2  + s1  = -10
%        -6x1  -  5x2  + s2  = -30
%        -1x1  -  4x2  + s3  = -8

A=[-5 -1 1 0 0; -6 -5 0 1 0; -1 -4 0 0 1]
b=[-10; -30; -8]
c=[-12 -10 0 0 0]
BV=[3 4 5]  
m=size(A,1)         %rows
n=size(A,2)         %cols

for i=1:50
    B=A(:, BV)
    cb=c(BV)
    Xb=inv(B)*b
    z=cb*Xb
    Y=inv(B)*A
    zjcj=cb*Y-c
    
    if(Xb>=0)
        disp('Feasibility Achieved')
        break;
    else
        [a,LV]=min(Xb)
        for j=1:m
            if(Y(LV,j)<0)
                ratio(j)=zjcj(j)/Y(LV,j)
            else
                ratio(j)=inf
            end
        end
        [l,EV]=min(abs(ratio))
        BV(LV)=EV
    end
end

z


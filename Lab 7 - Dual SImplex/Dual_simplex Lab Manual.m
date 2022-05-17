clc
clear all
format short 

%Min. z = 3x1 + 5x2,
%S.T.      x1 + 3x2 ≥ 3 
%          x1 +  x2 ≥ 2
%convert to max
%Max. z = -3x1 - 5x2,
%S.T.     - x1 - 3x2 +  s1 + 0s2 = -3 
%         - x1 -  x2 + 0s1 +  s2 = -2

c=[-3 -5 0 0]
A= [-1 -3 1 0; -1 -1 0 1]
b= [-3; -2]
BV=[3 4]
n=2
m=4


for i=1:50
    B=A(:,BV)
    cb=c(BV)
    Xb=inv(B)*b
    z=cb*Xb
    Y=inv(B)*A
    zjcj=cb*Y-c
    if(Xb>=0)
        disp('Feasibility Achieved')
        break
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
        BV
        BV(LV)
        LV
        EV
        BV(LV)=EV
    end
end
    
disp('Basic Variables: ')
BV

%fprintf("fxn: \n")
cb

disp('Cost ')
Xb

disp('optimal value ')
z

zjcj=[inf zjcj z; BV' Y Xb]

    
    

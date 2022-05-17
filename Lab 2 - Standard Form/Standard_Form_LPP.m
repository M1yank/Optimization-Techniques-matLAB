%Standard form
%min z=1x1+3x2+7x3
%subject t0     2x1+3x2+4x3<=1
            %  1x1+5x2+2x3<=8
            %  2x1+4x2+3x3>=4
            %x1>=0, x2>=0, x3>=0
clc
clear all
format short

C=[ 1, 3, 7];
A=[2 3 4 ;1 5 2; 2 4 3 ];
b=[ 1;8 ; 4];
I=[0,0,1] % give slack(surplus) variable values 0(1)resp, you may assign any value
s=eye(size(A,1)) % eye is command for identity matrix of size constraints in A matrix
index= find(I>0) % position in identity matrix where I>0, to identify surplus contraint
s(index,index)=-s(index,index)% to give sign corresponding to surplus variable
mat=[A s b] %Augumented matrix, columns size should be same
obj=array2table(C); % command to write array to table
obj.Properties.VariableNames(1:size(C,2))={'x_1','x_2','x_3'} % size(C,2) columns in C matrix
cons=array2table(mat);
cons.Properties.VariableNames(1:size(mat,2))={'x_1','x_2','x_3','s1','s2','s3','b'}


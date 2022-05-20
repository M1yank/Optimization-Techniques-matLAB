clc
clear all
format short

cost=[2 10 4 5;6 12 8 11;3 9 5 7]
supply=[12 25 20]
demand=[25 10 15 5]
n=size(cost,1)  %rows
m=size(cost,2)  %columns s


if(sum(supply)==sum(demand))
    disp('balanced problem')
elseif sum(supply)<sum(demand)
    disp('unbalanced problem')
    cost=[cost;zeros(1,m)]
    supply=[supply sum(demand)-sum(supply)]
else
    disp('unbalanced problem')
    cost=[cost zeros(n,1)]
    demand=[demand sum(supply)-sum(demand)]
end

cc=cost;
n=size(cost,1)
m=size(cost,2)
X=zeros(n,m)

for i=1:n
    for j=1:m
        temp=min(cost(:))
        %cost(:) will convert 2d to vector
        [r,c]=find(temp==cost)
        y=min(supply(r),demand(c))
        [val,index]=max(y)
        pos_row=r(index)
        pos_col=c(index)
        X(pos_row,pos_col)=val
        supply(pos_row)=supply(pos_row)-val
        demand(pos_col)=demand(pos_col)-val
        cost(pos_row,pos_col)=inf
    end
end

cc  %original cost
fc=cc.*X
%final_cost=sum(fc(:))
final_cost=sum(fc(:))
%final_cost=sum(final_cost)
X
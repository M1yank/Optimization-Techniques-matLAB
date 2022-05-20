clc
clear all
format short 

cost = [2 10 4 5; 6 12 8 11;3 9 5 7]
supply=[12 25 20]
demand=[25 10 15 5]
n=size(cost,1)
m=size(cost,2)


if(sum(supply)==sum(demand))
    disp('Balanced Problem')
elseif(sum(supply)>sum(demand))
    disp('Unbalanced Problem')
    demand = [demand sum(supply)-sum(demand)]
    cost = [cost zeros(n,1)]
else
    disp('Unbalanced Problem')
    supply = [supply sum(demand)-sum(supply)]
    cost = [cost; zeros(1,m)]
end 

cc = cost
n=size(cost,1)
m=size(cost,2)
X=zeros(n,m)

for i=1:n
    for j=1:m
        temp=min(cost(:))
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

cc
fc=cc.*X

final_cost=sum(fc(:))

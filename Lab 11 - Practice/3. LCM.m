clc
clear all
format short

c=[  3  11  4 14 15 ;... 
     6  16 18  2 28 ;...
    10  13 15 19 17 ;...
     7  12  5  8  9 ]
s=[15 25 10 15]
d=[20 10 15 15 5]
m=size(c,1)             %rows
n=size(c,2)             %cols

if(sum(s)==sum(d))
    disp('Balanced Problem')
elseif(sum(s)>sum(d))
    disp('Unbalanced Problem')
    c=[c zeros(m,1)]
    d = [d sum(s)-sum(d)]
else
    disp('Unbalanced Problem')
    c=[c; zeros(1,n)]
    s = [s sum(d)-sum(s)]
end

cc=c;
m=size(c,1)             %rows
n=size(c,2)             %cols
X=zeros(m,n)

B=[cc s'; d inf]

for i=1:m
    for j=1:n
        temp=min(c(:))
        [row,col]=find(c==temp)
        y=min(s(row),d(col))
        [val,index]=max(y)
        pos_row=row(index)
        pos_col=col(index)
        X(pos_row, pos_col)=val
        d(pos_col)=d(pos_col)-val
        s(pos_row)=s(pos_row)-val
        c(pos_row, pos_col)=inf
    end
end

fc=cc.*X
f=sum(fc(:))

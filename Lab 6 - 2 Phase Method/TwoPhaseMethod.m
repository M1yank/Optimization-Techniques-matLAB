%% Two Phase Method
% Question: 
%           Min Z= 3x1 + 5x2
%           S.T.    x1 + 3x2 >= 3
%                   x1 +  x2 >= 2
%                   x1 ,  x2 >= 0
%% Introducing slack and artificial Variables
% Question: 
%           Min Z= 3x1 + 5x2 + 0s1 + 0s2 -  a1 -  a2
%           S.T.    x1 + 3x2 -  s1 + 0s2 +  a1 + 0a2 = 3
%                   x1 +  x2 + 0s1 - 1s2 + 0a1 +  a2 = 2
%                   x1 ,  x2 , s1, s2, a1, a2 >= 0
%% Input
format short
clear all
clc

Variables = {'x_1', 'x_2', 's_1', 's_2', 'a_1', 'a_2', 'Sol'}
OVariables = {'x_1', 'x_2', 's_1', 's_2', 'Sol'}
OrigC = [ 3 5 0 0 -1 -1 0]
Info = [1 3 -1 0 1 0 3; 1 1 0 -1 0 1 2]
BV = [5 6]

%% Phase I
Cost = [0 0 0 0 -1 -1 0] %%% Cost of Phase I
A= Info
StartBV = find(Cost<0)

%%% Compute Zj - Cj
ZjCj = Cost(BV)*A - Cost
InitialTable = array2table( [ ZjCj;A ]);
InitialTable.Properties.VariableNames (1:size(A,2)) = Variables

fprintf("***************************************\n")
fprintf("*********** PHASE I STARTS ************\n")
fprintf("***************************************\n")


%%%% Start Loop
RUN = true;
while RUN
ZC = ZjCj(:, 1:end-1);
if any(ZC<0)           %%% Check any negative value
    
    %%% Entering Variable
    [EnterCOl pvt_col] = min(ZC)
    fprintf('Entering Column = %d \n', pvt_col)
    
    %%% Leaving Variable
    sol = A(:, end)
    Column = A(:, pvt_col)
    if Column<0
        fprintf('Unbounded Solution\n')
    else
        for i=1:size(A,1)
            if Column(i)>0
                ratio(i) =sol(i)./Column(i)
            else
                ratio(i)=inf
            end
        end
        [MinRatio, pvt_row] = min(ratio)
        fprintf('Leaving Row = %d \n', pvt_row)
    end
    %%% Update the BFS
    BV(pvt_row) = pvt_col
    
    %%% Pivot Key
    pvt_key = A(pvt_row, pvt_col)
    
    %%% Updating the Entries
    A(pvt_row, :) = A(pvt_row,:)./pvt_key
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)= A(i,:) - A(i,pvt_col).*A(pvt_row,:)
        end
    end
    ZjCj = ZjCj - ZjCj(pvt_col).*A(pvt_row,:)
    
    %Printing
    ZCj = Cost(BV)*A - Cost
    InitialTable = array2table( [ ZCj;A ]);
    InitialTable.Properties.VariableNames (1:size(ZCj,2)) = Variables
    
    %Loop
    BFS(BV)=A(:,end)
else
    RUN= false;
    fprintf('Current BFS is best\n')
    fprintf('Phase end\n')
    BFS=BV;
    fprintf('Optimal Solution reached \n\n')
end
%else
    
end

%% Phase II
fprintf("***************************************\n")
fprintf("*********** PHASE II STARTS ***********\n")
fprintf("***************************************\n")

A(:, StartBV)=[]
OrigC(:,StartBV)=[]
Cost = OrigC
BV=BFS
Variables = OVariables
%%%% Start Loop
RUN = true;
while RUN
ZC = ZjCj(:, 1:end-1);
if any(ZC<0)           %%% Check any negative value
    
    %%% Entering Variable
    [EnterCOl pvt_col] = min(ZC)
    fprintf('Entering Column = %d \n', pvt_col)
    
    %%% Leaving Variable
    sol = A(:, end)
    Column = A(:, pvt_col)
    if Column<0
        fprintf('Unbounded Solution\n')
    else
        for i=1:size(A,1)
            if Column(i)>0
                ratio(i) =sol(i)./Column(i)
            else
                ratio(i)=inf
            end
        end
        [MinRatio, pvt_row] = min(ratio)
        fprintf('Leaving Row = %d \n', pvt_row)
    end
    %%% Update the BFS
    BV(pvt_row) = pvt_col
    
    %%% Pivot Key
    pvt_key = A(pvt_row, pvt_col)
    
    %%% Updating the Entries
    A(pvt_row, :) = A(pvt_row,:)./pvt_key
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)= A(i,:) - A(i,pvt_col).*A(pvt_row,:)
        end
    end
    ZjCj = ZjCj - ZjCj(pvt_col).*A(pvt_row,:)
    
    %Printing
    ZCj = Cost(BV)*A - Cost
    InitialTable = array2table( [ ZCj;A ]);
    InitialTable.Properties.VariableNames (1:size(ZCj,2)) = Variables
    
    %Loop
    BFS(BV)=A(:,end)
else
    RUN= false;
    fprintf('Current BFS is best\n')
    fprintf('Phase end\n')
    BFS=BV;
    fprintf('Optimal Solution reached \n\n')
end
%else
    
end

%% Value of optimal Solution
FINAL_BFS=zeros(1,size(A,2));
FINAL_BFS(BFS)=A(:,end);
FINAL_BFS(end)=sum(FINAL_BFS.*OrigC);

OptimalBFS = array2table( FINAL_BFS );
OptimalBFS.Properties.VariableNames (1:size(OptimalBFS,2)) = OVariables



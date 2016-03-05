clear all;
close all;
clc;
format long;

clients=2:10;
for i=1:length(clients)
    client=clients(i);
    if client<10
        dataAll=dlmread(sprintf('client-0%d_03040700.csv', client),',',1,0);
    elseif client==10
        dataAll=dlmread(sprintf('client-%d_03040700.csv', client),',',1,0);
    end
    dataTime(:,i)=dataAll(:,1);
    data{i}=[dataAll(:, 4:5) dataAll(:,7)];
end
dataTime=round(dataTime);
clientData=[];

indexes=ones(1, length(clients));
while length(indexes)>0
    d=[];
    idx=sub2ind(size(dataTime), indexes, 1:size(dataTime, 2));
    TS=dataTime(idx);
    minTS=min(TS);
    minIdx=(TS==minTS);
    d=minTS;
    da=[];
    for j=1:length(minIdx)
        if minIdx(j)==1
            ds=data{j};
            cj=mod(idx(j), 1200);
            if cj==0
                cj=1200;
            end
            da=[da; ds(cj,:)];
        end
    end
    if size(da,1)>1
        da=mean(da);
    end
    d=[d da];
    if size(clientData,1)>0 
        if (minTS==clientData(end,1))
            clientData(end,2:4)=(clientData(end,2:4)+d(2:4))/2;
        else
            clientData=[clientData; d];
        end
    else
        clientData=[clientData; d];
    end
    indexes=indexes+minIdx;
    checkIdx=(indexes>size(dataTime,1));
    if sum(checkIdx)>0
        indexes(checkIdx)=[];
        data(checkIdx)=[];
        data=data(~cellfun('isempty',data));
        dataTime(:, checkIdx)=[];
    end
    mds=sum(minIdx);
end

TS=clientData(:,1);
QoE1=clientData(:,2);
QoE2=clientData(:,3);
responseTime=clientData(:,4);
save('QoE10', 'responseTime', 'TS', 'QoE1','QoE2');
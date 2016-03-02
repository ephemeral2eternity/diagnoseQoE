clear all;
close all;
clc;
format long;

files=char('client-09_03012047');
num=size(files, 1);
for i=1:num
    name=files(i,:);
    dataAll=dlmread(sprintf('../exps/data/%s.csv', name),',',1,0);
    responseTime=dataAll(:,7);
    TS=dataAll(:,1);
    QoE1=dataAll(:,4);
    QoE2=dataAll(:,5);
    save('QoE2047', 'responseTime', 'TS', 'QoE1','QoE2');
end
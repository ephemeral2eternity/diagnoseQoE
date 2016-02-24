clear all;
close all;
clc;

QoE=loadjson('client-09_02221401.json');
nums=0:119;
for i=1:length(nums)
    num=nums(i);
    if num<10
        strs=sprintf('x0x3%d_', num);
    elseif num<100
        strs=sprintf('x0x3%d_%d',  (num-mod(num,10))/10, mod(num,10));
    elseif num==100
        strs=sprintf('x0x3%d_%d0',  (num-mod(num,100))/100, mod(num,100));
    elseif num<999
        strs=sprintf('x0x3%d_%d',  (num-mod(num,100))/100, mod(num,100));
    end
    dataAll=eval(sprintf('QoE.%s', strs));
    responseTime(i)=dataAll.Response;
    QoE1(i)=dataAll.QoE1;
    QoE2(i)=dataAll.QoE2;
end
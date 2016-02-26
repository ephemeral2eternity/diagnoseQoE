close all;
clear all;
clc;

load('metrics');
load('QoE');
TS=TS-mod(TS,1);
[value,xindex]=intersect(metricsTime,TS);
X=metrics(xindex,:);
[Y,index]=intersect(TS, value);
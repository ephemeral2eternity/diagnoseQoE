close all;
clear all;
clc;

load('metrics');
load('QoE');
TS=TS-mod(TS,1);
[value,xindex]=intersect(metricsTime,TS);
X=metrics(xindex,:);
[yvalue, yindex]=intersect(TS, value);
Y=responseTime(yindex)';

t=100;
B=LassoActiveSet(X,Y,t);

figure;
plot(Y-X*B, 'r-');
ylabel('testing error');
xlabel('time');
figfile=sprintf('error');
print(figfile,'-dpng','-r800');

figure;
plot(Y, 'g*-');hold on;
plot(X*B, 'bo-');
legend('real', 'estimated');
ylabel('response time');
xlabel('time');
figfile=sprintf('compare');
print(figfile,'-dpng','-r800');
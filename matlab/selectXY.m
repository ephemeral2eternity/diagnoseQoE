close all;
clear all;
clc;

load('all47');
load('QoE2047');
TS=TS-mod(TS,1);
[value,xindex]=intersect(metricsTime,TS);
X=metrics(xindex,:);
[yvalue, yindex]=intersect(TS, value);
Y=responseTime(yindex);

trainTimes=10:10:200;
for i=1:length(trainTimes)
    t=trainTimes(i);
    trainX=X(1:t,:);
    trainY=Y(1:t);
    tic;
    B=LassoActiveSet(trainX,trainY,t);
    tt(i)=toc;
    trainEABS(i)=mean(trainX*B-trainY);
    trainEREL(i)=mean((trainX*B-trainY)./trainY);
%     figure;
%     subplot(2,1,1);
%     plot(trainY-trainX*B, 'r-');
%     ylabel('training error');
%     xlabel('time');
%     % figfile=sprintf('trainerror');
%     % print(figfile,'-dpng','-r800');
%     subplot(2,1,2);
%     plot(trainY, 'g*-');hold on;
%     plot(trainX*B, 'bo-');
%     legend('real', 'estimated');
%     ylabel('response time');
%     xlabel('time');
    % figfile=sprintf('compare');
    % print(figfile,'-dpng','-r800');
    tic
    testY=Y(t+1:end);
    testX=X(t+1:end,:);
    testEABS(i)=mean(testY-testX*B);
    testEREL(i)=mean((testX*B-testY)./testY);
    pt(i)=toc/(length(Y)-t);
end

figure;
plot(trainTimes, trainEABS, 'g*-'); hold on;
plot(trainTimes, testEABS, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Absolute Error');
xlabel('Training Time (s)');
figfile=sprintf('absolute_error');
print(figfile,'-dpng','-r800');

figure;
plot(trainTimes, trainEREL, 'g*-'); hold on;
plot(trainTimes, testEREL, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Relative Error');
xlabel('Training Time (s)');
figfile=sprintf('absolute_error');
print(figfile,'-dpng','-r800');

figure;
plot(trainTimes, tt, 'g*-'); hold on;
plot(trainTimes, pt, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Computation Time (s)');
xlabel('Training Time (s)');
figfile=sprintf('computation_time');
print(figfile,'-dpng','-r800');

%     figure;
%     plot(testY-testX*B, 'r-');
%     ylabel('testing error');
%     xlabel('time');
%     % figfile=sprintf('error');
%     % print(figfile,'-dpng','-r800');
% 
%     figure;
%     plot(testY, 'g*-');hold on;
%     plot(testX*B, 'bo-');
%     legend('real', 'estimated');
%     ylabel('response time');
%     xlabel('time');
%     % figfile=sprintf('compare');
%     % print(figfile,'-dpng','-r800');
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
N=length(Y);

trainTimes=10:10:200;
for i=1:length(trainTimes)
    wint=trainTimes(i);
    for t=1:N-wint
        trainX=X(t:t+wint-1,:);
        trainY=Y(t:t+wint-1);
        tic;
        B=LassoActiveSet(trainX,trainY,10);
        tt(t)=toc;
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
        tic;
        testY=Y(t+wint);
        testX=X(t+wint,:);
        testE(t)=testY-testX*B;
        pt(t)=toc;
    end
    traint(i)=mean(tt);
    testt(i)=mean(pt);
    trainEABS(i)=mean(trainX*B-trainY);
    trainEREL(i)=mean((trainX*B-trainY)./trainY);
    testEABS(i)=mean(testY-testX*B);
    testEREL(i)=mean((testX*B-testY)/testY);
end

figure;
plot(trainTimes, trainEABS, 'g*-'); hold on;
plot(trainTimes, testEABS, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Absolute Error');
xlabel('Training Time (s)');
figfile=sprintf('absolute_error_window');
print(figfile,'-dpng','-r800');

figure;
plot(trainTimes, trainEREL, 'g*-'); hold on;
plot(trainTimes, testEREL, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Relative Error');
xlabel('Training Time (s)');
figfile=sprintf('absolute_error_window');
print(figfile,'-dpng','-r800');

figure;
plot(trainTimes, traint, 'g*-'); hold on;
plot(trainTimes, testt, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Computation Time (s)');
xlabel('Training Time (s)');
figfile=sprintf('computation_time_window');
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
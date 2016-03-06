close all;
clear all;
clc;

load('all20');
load('QoE20');
TS=TS-mod(TS,1);
[value,xindex]=intersect(metricsTime,TS);
X=metrics(xindex,:);
[yvalue, yindex]=intersect(TS, value);
Y=responseTime(yindex);
QoE1=QoE1(yindex);
QoE2=QoE2(yindex);
N=length(Y);

figure;
plot(responseTime);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
ylabel('Response Time (s)');
xlabel('Time (s)');
figfile=sprintf('rt_withanomaly');
print(figfile,'-dpng','-r800');


trainTimes=20;
for i=1:length(trainTimes)
    wint=trainTimes(i);
    for t=wint+1:N
        trainX=X(t-wint:t-1,:);
        trainY=Y(t-wint:t-1);
        tic;
        B=LassoActiveSet(trainX,trainY,24);
        tt(t)=toc;
        
        tic;
        testY=Y(t);
        testX=X(t,:);
        pt(t)=toc;
        
        real(t)=testY;
        estimate(t)=max(testX*B,0);
        trainEABS(t)=mean(abs(trainX*B-trainY));
        trainEREL(t)=mean(abs((trainX*B-trainY))./trainY);
        testEABS(t)=mean(testY-testX*B);
        testEREL(t)=mean((testX*B-testY)./testY);
    end
    figure;
    subplot(2,1,1);
    plot(trainEABS, 'g-'); hold on;
    plot(testEABS, 'r-');
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylim([-0.5 0.5]);
    ylabel('Absolute Error');
    xlabel('time');
    subplot(2,1,2);
    plot(trainEREL*100, 'g-');hold on;
    plot(testEREL*100, 'r-');
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylim([-100 100]);
    legend('train', 'test');
    ylabel('Relative Error (%)');
    xlabel('time');
    figfile=sprintf('error_anomaly_window');
    print(figfile,'-dpng','-r800');
    
    figure;
    plot(real, 'g-'); hold on;
    plot(estimate, 'r-');
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylim([0 2]);
    legend('real', 'estimate');
    ylabel('Response Time');
    xlabel('time');
    figfile=sprintf('error_anomaly_window');
    print(figfile,'-dpng','-r800');
    
    figure;
    xa=1:length(estimate);
    [hAx,hLine1,hLine2] = plotyy(xa, estimate, xa, QoE2);
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    hLine1.LineStyle = '--';
    hLine2.LineStyle = ':';
    xlabel('Time (sec)')
    ylabel(hAx(1),'Estimated Response Time') % left y-axis
    ylabel(hAx(2),'QoE2') % right y-axis
    figfile=sprintf('estimate_qoe2_window');
    print(figfile,'-dpng','-r800');
%     tic
%     testY=Y(t+1:end);
%     testX=X(t+1:end,:);
%     testEABS(i)=mean(testY-testX*B);
%     testEREL(i)=mean((testX*B-testY)./testY);
%     pt(i)=toc/(length(Y)-t);
    
%     figure;
%     subplot(2,1,1);
%     plot(testY-testX*B, 'r-');
%     ylabel('testing error');
%     xlabel('time');
%     % figfile=sprintf('trainerror');
%     % print(figfile,'-dpng','-r800');
%     subplot(2,1,2);
%     plot(testY, 'g*-');hold on;
%     plot(testX*B, 'bo-');
%     legend('real', 'estimated');
%     ylabel('response time');
%     xlabel('time');
%     figfile=sprintf('testing_window');
%     print(figfile,'-dpng','-r800');
end
return;
figure;
plot(trainTimes, trainEABS, 'g*-'); hold on;
plot(trainTimes, testEABS, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Absolute Error');
xlabel('Training Time (s)');
figfile=sprintf('absolute_error_withanomaly');
print(figfile,'-dpng','-r800');

figure;
plot(trainTimes, trainEREL, 'g*-'); hold on;
plot(trainTimes, testEREL, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Relative Error');
xlabel('Training Time (s)');
figfile=sprintf('absolute_error_withanomaly');
print(figfile,'-dpng','-r800');

figure;
plot(trainTimes, tt, 'g*-'); hold on;
plot(trainTimes, pt, 'ro-');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
legend('training', 'testing');
ylabel('Computation Time (s)');
xlabel('Training Time (s)');
figfile=sprintf('computation_time_withanomaly');
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
clc;
close all;

load results;
responseTime=responseTime(yindex);
RTS=TS(yindex);
RTS=RTS-RTS(1)+1;
figure;
plot(RTS, responseTime);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);

figure;
plot(RTS, QoE2);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);

%% group 1 experiments
anomalies=char('CPU1', 'CPU2', 'CPU3','Disk1','Disk2','Disk3','Mem1','Mem2');
T1=900;
startTime=1;
ind0=min(find(RTS>=startTime));
for i=1:8
    ind1=min(find(RTS>=startTime+T1*i));
    figure;
    subplot(2,1,1);
    plot(RTS(ind0:ind1), QoE2(ind0:ind1));
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylabel('QoE2');
    xlabel('Time (s)');
    title(sprintf('QoE2 under %s anomaly', anomalies(i,:)));
    subplot(2,1,2);
    plot(RTS(ind0:ind1), responseTime(ind0:ind1));
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylabel('Response Time (s)');
    xlabel('Time (s)');
    ylim([0 10]);
    title(sprintf('Response time under %s anomaly', anomalies(i,:)));
    figfile=sprintf('graphs/QoE2RT_%s', anomalies(i,:));
    print(figfile,'-dpng','-r800');
    ind0=ind1;
end

for i=1:8
    ind1=min(find(RTS>=startTime+T1*i));
    figure;
    subplot(2,1,1);
    plot(RTS(ind0:ind1), QoE2(ind0:ind1));
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylabel('QoE2');
    xlabel('Time (s)');
    title(sprintf('QoE2 under %s anomaly', anomalies(i,:)));
    subplot(2,1,2);
    plot(RTS(ind0:ind1), estimate(ind0:ind1));
    set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
    ylabel(' Estimated Response Time (s)');
    xlabel('Time (s)');
    ylim([0 10]);
    title(sprintf('Estimated response time under %s anomaly', anomalies(i,:)));
    figfile=sprintf('graphs/QoE2EstimatedRT_%s', anomalies(i,:));
    print(figfile,'-dpng','-r800');
    ind0=ind1;
end

xtt=value-value(1)+1;
figure;
plot(xtt, tt);
set(gca, 'FontName', 'Times New Roman', 'FontSize', 18);
ylabel('Training Time (s)');
xlabel('Time');
title('Cost time for training the model');
figfile='graphs/traintime';
print(figfile,'-dpng','-r800');
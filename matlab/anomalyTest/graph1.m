clc;

load results;
responseTime=responseTime(yindex);
RTS=TS(yindex);
RTS=RTS-RTS(1)+1;
figure;
plot(RTS, responseTime);

figure;
plot(RTS, QoE2);
return;
%% group 1 experiments
T1=900;
startTime=1;
ind0=min(find(RTS>=startTime));
for i=1:4
    ind1=min(find(RTS>=startTime+T1*i));
    figure;
    subplot(2,1,1);
    plot(RTS(ind0:ind1), QoE2(ind0:ind1));
    subplot(2,1,2);
    plot(RTS(ind0:ind1), responseTime(ind0:ind1));
    startTime=startTime+900;
    ind0=min(find(RTS>=startTime));
end

%% group 2 plot
T2=1800;
startTime=4201;
ind0=min(find(RTS>=startTime));
for i=1:4
    ind1=min(find(RTS>=startTime+T2*i));
    figure;
    subplot(2,1,1);
    plot(RTS(ind0:ind1), QoE2(ind0:ind1));
    subplot(2,1,2);
    plot(RTS(ind0:ind1), responseTime(ind0:ind1));
    startTime=startTime+T2;
    ind0=min(find(RTS>=startTime));
end

%% group 2 plot
T3=2100;
startTime=11101;
ind0=min(find(RTS>=startTime));
for i=1:4
    ind1=min(find(RTS>=startTime+T3*i));
    figure;
    subplot(2,1,1);
    plot(RTS(ind0:ind1), QoE2(ind0:ind1));
    subplot(2,1,2);
    plot(RTS(ind0:ind1), responseTime(ind0:ind1));
    startTime=startTime+1800;
    ind0=min(find(RTS>=startTime));
end

%ylim([0 10]);
%xlim([350 450]);
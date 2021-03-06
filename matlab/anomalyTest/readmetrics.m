clear all;
close all;
clc;

files=char('all2007');
num=size(files, 1);
for i=1:num
    name=files(i,:);
    c=char();
    [a,b]=xlsread(sprintf('%s.csv', name),1,'A4:A8643');
    c=cell2mat(b);
    s=datenum(c(:,4:end),'mmm dd HH:MM:SS');
    date=datestr(s,'dd/mm/2016');
    time=datestr(s,'HH:MM:SS');
    strtime=strcat(date,time);
    t=datevec(strtime,'dd/mm/yyyyHH:MM:SS');
    tepo=datevec('01/01/197000:00:00','dd/mm/yyyyHH:MM:SS');
    t0=ones(size(t))*diag(tepo);
    metricsTime=etime(t,t0)+1;
    metrics=dlmread(sprintf('%s.csv', name), ',', 3, 1);
    metrics=metrics(1:length(metricsTime),:);
    save(name, 'metrics','metricsTime');
end
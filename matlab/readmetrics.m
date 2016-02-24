clear all;
close all;
clc;

files=char('metrics');
num=size(files, 1);
for i=1:num
    name=files(i,:);
    metrics=dlmread(sprintf('%s.csv', name), ',', 2, 1);
    save(name);
end
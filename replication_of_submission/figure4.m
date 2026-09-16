
clear all
clc

addpath('functions')
addpath('data')

mc=xlsread('results.xls','figure4');

subplot(2,2,1)
plot([1,1],get(gca,'ylim'))
hold on
plot(xlim,[0.1,0.1])
hold on 
scatter(mc(:,1),mc(:,2))   

subplot(2,2,2)
plot([1,1],get(gca,'ylim'))
hold on
plot(xlim,[0.1,0.1])
hold on 
scatter(mc(:,1),mc(:,3))

subplot(2,2,3)
plot([1,1],get(gca,'ylim'))
hold on
plot(xlim,[0.1,0.1])
hold on 
scatter(mc(:,4),mc(:,5))

subplot(2,2,4)
plot([1,1],get(gca,'ylim'))
hold on
plot(xlim,[0.1,0.1])
hold on 
scatter(mc(:,4),mc(:,6))
 
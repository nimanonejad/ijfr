
clear all
clc

% mtstream=RandStream('mt19937ar');
% RandStream.setDefaultStream(mtstream);

addpath('functions')
addpath('data')

mc=xlsread('results.xls','figure6_supp');

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
scatter(mc(:,3),mc(:,4))

subplot(2,2,3)
plot([1,1],get(gca,'ylim'))
hold on
plot(xlim,[0.1,0.1])
hold on 
scatter(mc(:,5),mc(:,6))

subplot(2,2,4)
plot([1,1],get(gca,'ylim'))
hold on
plot(xlim,[0.1,0.1])
hold on 
scatter(mc(:,7),mc(:,8))
 
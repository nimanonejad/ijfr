
clear all
clc

% mtstream=RandStream('mt19937ar');
% RandStream.setDefaultStream(mtstream);

addpath('functions')
addpath('data')

mc=xlsread('results.xls','figure7_supp');

subplot(3,2,1)
bar(mc(:,1))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})

subplot(3,2,2)
bar(mc(:,2))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})

subplot(3,2,3)
bar(mc(:,3))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})

subplot(3,2,4)
bar(mc(:,4))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})

subplot(3,2,5)
bar(mc(:,5))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})

subplot(3,2,6)
bar(mc(:,6))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
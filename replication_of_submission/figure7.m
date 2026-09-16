
clear all
clc

addpath('functions')
addpath('data')

mc=xlsread('results.xls','figure7');

subplot(2,2,1)
barh(mc(:,1))
set(gca,'YTick',1:18,'YTickLabel',{'Macrun1m','Macrun3m','Macrun12m','Finaun1m','Finaun3m','Finaun12m','Realun1m','Realun3m','Realun12m',...
    'T-bill','Kilian','Epu','Gpr','Vol','Emv','Commodity','Petroluem','Spread'})

subplot(2,2,2)
barh(mc(:,3))
set(gca,'YTick',1:18,'YTickLabel',{'Macrun1m','Macrun3m','Macrun12m','Finaun1m','Finaun3m','Finaun12m','Realun1m','Realun3m','Realun12m',...
    'T-bill','Kilian','Epu','Gpr','Vol','Emv','Commodity','Petroluem','Spread'})

subplot(2,2,3)
barh(mc(:,2))
set(gca,'YTick',1:18,'YTickLabel',{'Macrun1m','Macrun3m','Macrun12m','Finaun1m','Finaun3m','Finaun12m','Realun1m','Realun3m','Realun12m',...
    'T-bill','Kilian','Epu','Gpr','Vol','Emv','Commodity','Petroluem','Spread'})

subplot(2,2,4)
barh(mc(:,4))
set(gca,'YTick',1:18,'YTickLabel',{'Macrun1m','Macrun3m','Macrun12m','Finaun1m','Finaun3m','Finaun12m','Realun1m','Realun3m','Realun12m',...
    'T-bill','Kilian','Epu','Gpr','Vol','Emv','Commodity','Petroluem','Spread'})





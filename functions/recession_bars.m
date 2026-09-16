% Camilo Marchesini, in response to Julie's question on Dynare forum.


min_idx=min(find(Recessions(:,1)-xlimits(1)>=0));

Recessions=Recessions(min_idx:end,:);

if  Recessions(1,1)<xlimits(1)
    Recessions(1,1)=xlimits(1);
end


if  Recessions(end,end)>xlimits(2)
    Recessions(end,end)=xlimits(2);
end

%ylimits=get(gca,'YLim'); % Get axis.
ylimits=[-800,800]; % Get axis.
 
% Put recessions dates as bars.
for iiii=1:1:size(Recessions,1)

    % Full grey area, without edges.
    patch([Recessions(iiii,1),Recessions(iiii,2),Recessions(iiii,2),Recessions(iiii,1)]',...
        [ylimits(1) ylimits(1) ylimits(2) ylimits(2)]',[0.8 0.8 0.8],'EdgeColor','none'); hold on
    
    % Edges at bottom.
    patch([Recessions(iiii,1),Recessions(iiii,2),Recessions(iiii,2),Recessions(iiii,1)]',...
        [ylimits(1) ylimits(1) ylimits(1) ylimits(1)]',[0.8 0.8 0.8]); hold on
    
    % Edges at top.
    patch([Recessions(iiii,1),Recessions(iiii,2),Recessions(iiii,2),Recessions(iiii,1)]',...
        [ylimits(2) ylimits(2) ylimits(2) ylimits(2)]',[0.8 0.8 0.8]); hold on
    
    
    % Edges left if first recession date is equal to initial date. 
    if Recessions(1)<=xlimits(1) && iiii==1
    patch([xlimits(1),xlimits(1),xlimits(1),xlimits(1)]',...
        [ylimits(1) ylimits(1) ylimits(2) ylimits(2)]',[0.8 0.8 0.8]); hold on
    end
    

    % Edges right if last recession date is equal to final date.
    if Recessions(end)>=xlimits(2) && iiii==size(Recessions,1)
    patch([xlimits(2),xlimits(2),xlimits(2),xlimits(2)]',...
        [ylimits(1) ylimits(1) ylimits(2) ylimits(2)]',[0.8 0.8 0.8]); hold on
    end
    
    
end


 
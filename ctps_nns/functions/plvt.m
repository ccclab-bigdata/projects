function S=plvt(data,varargin)
%% This functions is for plotting mean and variance for time series



display(num2str(nargin));

if nargin<2
    opts.color='r'
    
    opts.facealpha=0.2;
    opts.linecolor='k';
elseif nargin<3
    opts.color=varargin{1};
    opts.facealpha=0.2;
    opts.linecolor='k';
elseif nargin<4
    opts.color=varargin{1};
    opts.facealpha=varargin{2};
    opts.linecolor='k';
else
    opts.color=varargin{1};
    opts.facealpha=varargin{2};
    opts.linecolor=varargin{3};
end
    
    
x=1:size(data,2);
y=mean(data);
sy=std(data)
% Now make the 'line' (actually a surface)...
z = zeros(size(x));
S = surface([x;x],[y-sy;y+sy],[z;z],...
            'facecol',opts.color,...
            'edgecol','interp',...
            'linew',2,...
            'edgealpha',.2,...
            'facealpha',opts.facealpha,...
            'edgecolor','no');
        hold on
%         S2 = surface([x;x],[y;y],[z;z],...
%             'facecol','no',...
%             'edgecol','interp',...
%             'linew',2,...
%             'edgealpha',.7,...
%             'facealpha',.2,...
%             'edgecolor',opts.linecolor);

plot(x,y,'k','LineWidth',2)

end

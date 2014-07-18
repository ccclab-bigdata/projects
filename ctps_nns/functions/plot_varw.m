function [hfill, l1]=plot_varw(data,varargin)



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
sy=std(data);
yms=y-sy;
% Now make the 'line' (actually a surface)...
z = zeros(size(x));
hfill=fill([x x(end:-1:1)],[y+sy yms(end:-1:1)],'k','FaceColor',opts.color,'EdgeColor','none');
%set( harea, 'FaceColor', opts.color)
alpha(hfill,opts.facealpha);
l1=plot(x,y,'k','LineWidth',2);

%l1=plot(x,y,'Color',opts.color,'LineWidth',2)



end
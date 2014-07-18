function f=raise(g,ratio)
% f=raise(g,ratio)
%	Will add linearly raising term to columns of g to make it
%	suitable for plotting.
%	Ratio = raise of each column/(range of data in g), default=1
%	If ratio<0, then the -ratio will be added to each column. 
if nargin < 2, ratio=1; end;
[r,c]=size(g);
if ratio>=0,
  xr=ratio*(max(max(g)) - min(min(g)));
else
  xr=-ratio;
end
f=g + ones(r,1)*(0:c-1)*xr;

end
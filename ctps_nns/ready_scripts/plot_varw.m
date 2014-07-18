function st=plot_varw(m,s,param)

if isfield(param,'color')
    color=param.color;
else
    color='r'
end

if isfield(param,'linewidth')
    linewidth=param.linewidth;
else
    linewidth=2;
end

s1=m+s;
s2=m-s;
lm=length(m);
a1=[1:lm lm:-1:1];
a2=[s1 ; s2(lm:-1:1)]';

st.ch(1)=fill(a1,a2,color,'EdgeColor','none');
hold on
st.ch(2)=plot(1:lm,m,'--k','LineWidth',linewidth);
hold off



end
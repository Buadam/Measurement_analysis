function plot_dmdH(data,conv,shift_dmdH,n,col,leg)

mH=[data(:,3),data(:,5)];
dmdH=diff(mH(:,2))./diff(mH(:,1));


hold all
box on
grid on

plot(mH(1:end-1,1),dmdH*conv+n*shift_dmdH,'ko-','MarkerSize',1,'Color',col,'DisplayName',leg);
legend('-DynamicLegend');
xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (\mu_B/f.u./Oe)')

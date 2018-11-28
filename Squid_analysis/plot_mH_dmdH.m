function plot_mH_dmdH(data,conv,shift_mH,shift_dmdH,n,col,leg)

mH=[data(:,3),data(:,5)];
dmdH=diff(mH(:,2))./diff(mH(:,1));


subplot(2,1,1)
hold all
box on
grid on
plot(mH(:,1),mH(:,2)*conv+n*shift_mH,'o-','MarkerSize',1,'Color',col,'DisplayName',leg);
legend('-DynamicLegend');
xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(\mu_B/f.u.)')


subplot(2,1,2)
hold all
box on
grid on

plot(mH(1:end-1,1),dmdH*conv+n*shift_dmdH,'ko-','MarkerSize',1,'Color',col,'DisplayName',leg);
legend('-DynamicLegend');
xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (\mu_B/f.u./Oe)')

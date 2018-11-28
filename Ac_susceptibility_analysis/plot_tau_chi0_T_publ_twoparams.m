function plot_tau_chi0_T_publ_twoparams(hFig,fr,B0,params,params2)
%physical parameters
m=23.4e-3; %g
M=530.02; %g/mol


cc=jet(7);

%Fitted parameters

tau=params(:,2);
tau2=params2(:,2);

chi0_im=params(:,4);
chi0_re=params2(:,4);


yl1min=min([10^(min([-4,round(log10(min(tau)))])),10^(min([-4,round(log10(min(tau2)))]))]);
yl1max=max([10^(max([-4,round(log10(max(tau)))])),10^(max([-4,round(log10(max(tau2)))]))]);
yl1=[yl1min,yl1max];

yl2min=min([0.95*(min(chi0_re)),0.95*(min(chi0_im))]);
yl2max=max([1.05*(max(chi0_re)),1.05*(max(chi0_im))]);
yl2=[yl2min,yl2max]/m*M;
Yt1=[1e-7,1e-6,1e-5,1e-4,1e-3,1e-2,1e-1,1,10,100,1000,1e4,1e5,1e6,1e7];
%Yt2=linspace(0,ceil(max(chi0_re)/m*M),5)';


[hax,Line1,Line2]=plotyy([B0/10,B0/10],[tau,tau2],[B0/10,B0/10],[chi0_im/m*M,chi0_re/m*M]);
%[hax,Line3,Line4]=plotyy(B0/10,tau2,B0/10,chi0_re/m*M);
linkaxes(hax,'x')
hold on


for f=1:7
    plot([B0(1)/10,B0(end)/10],[1/fr(f),1/fr(f)],'--','Color',cc(f,:))
end

set(hax(1),'YScale','log','Ylim',yl1,'YTick',Yt1)
set(hax(2),'YScale','lin','Ylim',yl2)

set(Line1(1),'Marker','.','MarkerSize',10,'Color','b')
set(Line1(2),'Marker','.','MarkerSize',10,'Color','r')
set(Line2(1),'Marker','.','MarkerSize',10,'Color','[0.7,0.7,0.7]','LineStyle','-')
set(Line2(2),'Marker','.','MarkerSize',10,'Color','[0.3,0.3,0.3]','LineStyle','-')

set(hax,{'ycolor'},{'k';'k'})
box off

%ylabel(hax(1),'Relaxation time, \tau (s)') % left y-axis
%ylabel(hax(2),'\chi_{\infty}- \chi_{0} (cm^3/mol)') % right y-axis
xlim(hax(1),[B0(1)/10,B0(end)/10]);
xlim(hax(2),[B0(1)/10,B0(end)/10]);
%set(hax(2),'xtick',get(hax(1),'xtick'),'xticklab',get(hax(1),'xticklab'))
set(hax(2), 'XAxisLocation','Top', 'XColor','[0.7,0.7,0.7]', 'YColor','[0.7,0.7,0.7]');
%xlabel('\mu_0H (mT)')

set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 8 6]);

set(hax(1),'FontSize',8);
set(hax(2),'FontSize',8);

set(gcf,'color','w')


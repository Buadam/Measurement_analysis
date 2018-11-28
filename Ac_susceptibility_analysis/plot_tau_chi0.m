param=fits_neq_blcorr{t};
B0=B1:dB:B2;

Yt=[1e-3,1e-2,1e-1,1,10,100,1000];

figure(1244)   
cla
[hax,Line1,Line2]=plotyy(B0,param(:,2),B0,param(:,1));
hold on
for f=1:7
    plot([B0(1),B0(end)],[1/fr(f),1/fr(f)],'--','Color',cc(f,:))
end

set(hax(1),'YScale','log','Ylim',[1e-4 1e3],'YTick',Yt)
set(hax(2),'YScale','lin','Ylim',[-0.5e-3 1.5e-3])

set(Line1,'Marker','.','MarkerSize',10,'Color','k')
set(Line2,'Marker','.','MarkerSize',10,'Color','r','LineStyle','--')

set(hax,{'ycolor'},{'k';'r'})
box on


ylabel(hax(1),'Relaxation time, \tau (s)') % left y-axis
ylabel(hax(2),'\chi_{\infty}- \chi_{0} (EMU/Oe)') % right y-axis

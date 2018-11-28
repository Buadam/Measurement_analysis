function param1=fit_susc_B_T(fr,all,dmdhc,t,Branges,dB,Chi_blcorr,Chi_baseline,blcorr,logtau,s,Savefolder,cl,s2,folder)
m=23.4e-3; %g
M=530.02; %g/mol

T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12]; 

filename_re=['ReChi_' num2str(T(t)) 'K.txt'];
filename_im=['ImChi_' num2str(T(t)) 'K.txt'];
     
Bt1=Branges(1);%Total range to plot
Bt2=Branges(2); %Total range to plot
B1=Branges(3);
B2=Branges(4);

fcont=logspace(-5,5,100);
Bcont= all{t}(1,8):0.1:all{t}(end,8);
freq=numel(fr);
B=all{t}(1:end,1+freq);

cc=jet(7);
colt=jet(13);

figure(1230)
cla
hold all
box on
figure(1231)
cla
hold all
box on

if cl==1
    figure(12422)

    subplot(1,2,1)
    cla
    hold all
    ylim([Bt1/10-2,Bt2/10+2])
    box on
    grid on
    axis square
    view(80,10)
    colf=jet(7);
	set(gca,'XScale','log')

    subplot(1,2,2)
    cla
    hold all
    ylim([Bt1/10-2,Bt2/10+2])
    box on
    grid on
    axis square
    view(80,10)
    set(gca,'XScale','log')

    for fre=1:numel(fr)
        ind1=find(B>Bt1,1,'first')-1;
        ind2=find(B>Bt2,1,'first')-1;
        chi_B=all{t}(ind1:ind2,fre+2*7);
        abs_B=all{t}(ind1:ind2,fre+3*7);
    
        subplot(1,2,1)
        plot3(fr(fre)*ones(length(B(ind1:ind2)),1),B(ind1:ind2)/10,chi_B/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:))
        subplot(1,2,2)
        plot3(fr(fre)*ones(length(B(ind1:ind2)),1),B(ind1:ind2)/10,abs_B/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:))
    
    end

    if ~isempty(dmdhc)
        subplot(1,2,1)
        ind11=find(dmdhc(:,1)>Bt1,1)-1;
        ind22=find(dmdhc(:,1)>Bt2,1)-1;
        plot3(1e-2*ones(length(dmdhc(ind11:ind22,1))),dmdhc(ind11:ind22,1)/10,dmdhc(ind11:ind22,2)/m*M,'o','Color','k')
    end
end


for f=1:freq
    
    if blcorr==1
        baseline=interp1(Bcont,Chi_baseline,B);
        signal_chi=all{t}(:,f+2*freq)-baseline;
    else
        signal_chi=all{t}(1:end,f+2*freq);
    end
    signal_abs=all{t}(1:end,f+3*freq);
  
    figure(1230)
    if blcorr==1
        plot(B,all{t}(1:end,f+2*freq),'o-','Color',cc(f,:))
        hold on
        plot(B,baseline,'--','Color','g')
        %plot(B,all{t}(1:end,f+2*freq),'o-','Color',cc(f,:))
    else
    plot(B,signal_chi,'o-','Color',cc(f,:))
    end
    figure(1231)
    plot(B,signal_abs,'o-','Color',cc(f,:))
end



figure(1232)
subplot(1,2,1)
cla
hold all
set(gca,'XScale','log')
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (EMU/Oe)')
box on


subplot(1,2,2)
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (EMU/Oe)')
set(gca,'XScale','log')
box on

B=all{t}(1:end,1+freq); 
B0=B1:dB:B2;
colb=jet(length(B0));

param1=zeros(length(B0),4);
    

f=1:1:freq;
for b=1:numel(B0)
 
        
        ind=find(B>B0(b),1)-1;
        if blcorr==1
            for fre=1:freq
                chi_B_T(fre)=Chi_blcorr{t}{fre}(ind);
            end
        else
            chi_B_T=all{t}(ind,f+2*freq);
        end
        abs_B_T=all{t}(ind,f+3*freq);
        
        %fitting
        [ReChi1,ImChi1,param1(b,:)]=fit_susc(fr,fcont,chi_B_T,abs_B_T,logtau,blcorr);

        if blcorr==1
            ReChi1=ReChi1+interp1(Bcont,Chi_baseline,B0(b));
        end
        
        tau1(b)=param1(b,1);
        alpha1(b)=param1(b,2);
        chi01(b)=param1(b,3);
        chi_inf_re1(b)=param1(b,4);
        
        if s2==1  %save fitted functions and parameters
            dlmwrite(fullfile(folder,filename_re),ReChi1','delimiter','\t','-append')
            dlmwrite(fullfile(folder,filename_im),ImChi1','delimiter','\t','-append')
        end   
        
        figure(1232)
        subplot(1,2,1)
        shift=5e-6;
        if blcorr==1
            plot(fr,chi_B_T+interp1(Bcont,Chi_baseline,B0(b))+(B0(b)-B0(1))*shift,'o','Color',colb(b,:))
        else
            plot(fr,chi_B_T+(B0(b)-B0(1))*shift,'o','Color',colb(b,:))
        end
        if ~isempty(dmdhc)
            ind=find(dmdhc(:,1)>B0(b),1)-1;
            plot(1e-2,dmdhc(ind,2)+(B0(b)-B0(1))*shift,'o','Color','k')
        end
        plot(fcont,ReChi1+(B0(b)-B0(1))*shift,'-','Color',colb(b,:))
        
        subplot(1,2,2)
        shift=1e-7;
        plot(fr,abs_B_T+(B0(b)-B0(1))*shift,'o','Color',colb(b,:))
        plot(fcont,ImChi1+(B0(b)-B0(1))*shift,'-','Color',colb(b,:))
        
       
        figure(12422)
        subplot(1,2,1)
        plot3(fcont,B0(b)/10*ones(length(fcont)),ReChi1/m*M,'-','Color','k','LineWidth',1)
        
        subplot(1,2,2)
        plot3(fcont,B0(b)/10*ones(length(fcont)),ImChi1/m*M,'-','Color','k','LineWidth',1)
        

end
if s2==1 %save fitted functions and parameters
            filename_p=['params_' num2str(T(t)) 'K.txt'];
            dlmwrite(fullfile(folder,filename_p),[B0',param1],'delimiter','\t','-append')
end

figure(12422)
lw=1;
subplot(1,2,1)
if blcorr==1  
    plot3(1e-5*ones(length(B0)),B0/10,(chi01+chi_inf_re1)/m*M+M/m*interp1(Bcont,Chi_baseline,B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]) %Chi(0)
    plot3(1e5*ones(length(B0)),B0/10,chi_inf_re1/m*M+M/m*interp1(Bcont,Chi_baseline,B0),'g--','LineWidth',lw) %Chi(inf)
else
    plot3(1e-5*ones(length(B0)),B0/10,(chi01+chi_inf_re1)/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]) %Chi(0)
    plot3(1e5*ones(length(B0)),B0/10,(chi_inf_re1)/m*M,'g--','LineWidth',lw) %Chi(inf)
end

%Plot Chi(B,f) in 3D
hFig=figure(12422);
grid on
set(gca,'XScale','log')

if s==1 || s==2
    set(hFig,'PaperPositionMode','auto')
    if blcorr==1
        print([Savefolder '/Fit_chi_eq_' num2str(T(t)) 'K_3D_blcorr.png'],'-dpng','-r0')
    else
        print([Savefolder '/Fit_chi_eq_' num2str(T(t)) 'K_3D_nocorr.png'],'-dpng','-r0')
    end
end

%Plot Chi(B,f) in 2D
figure(1232)
if s==1 
    if t>6
        saveas(gca,[Savefolder '/Fit_chi_cycsky' num2str(T(t)) 'K.png'],'png')
    else
        saveas(gca,[Savefolder '/Fit_chi_cycfm' num2str(T(t)) 'K.png'],'png')
    end
end
if s==2
    saveas(gca,[Savefolder '/Fit_chi_skyfm' num2str(T(t)) 'K.png'],'png')
end

%plot tau distributions in 3D
figure(12423)

if cl==1
    cla
end
hold all
box on
grid on
axis square
view(30,60)
set(gca,'XScale','log')

for b=1:numel(B0)
    
    tauD=logspace(-10,10,100);
    g_CC=calc_taudistr(tauD,tau1(b),alpha1(b),1);
    plot3(tauD,B0(b)*ones(length(tauD)),g_CC,'-','Color','k','LineWidth',1)
end

if s==1 || s==2
    set(hFig,'PaperPositionMode','auto')
    print([Savefolder '/taudistr' num2str(T(t)) 'K_3D.png'],'-dpng','-r0')
end



hFig=figure(1238);
%plot actual fit Chi(B,f) for each f
subplot(3,1,1)
hold all
ylabel('\chi^{,}')
xlim([B1-20,B2+20]);

if cl==1
    cla
end
grid on

subplot(3,1,2)
xlim([B1-20,B2+20]);

if cl==1
    cla
end

hold all
ylabel('\chi^{,,}')
grid on
subplot(3,1,3)
set(gca,'YScale','log')
xlim([B1-20,B2+20]);

if cl==1
    cla
end
hold all
ylabel('\tau(s)')
xlabel('Magnetic Field, H(Oe)')
grid on


for f=1:freq
    B=all{t}(1:end,f+freq);
    if blcorr==1
       signal_chi=Chi_blcorr{t}{f}; 
    else
       signal_chi=all{t}(1:end,f+2*freq);
    end
    signal_abs=all{t}(1:end,f+3*freq);
    
    subplot(3,1,1)
    plot(B,signal_chi,'o','Color',cc(f,:))
    
    subplot(3,1,2)
    plot(B,signal_abs,'o','Color',cc(f,:)) 
end

ImChi_Fit=zeros(length(B0),length(fr));
ReChi_Fit=zeros(length(B0),length(fr));
for b=1:length(B0)
    omega=2*pi*fr;
    ChiFit=complexsusc_CC(param1(b,:),omega,1,0);
    ImChi_Fit(b,:)=ChiFit(:,1);
    ReChi_Fit(b,:)=ChiFit(:,2);
end

for f=1:freq
    subplot(3,1,1)
    plot(B0,ReChi_Fit(:,f),'-','Color',cc(f,:))
    subplot(3,1,2)
    plot(B0,ImChi_Fit(:,f),'-','Color',cc(f,:))
end

%Add dc susceptibility values if measured
subplot(3,1,1)
if ~isempty(dmdhc)
        h_dc=plot(dmdhc(:,1)/10,dmdhc(:,2)/m*M+(T(t)-T(1))*shift,'ko');
end
    
%Add isoterm and adiabatic susceptibilities
subplot(3,1,1)
plot(B0,chi_inf_re1,'g--')
plot(B0,chi_inf_re1+chi01,'--','Color',[0.3,0.3,0.3])

subplot(3,1,3)
semilogy(B0,tau1,'bo')
hold on
for f=1:freq
    plot([B0(1),B0(end)],[1/fr(f),1/fr(f)],'--','Color',cc(f,:))
end
grid on

if s==1 || s==2
    set(hFig,'PaperPositionMode','auto')
    print([Savefolder '/FittedChi_tau_' num2str(T(t)) 'K.png'],'-dpng','-r0')
end   

%Plot tau and chi0 in the same graph
figure(12443)
hFig=figure(3123141);
if cl==1
    cla
end
hold on

plot_tau_chi0_T_publ(hFig,fr,B0,param1)
if blcorr==1    
    filename=['tau_chi0_' num2str(T(t)) 'K_blcorr'];
else
    filename=['tau_chi0_' num2str(T(t)) 'K_nocorr'];
end


if cl==1
    close(hFig)
    if s==1
        export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
        export_fig(hFig,fullfile(Savefolder,filename),'-eps')
    end
end


%{
%Plot parameters obtained from the relaxation model for all B
hFig=figure(1234);
subplot(6,1,1)
cla
hold all
ylabel('\chi^{,}')
xlim([B1-20,B2+20]);
grid on
subplot(6,1,2)
xlim([B1-20,B2+20]);
cla
hold all
ylabel('\chi^{,,}')
grid on
for f=1:7
    B=all{t}(1:end,f+freq);
    if blcorr==1
       signal_chi=Chi_blcorr{t}{f}; 
    else
       signal_chi=all{t}(1:end,f+2*freq);
    end
    signal_abs=all{t}(1:end,f+3*freq);
    
    subplot(6,1,1)
    plot(B,signal_chi,'o-','Color',cc(f,:))
    
    subplot(6,1,2)
    plot(B,signal_abs,'o-','Color',cc(f,:)) 
end
subplot(6,1,3)
cla
plot(B0,param(:,1),'bo-',B0,param(:,4),'ro-')
legend('\chi^{,}_0','\chi^{,,}_0')
xlim([B1-20,B2+20]);
subplot(6,1,4)
cla
plot(B0,param(:,5),'bo-')
ylabel('\chi^{,}(\infty)')
xlim([B1-20,B2+20]);
subplot(6,1,5)
cla
semilogy(B0,param(:,2),'bo-')
ylabel('\tau(s)')
xlim([B1-20,B2+20]);
subplot(6,1,6)
cla
plot(B0,param(:,3),'bo-')
ylabel('\alpha')
xlabel('H(Oe)')
xlim([B1-20,B2+20]);
if s==1
    set(hFig,'PaperPositionMode','auto')
    print([Savefolder '/params_' num2str(T(t)) 'K.png'],'-dpng','-r0')
end

figure(1235)
grid on
semilogy(B0,param(:,1),'bo',B0,param(:,4),'ro')

figure(1236)
cla
semilogy(B0,param(:,2),'ko')
hold on
for f=1:7
    plot([B0(1),B0(end)],[1/fr(f),1/fr(f)],'--','Color',cc(f,:))
end
grid on

figure(1237)
grid on
semilogy(B0,param(:,3),'bo')


figure(1241)
Bc=120;
xx=log10(abs(B0-Bc))';
yy=log10(param(:,2));
plot(xx,yy,'ko-')
%}





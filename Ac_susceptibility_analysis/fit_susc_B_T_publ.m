function param1=fit_susc_B_T_publ(fr,all,dmdhc,t,Branges,dB,Chi_blcorr,Chi_baseline,blcorr,logtau,s,Savefolder,cl)
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
B0=B1:dB:B2;
colb=jet(length(B0));
cc=jet(7);
colt=jet(13);



lw=1;

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
    
%{
    if ~isempty(dmdhc)
        subplot(1,2,1)
        ind11=find(dmdhc(:,1)>Bt1,1)-1;
        ind22=find(dmdhc(:,1)>Bt2,1)-1;
        plot3(1e-2*ones(length(dmdhc(ind11:ind22,1))),dmdhc(ind11:ind22,1)/10,dmdhc(ind11:ind22,2)/m*M,'o','Color','k')
    end
%}
end


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
   
        figure(12422)
        subplot(1,2,1)
        plot3(fcont,B0(b)/10*ones(length(fcont)),ReChi1/m*M,'-','Color','k','LineWidth',lw)
        
        subplot(1,2,2)
        plot3(fcont,B0(b)/10*ones(length(fcont)),ImChi1/m*M,'-','Color','k','LineWidth',lw)
        

end

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


set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);

if blcorr==1
    filename=['\Chi_B_f_publ_' num2str(T(t)) 'K_blcorr.png'];
else
    filename=['\Chi_B_f_publ_' num2str(T(t)) 'K_nocorr.png'];
end
if s==1
    export_fig(hFig,fullfile(Savefolder,filename),'-m3') 
end

%%
%Plot Chi0 and tau
hFig=figure(3123141);
cla
hold on

plot_tau_chi0_T_publ(hFig,fr,B0,param1)
if blcorr==1    
    filename=['tau_chi0_' num2str(T(t)) 'K_blcorr'];
else
    filename=['tau_chi0_' num2str(T(t)) 'K_nocorr'];
end

if s==1
    export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
    export_fig(hFig,fullfile(Savefolder,filename),'-eps')
end
close(hFig)

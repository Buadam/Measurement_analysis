clear all;
[all,dmdhc,freq,fr]= Loaddata();

Folder='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_0_Summary\Fit_Chi_B_T_f_Cole_Cole\Fitted_fns_bestfits';
Folder_im_re='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_0_Summary\Fit_Chi_B_T_f_Cole_Cole_separate\Fitted_fns_separate';


addpath('G:\Adam\Install\Mathworks.Matlab.R2015a.x64.ISO-TBE\altmany-export_fig-2763b78\altmany-export_fig-2763b78')
Savefolder='Plots_publ\fits_with_dc';
ind=[];
ind2=[];
%physical parameters
m=23.4e-3; %g
M=530.02; %g/mol

blcorr=0;
T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];  
f=logspace(-5,5,100);

Bplot1=[60,80,100,120,160,180,240,180,240,220,220,200,160];
Bplot2=[240,260,360,360,400,460,500,540,580,620,620,620,660];

Bplot={60:20:240,...
        80:20:260,...
        140:20:320,...
        180:20:360,...
        220:20:400,...
        180:20:460,...
        240:20:500,...
        [240:20:320,400:20:540],...
        [240:20:320,440:20:560],...
        [220:20:300,460:20:580],...
        220:20:620,...
        200:20:620,...
        160:20:660};

    
%{
t=3;
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_im' num2str(Temp) 'K.txt']),'\t',0,0);
params2=dlmread(fullfile(Folder,['params_re' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_re_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi_re=dlmread(fullfile(Folder,['ImChi_re_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi_im=dlmread(fullfile(Folder,['ReChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);


%Fitted parameters
Ball=params(:,1);
for i=1:numel(Bplot{t})
    ind(i)=find(Ball>Bplot{t}(i),1)-1;
end

p1=params(ind,:);
p2=params2(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(12455);
lw=0.5;
ms=6;
mlw=0.35;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
    plot3(f,B0(b)/10*ones(length(f)),ReChi_im(ind(b),:)/m*M,'--','Color',[0.3,0.3,0.3],'LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
    plot3(f,B0(b)/10*ones(length(f)),ImChi_re(ind(b),:)/m*M,'--','Color',[0.3,0.3,0.3],'LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 





hFig=figure(12333);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
box on
shift=1;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:))
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7])
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k')
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',8);
filename=['\abs_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



hFig=figure(12334);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
box on
shift=10;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:))
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7])
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k')
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',8);
filename=['\chi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 

hFig=figure(3123141);
cla
hold on

plot_tau_chi0_T_publ_twoparams(hFig,fr{t},B0,p1,p2)
savefolder='Plots';
filename=['tau_chi0_' num2str(T(t)) 'K_im_re'];
%export_fig(hFig,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig,fullfile(savefolder,filename),'-eps')
close(hFig)
%}


        

%%
t=8;
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


%Fitted parameters
Ball=params(:,1);
for i=1:numel(Bplot{t})
    ind(i)=find(Ball>Bplot{t}(i),1)-1;
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(855);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
%export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(833);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(834);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
    %plot dc value at 0.01Hz
        dmdhcent=dmdhc{t};
        B_dc=dmdhcent(:,1);
        ind2=find(B_dc>B0(b),1)-1;
        if ind2>0
            dmdh_b=M/m*dmdhcent(ind2,2);
            plot(1e-2,dmdh_b+(b-1)*shift,'o','Color','k','MarkerFaceColor','k')
        end
    
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')


hFig=figure(3123141);
cla
hold on
plot_tau_chi0_T_publ(hFig,fr{t},B0,p1)
filename=['tau_chi0_' num2str(T(t)) 'K_im_re'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
export_fig(hFig,fullfile(Savefolder,filename),'-eps')
close(hFig)




%%
%%
t=9;
ind=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


%Fitted parameters
Ball=params(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(955);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(933);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(934);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
    %plot dc value at 0.01Hz
        dmdhcent=dmdhc{t};
        B_dc=dmdhcent(:,1);
        ind2=find(B_dc>B0(b),1)-1;
        if ind2>0
            dmdh_b=M/m*dmdhcent(ind2,2);
            plot(1e-2,dmdh_b+(b-1)*shift,'o','Color','k','MarkerFaceColor','k')
        end
    
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')


hFig=figure(3123141);
cla
hold on
plot_tau_chi0_T_publ(hFig,fr{t},B0,p1)
filename=['tau_chi0_' num2str(T(t)) 'K_im_re'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
export_fig(hFig,fullfile(Savefolder,filename),'-eps')
%close(hFig)








%%
%%
t=10;
ind=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


%Fitted parameters
Ball=params(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(1055);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(1033);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(1034);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
    %plot dc value at 0.01Hz
        dmdhcent=dmdhc{t};
        B_dc=dmdhcent(:,1);
        ind2=find(B_dc>B0(b),1)-1;
        if ind2>0
            dmdh_b=M/m*dmdhcent(ind2,2);
            plot(1e-2,dmdh_b+(b-1)*shift,'o','Color','k','MarkerFaceColor','k')
        end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')


hFig=figure(3123141);
cla
hold on
plot_tau_chi0_T_publ(hFig,fr{t},B0,p1)
filename=['tau_chi0_' num2str(T(t)) 'K_im_re'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
export_fig(hFig,fullfile(Savefolder,filename),'-eps')
%close(hFig)

%}

%{
%%
t=3;
ind=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


%Fitted parameters
Ball=params(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(12455);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(12333);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
ylim([0,15])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(12334);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')


hFig=figure(3123141);
cla
hold on
plot_tau_chi0_T_publ(hFig,fr{t},B0,p1)
filename=['tau_chi0_' num2str(T(t)) 'K_im_re'];
%export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
%export_fig(hFig,fullfile(Savefolder,filename),'-eps')
%close(hFig)

%}
%{ 
        
t=4;
ind=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


%Fitted parameters
Ball=params(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(12455);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
%export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(12333);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
ylim([0,15])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(12334);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K'];
%export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
%export_fig(hFig,fullfile(Savefolder,filename),'-eps')


hFig=figure(3123141);
cla
hold on
plot_tau_chi0_T_publ(hFig,fr{t},B0,p1)
filename=['tau_chi0_' num2str(T(t)) 'K_im_re'];
%export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3')
%export_fig(hFig,fullfile(Savefolder,filename),'-eps')
%close(hFig)
        
%}

t=5;
ind=[];
ind_im=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


ImChi_im=dlmread(fullfile(Folder_im_re,['ImChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi_re=dlmread(fullfile(Folder_im_re,['ReChi_re_' num2str(Temp) 'K.txt']),'\t',0,0);

ReChi_im=dlmread(fullfile(Folder_im_re,['ReChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);

params_im=dlmread(fullfile(Folder_im_re,['params_im' num2str(Temp) 'K.txt']),'\t',0,0);

%Fitted parameters
Ball=params(:,1);
Ball_im=params_im(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    tempind2=find(Ball_im>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
    if isempty(tempind2)
        ind_im(i)=numel(Ball_im);
    else
        ind_im(i)=tempind2;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(555);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(533);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
ylim([0,16])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
    
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
        plot(f,M/m*ImChi_im(ind_im(b),:)+(b-1)*shift,'--','Color',[0.7,0.7,0.7],'LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K_sep'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(534);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
ylim([0,55])
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
    
    %plot dc value at 0.01Hz
        dmdhcent=dmdhc{t};
        B_dc=dmdhcent(:,1);
        ind2=find(B_dc>B0(b),1)-1;
        if ind2>0
            dmdh_b=M/m*dmdhcent(ind2,2);
            plot(1e-2,dmdh_b+(b-1)*shift,'o','Color','k','MarkerFaceColor','k')
        end
    
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
        plot(f,M/m*ReChi_re(ind_im(b),:)+(b-1)*shift,'--','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi_im(ind_im(b),:)+(b-1)*shift,'--','Color','y','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K_sep'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')


        
       
t=4;
ind=[];
ind_im=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


ImChi_im=dlmread(fullfile(Folder_im_re,['ImChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi_re=dlmread(fullfile(Folder_im_re,['ReChi_re_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi_im=dlmread(fullfile(Folder_im_re,['ReChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);

params_im=dlmread(fullfile(Folder_im_re,['params_im' num2str(Temp) 'K.txt']),'\t',0,0);

%Fitted parameters
Ball=params(:,1);
Ball_im=params_im(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    tempind2=find(Ball_im>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
    if isempty(tempind2)
        ind_im(i)=numel(Ball_im);
    else
        ind_im(i)=tempind2;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(455);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(433);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
ylim([0,16])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
        plot(f,M/m*ImChi_im(ind_im(b),:)+(b-1)*shift,'--','Color',[0.7,0.7,0.7],'LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K_sep'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(434);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
ylim([0,55])
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
    
    %plot dc value at 0.01Hz
        dmdhcent=dmdhc{t};
        B_dc=dmdhcent(:,1);
        ind2=find(B_dc>B0(b),1)-1;
        if ind2>0
            dmdh_b=M/m*dmdhcent(ind2,2);
            plot(1e-2,dmdh_b+(b-1)*shift,'o','Color','k','MarkerFaceColor','k')
        end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
        plot(f,M/m*ReChi_re(ind_im(b),:)+(b-1)*shift,'--','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi_im(ind_im(b),:)+(b-1)*shift,'--','Color','y','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K_sep'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')

        
t=3;
ind=[];
ind_im=[];
cc=jet(freq(t));
Temp=T(t);

B=all{t}(1:end,1+freq(t));
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);


ImChi_im=dlmread(fullfile(Folder_im_re,['ImChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi_re=dlmread(fullfile(Folder_im_re,['ReChi_re_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi_im=dlmread(fullfile(Folder_im_re,['ReChi_im_' num2str(Temp) 'K.txt']),'\t',0,0);

params_im=dlmread(fullfile(Folder_im_re,['params_im' num2str(Temp) 'K.txt']),'\t',0,0);

%Fitted parameters
Ball=params(:,1);
Ball_im=params_im(:,1);
for i=1:numel(Bplot{t})
    tempind=find(Ball>Bplot{t}(i),1)-1;
    tempind2=find(Ball_im>Bplot{t}(i),1)-1;
    if isempty(tempind)
        ind(i)=numel(Ball);
    else
        ind(i)=tempind;
    end
    if isempty(tempind2)
        ind_im(i)=numel(Ball_im);
    else
        ind_im(i)=tempind2;
    end
end

p1=params(ind,:);

B0=Ball(ind);
tau=params(ind,2);
alpha=params(ind,3);
chi0_re=params(ind,4);
chi_inf=params(ind,5);


hFig=figure(355);
lw=0.4;
ms=5;
mlw=0.3;


subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')
ylim([B0(1)/10-2,B0(end)/10+2]) 

%%Plotting measured data
for fre=1:7
    for i=1:numel(Bplot{t})
        ind2(i)=find(B>Bplot{t}(i),1)-1;
    end

    chi_B_f{fre}=all{t}(ind2,fre+2*7);
    abs_B_f{fre}=all{t}(ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,chi_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind2)),1),B(ind2)/10,abs_B_f{fre}/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
end


subplot(1,2,1)
if blcorr==1
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M+M/m*interp1(Bcont,Chi_baseline{t},B0),'g--','LineWidth',lw); %Chi(inf)
else
    h0=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M+chi_inf/m*M,'--','LineWidth',lw,'Color',[0.3,0.3,0.3]); %Chi(0) chi
    hinf=plot3(1e5*ones(length(B0)),B0/10,chi_inf/m*M,'g--','LineWidth',lw); %Chi(inf)
end
    %habs=plot3(1e-5*ones(length(B0)),B0/10,chi0_re/m*M,'--','LineWidth',lw,'Color',[0.7,0.7,0.7]); %Chi(0)-Chi_inf
    
    
%Plotting fitted functions
subplot(1,2,1)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(ind(b),:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\AbsChi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 



lw=0.4;
ms=6;
mlw=0.2;

hFig=figure(333);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
set(gca,'XTick',Xt)
xlim([1e-3,1e5])
ylim([0,16])
box on
shift=1.5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*abs_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ImChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
        plot(f,M/m*ImChi_im(ind_im(b),:)+(b-1)*shift,'--','Color',[0.7,0.7,0.7],'LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [21 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\abs_B_f_' num2str(T(t)) 'K_sep'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')



hFig=figure(334);
cla
hold all
xlabel('Drive frequency, f(Hz)')
ylabel('\chi^{,} (cm^3/mol)')
set(gca,'XScale','log')
Xt=[1e-10,1e-5,1e-3,1e-1,1e0,1e1,1e2,1e3,1e5,1e10];
xlim([1e-3,1e5])
set(gca,'XTick',Xt)
ylim([0,55])
box on
shift=5;
for b=1:length(B0)

    for fre=1:freq
        plot(fr{t}(fre),M/m*chi_B_f{fre}(b)+(b-1)*shift,'o','Color','k','MarkerFaceColor',cc(fre,:),'MarkerSize',ms,'LineWidth',mlw)
    end
        
    %plot dc value at 0.01Hz
        dmdhcent=dmdhc{t};
        B_dc=dmdhcent(:,1);
        ind2=find(B_dc>B0(b),1)-1;
        if ind2>0
            dmdh_b=M/m*dmdhcent(ind2,2);
            plot(1e-2,dmdh_b+(b-1)*shift,'o','Color','k','MarkerFaceColor','k')
        end
    
        plot([1e-5,2e-5],[(b-1)*shift (b-1)*shift],'-','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi(ind(b),:)+(b-1)*shift,'-','Color','k','LineWidth',lw)
        plot(f,M/m*ReChi_re(ind_im(b),:)+(b-1)*shift,'--','Color',[0.7,0.7,0.7],'LineWidth',lw)
        plot(f,M/m*ReChi_im(ind_im(b),:)+(b-1)*shift,'--','Color','y','LineWidth',lw)
end
set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [30 2 8.6 12]);
set(gca,'FontSize',12);
filename=['\chi_B_f_' num2str(T(t)) 'K_sep'];
export_fig(hFig,fullfile(Savefolder,filename),'-png','-m3') 
export_fig(hFig,fullfile(Savefolder,filename),'-eps')    
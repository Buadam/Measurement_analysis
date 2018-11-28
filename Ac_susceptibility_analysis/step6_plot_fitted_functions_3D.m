Folder='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_0_Summary\Fit_Chi_B_T_f_Cole_Cole\Fitted_fns_blcorr';
addpath('G:\Adam\Install\Mathworks.Matlab.R2015a.x64.ISO-TBE\altmany-export_fig-2763b78\altmany-export_fig-2763b78')
Savefolder='Plots_blcorr';

%physical parameters
m=23.4e-3; %g
M=530.02; %g/mol

blcorr=1;
T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];  
f=logspace(-5,5,100);

for t=1:6
Temp=T(t);

B=all{t}(1:end,1+freq);
Bcont= all{t}(1,8):0.1:all{t}(end,8);
%read files
params=dlmread(fullfile(Folder,['params_' num2str(Temp) 'K.txt']),'\t',0,0);
ImChi=dlmread(fullfile(Folder,['ImChi_' num2str(Temp) 'K.txt']),'\t',0,0);
ReChi=dlmread(fullfile(Folder,['ReChi_' num2str(Temp) 'K.txt']),'\t',0,0);

%Fitted parameters
B0=params(:,1);
tau=params(:,2);
alpha=params(:,3);
chi0_re=params(:,4);
chi_inf=params(:,5);


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
    ind1=find(B>B0(1),1,'first')-1;
    ind2=find(B>B0(end),1,'first')-1;
    chi_B=all{t}(ind1:ind2,fre+2*7);
    abs_B=all{t}(ind1:ind2,fre+3*7);
    
 
    subplot(1,2,1)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind1:ind2)),1),B(ind1:ind2)/10,chi_B/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
    subplot(1,2,2)
    h(fre)=plot3(fr{t}(fre)*ones(length(B(ind1:ind2)),1),B(ind1:ind2)/10,abs_B/m*M,'o','Color','k','MarkerFaceColor',colf(fre,:),'MarkerSize',ms,'LineWidth',mlw);
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
    hf=plot3(f,B0(b)/10*ones(length(f)),ReChi(b,:)/m*M,'-','Color','k','LineWidth',lw);
end
subplot(1,2,2)
for b=1:length(B0)
    hf=plot3(f,B0(b)/10*ones(length(f)),ImChi(b,:)/m*M,'-','Color','k','LineWidth',lw);
end

set(gcf, 'Color', 'w');
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 16 10]);
subplot(1,2,1)
set(gca,'FontSize',8);

subplot(1,2,2)
set(gca,'FontSize',8);


filename=['\Chi_B_f_' num2str(T(t)) '.png'];
export_fig(hFig,fullfile(Savefolder,filename),'-m3') 

end
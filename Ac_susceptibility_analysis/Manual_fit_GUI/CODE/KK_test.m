addpath('G:\Adam\Install\Mathworks.Matlab.R2015a.x64.ISO-TBE\altmany-export_fig-2763b78\altmany-export_fig-2763b78')

fr=[0.1,1,10,45,110,500,1000];
T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
freq=7;
B=all{t}(1:end,1+freq);

B1=[20,20,20,120,160,120,200,200,240,220,220,140,180];
B2=[280,360,380,280,420,500,520,540,600,600,640,580,580];




for t=6:13

%B1=200;
%B2=540;
dB=20;
B0=B1(t):dB:B2(t);

colb=jet(length(B0));


%%Filling and plotting measured chi and abs as a function of the freq
f=1:1:7; 

hFig=figure(12212);
cla
subplot(1,2,1)
cla
hold all
box on
grid on
axis square
view(80,10)
colf=jet(7);
set(gca,'XScale','log')

subplot(1,2,2)
cla
hold all
box on
grid on
axis square
view(80,10)
set(gca,'XScale','log')

for b=1:length(B0)
    ind=find(B>B0(b),1);
    if ~isempty(ind)
    chi_B_T=all{t}(ind,f+2*7);
    abs_B_T=all{t}(ind,f+3*7);

    fcont=logspace(-1,3,100);
    abscont=interp1(log10(fr),abs_B_T,log10(fcont),'cubic');
    chicont=interp1(log10(fr),chi_B_T,log10(fcont),'cubic');

    %% get KK of the absorption
    [f_meas,ReChiKK_cont]=KramersKronig1(fcont,abscont');
    
    subplot(1,2,1)
    plot3(fr,B0(b)*ones(length(fr)),chi_B_T,'o','Color',colb(b,:))     %measurement
    plot3(fcont,B0(b)*ones(length(fcont)),chicont,'-','Color','k','LineWidth',1)    %cubic interpolating curve
    plot3(f_meas,B0(b)*ones(length(fcont)),ReChiKK_cont,'--','Color','r','LineWidth',1)    %Kramers-Kronig from the absorption part
    
    
    subplot(1,2,2)
    plot3(fr,B0(b)*ones(length(fr)),abs_B_T,'o','Color',colb(b,:))     %measurement
    plot3(fcont,B0(b)*ones(length(fcont)),abscont,'-','Color','k','LineWidth',1)    %cubic interpolating curve
    

    end
end


FileName=['G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_10_KK_test_for_meas_data\KK_test\KK_' num2str(T(t)) 'K.png'];
FileName=strrep(FileName,'.5','p5')
export_fig(hFig,FileName,'-m3')

end

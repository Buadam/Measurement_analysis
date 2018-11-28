fits_neq_blcorr={};

fr=[0.1,1,10,45,110,500,1000];
T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
Savefolder='Fullfit_Neq_bestfits';
s=0; %save images?

equal=0; %Fit equal amplitudes?
blcorr=[0,0,0,0,0,0,0,0,0,0,0,0,0]; %Use baseline-corrected chi signals
logtau=[0,0,0,0,0,0,0,1,0,0,1,1,1]; %Use logarithmic scale when fitting tau

select=1;

if select==1
t=3;
    B1=60;
    B2=380;
    dB=20;
    fits_neq_blcorr{t}=fit_susc_B_T_publ(all,t,B1,B2,dB,Chi_blcorr,Chi_baseline{t},equal,blcorr(t),logtau(t),s,Savefolder);
    
    figure(12422)
    set(gcf,'Color', 'w');
    export_fig G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_0_Summary\Plots\Chi_B_f_8K_6.png -m3 
elseif select==2
t=8;
    B1=200;
    B2=540;
    dB=20;
    fits_neq_blcorr{t}=fit_susc_B_T_publ(all,t,B1,B2,dB,Chi_blcorr,Chi_baseline{t},equal,blcorr(t),logtau(t),s,Savefolder);
elseif select==3
t=9;
    B1=240;
    B2=600;
    dB=20;
    fits_neq_blcorr{t}=fit_susc_B_T_publ(all,t,B1,B2,dB,Chi_blcorr,Chi_baseline{t},equal,blcorr(t),logtau(t),s,Savefolder);
end
    
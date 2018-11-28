Folder='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_0_Summary\Fit_Chi_B_T_f_Cole_Cole\Fitted_fns_bestfits';

T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];  


for t=3:3
hFig=figure(3123141);
cla
hold on

plot_tau_chi0_T(hFig,t,fr,Folder)
savefolder='Plots_blcorr';
filename=['tau_chi0_' num2str(T(t)) 'K'];
%export_fig(hFig,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig,fullfile(savefolder,filename),'-eps')
%close(hFig)

end







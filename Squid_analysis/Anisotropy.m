%clear all;
%Comparing 5K curves for 111 and 100

%%%%%%%%%%%%%%
%%%%Large1%%%%
%%%%%%%%%%%%%%

%Folder_110='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_01_mH_grid';
%Folder_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_06_GaMoS_111_mH';
Folder_11_2='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\08_31_GaMoS_11_2_mH';
Folder_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_06_GaMoS_111_mH';
Folder2_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_16_mH_grid';
Folder2_001='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_18_GaMoS_001_mH_grid';
Folder2_110='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_22_GaMoS_110_mH_grid';
Folder2_22_1='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_26_GaMoS_22_1_mH_grid';
Folder2_114='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_28_GaMoS_114_mH_grid';

m=0.1123; %g    Large1
m2=0.0754; %g   Large2

conv1=1.1; %from EMU to muB/fu. (M=710.028 g/mol, m=112.3mg)
conv2=1.6; %from EMU to muB/fu. (M=710.028 g/mol, m=75.4mg)


data_11_2=dlmread(fullfile(Folder_11_2,'GaMoS_mH_5T_5K_up.dc.dat'),',',31,0);
data_11_2_7K=dlmread(fullfile(Folder_11_2,'GaMoS_mH_5T_7K_up.dc.dat'),',',31,0);
data_111=dlmread(fullfile(Folder_111,'GaMoS_111_mH_5T_5K_up.dc.dat'),',',31,0);
data_l2_111=dlmread(fullfile(Folder2_111,'GaMoS_large2_111_mH_5T_5K_up.dc.dat'),',',31,0);
data_l2_001=dlmread(fullfile(Folder2_001,'GaMoS_large2_001_mH_5T_5K_up.dc.dat'),',',31,0);
data_l2_110=dlmread(fullfile(Folder2_110,'GaMoS_large2_110_mH_5T_5K_up.dc.dat'),',',31,0);
data_l2_22_1=dlmread(fullfile(Folder2_22_1,'GaMoS_large2_22_1_mH_5T_5K_up.dc.dat'),',',31,0);
data_l2_114=dlmread(fullfile(Folder2_114,'GaMoS_large2_114_mH_5T_5K_up.dc.dat'),',',31,0);

figure(101)
subplot(2,1,1)
cla
subplot(2,1,2)
cla
shift=0.1;
shift_dmdH=2e-5;

plot_mH_dmdH(data_11_2,conv1,shift,shift_dmdH,6,[0.7,0.7,0.7],'large1 [11-2]');
plot_mH_dmdH(data_l2_22_1,conv2,shift,shift_dmdH,5,'g','large2 [22-1]');
plot_mH_dmdH(data_l2_110,conv2,shift,shift_dmdH,4,'b','large2 [110]');
plot_mH_dmdH(data_111,conv1,shift,shift_dmdH,3,'y','large1 [111]');
plot_mH_dmdH(data_l2_111,conv2,shift,shift_dmdH,3,'k','large2 [111]');
plot_mH_dmdH(data_l2_114,conv2,shift,shift_dmdH,2,'m','large2 [114]');
plot_mH_dmdH(data_l2_001,conv2,shift,shift_dmdH,1,'r','large2 [001]');


figure(102)
cla
plot_dmdH(data_11_2,conv1,shift_dmdH,6,[0.7,0.7,0.7],'large1 [11-2]');
plot_dmdH(data_11_2_7K,conv1,shift_dmdH,6,[0.7,0.7,0.7],'large1 [11-2]');
plot_dmdH(data_l2_22_1,conv2,shift_dmdH,5,'g','large2 [22-1]');
plot_dmdH(data_l2_110,conv2,shift_dmdH,4,'b','large2 [110]');
plot_dmdH(data_111,conv1,shift_dmdH,3,'y','large1 [111]');
plot_dmdH(data_l2_111,conv2,shift_dmdH,3,'k','large2 [111]');
plot_dmdH(data_l2_114,conv2,shift_dmdH,2,'m','large2 [114]');
plot_dmdH(data_l2_001,conv2,shift_dmdH,1,'r','large2 [001]');


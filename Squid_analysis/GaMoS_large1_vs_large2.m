%clear all;
%Comparing 5K curves for 111 and 100

%%%%%%%%%%%%%%
%%%%Large1%%%%
%%%%%%%%%%%%%%

%Folder_110='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_01_mH_grid';
%Folder_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_06_GaMoS_111_mH';
Folder_110='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_01_mH_grid';
Folder_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_08_31_Squid\09_06_GaMoS_111_mH';
Folder2_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_16_mH_grid';
Folder2_001='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_18_GaMoS_001_mH_grid';

m=0.1123; %g    Large1
m2=0.0754; %g   Large2

conv1=1.1; %from EMU to muB/fu. (M=710.028 g/mol, m=112.3mg)
conv2=1.6; %from EMU to muB/fu. (M=710.028 g/mol, m=75.4mg)


data_110=dlmread(fullfile(Folder_110,'GaMoS_mH_5T_5K_up.dc.txt'),',',31,0);
mH_110=[data_110(:,2),data_110(:,4)];
dmdH_110=diff(mH_110(:,2))./diff(mH_110(:,1));

data_111=dlmread(fullfile(Folder_111,'GaMoS_111_mH_5T_5K_up.dc.dat'),',',31,0);
mH_111=[data_111(:,3),data_111(:,5)];
dmdH_111=diff(mH_111(:,2))./diff(mH_111(:,1)); 

data_l2_111=dlmread(fullfile(Folder2_111,'GaMoS_large2_111_mH_5T_5K_up.dc.dat'),',',31,0);
mH_large2_111=[data_l2_111(:,3),data_l2_111(:,5)];
dmdH_large2_111=diff(mH_large2_111(:,2))./diff(mH_large2_111(:,1)); 

data_l2_001=dlmread(fullfile(Folder2_001,'GaMoS_large2_001_mH_5T_5K_up.dc.dat'),',',31,0);
mH_large2_001=[data_l2_001(:,3),data_l2_001(:,5)];
dmdH_large2_001=diff(mH_large2_001(:,2))./diff(mH_large2_001(:,1)); 


figure(100)
subplot(2,1,1)
hold all
box on
grid on
h_110=plot(mH_110(:,1),mH_110(:,2)/m,'ko-','MarkerSize',3);
h_111=plot(mH_111(:,1),mH_111(:,2)/m,'ro-','MarkerSize',3);
h2_111=plot(mH_large2_111(:,1),mH_large2_111(:,2)/m2,'bo-','MarkerSize',3);
h2_001=plot(mH_large2_001(:,1),mH_large2_001(:,2)/m2,'go-','MarkerSize',3);

xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(EMU/g)')
legend([h_110,h_111,h2_111,h2_001],'large1:B||[11-2]?','large1:B||[111]','large2:B||[111]','large2:B||[001]')

subplot(2,1,2)
hold all
box on
grid on
h_110=plot(mH_110(1:end-1,1),dmdH_110/m,'ko-','MarkerSize',3);
h_111=plot(mH_111(1:end-1,1),dmdH_111/m,'ro-','MarkerSize',3);
h2_111=plot(mH_large2_111(1:end-1,1),dmdH_large2_111/m2,'bo-','MarkerSize',3);
h2_001=plot(mH_large2_001(1:end-1,1),dmdH_large2_001/m2,'go-','MarkerSize',3);

xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (EMU/g/Oe)')
legend([h_110,h_111,h2_111,h2_001],'large1:B||[11-2]?','large1:B||[111]','large2:B||[111]','large2:B||[001]')




figure(101)
subplot(2,1,1)
hold all
box on
grid on
h_110=plot(mH_110(:,1),mH_110(:,2)*conv1,'ko-','MarkerSize',3);
h_111=plot(mH_111(:,1),mH_111(:,2)*conv1,'ro-','MarkerSize',3);
h2_111=plot(mH_large2_111(:,1),mH_large2_111(:,2)*conv2,'bo-','MarkerSize',3);
h2_001=plot(mH_large2_001(:,1),mH_large2_001(:,2)*conv2,'go-','MarkerSize',3);

xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(mu_B/f.u.)')
legend([h_110,h_111,h2_111,h2_001],'large1:B||[11-2]?','large1:B||[111]','large2:B||[111]','large2:B||[001]')

subplot(2,1,2)
cla
hold all
box on
grid on
shift=2e-5;
h_110=plot(mH_110(1:end-1,1),dmdH_110*conv1+3*shift,'ko-','MarkerSize',3);
h_111=plot(mH_111(1:end-1,1),dmdH_111*conv1+2*shift,'ro-','MarkerSize',3);
h2_111=plot(mH_large2_111(1:end-1,1),dmdH_large2_111*conv2+shift,'bo-','MarkerSize',3);
h2_001=plot(mH_large2_001(1:end-1,1),dmdH_large2_001*conv2,'go-','MarkerSize',3);

xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (\mu_B/f.u./Oe)')
legend([h_110,h_111,h2_111,h2_001],'large1:B||[11-2]?','large1:B||[111]','large2:B||[111]','large2:B||[001]')

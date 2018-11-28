

Folder='D:\Adam\Skyrmion\GaMoS\Measurements\2016_11_16_to_Squid\11_16_mT_1T';
Filename='GaMoS_large2_111_mT_1T_60K_5K.rso.dat';
B=1e4;
data=dlmread(fullfile(Folder,Filename),',',31,0);
mT_up=[data(:,4),data(:,5)];


%plotting mH
subplot(2,1,1)
cla
hold all
box on
grid on

h=plot(mT_up(:,1),mT_up(:,2),'ko-','MarkerSize',3);

%plotting dmdH
subplot(2,1,2)
cla
hold all
box on
grid on

l=plot(mT_up(:,1),1./mT_up(:,2),'ko-','MarkerSize',3);

subplot(2,1,1)
xlabel('Temperature, T(K)')
ylabel('Magnetization, m(EMU)')


subplot(2,1,2)
xlabel('Temperature, T(K)')
ylabel('1/m (EMU/Oe)^-1')


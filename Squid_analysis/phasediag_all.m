%clear all;

Folder='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_16_mH_grid';

T=[5,7,9,11,13,15,16,17,18,19];
cc=jet(length(T));
cc_dn=winter(3);

mH_up={};
dmdH_up={};

mH_up{1}=[];
dmdH_up{1}=[];

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting mH and dm/dH curves for the field swept up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1)
for t=1:10
    File=['GaMoS_large2_111_mH_5T_' num2str(T(t)) 'K_up.dc.dat'];
    data=dlmread(fullfile(Folder,File),',',31,0);
    mH_up{t}=[data(:,3),data(:,5)];
    dmdH_up{t}=diff(mH_up{t}(:,2))./diff(mH_up{t}(:,1));


%plotting mH
subplot(2,1,1)
grid on
hold all
shift=0.1;
magn(t)=plot(mH_up{t}(:,1),mH_up{t}(:,2)+T(t)*shift,'o-','MarkerSize',3,'Color',cc(t,:));

%plotting dmdH
subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on
dmagn(t)=plot(mH_up{t}(1:end-1,1),dmdH_up{t}+T(t)*shift,'o-','MarkerSize',3,'Color',cc(t,:));

end


figure(1)
subplot(2,1,1)
legend(magn,'5K','7K','9K','11K','13K','15K')
xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(EMU)')

subplot(2,1,2)
legend(dmagn,'2K','5K','7K','9K','11K','13K','15K')
xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (EMU/Oe)')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Checking the hysteresis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mH_dn={};
dmdH_dn={};

data=dlmread(fullfile(Folder,'GaMoS_large2_111_mH_5T_5K_dn.dc.dat'),',',31,0);
mH_dn{1}=[data(:,3),data(:,5)];
dmdH_dn{1}=diff(mH_dn{1}(:,2))./diff(mH_dn{1}(:,1));

figure(2)
cla
subplot(2,1,1)
hold on
box on
grid on
u=plot(mH_up{1}(:,1),mH_up{1}(:,2),'ro-','MarkerSize',3);
d=plot(mH_dn{1}(:,1),mH_dn{1}(:,2),'bo-','MarkerSize',3);
ylim([0 0.4])
xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(EMU)')
legend([u,d],'Sweep up', 'Sweep dn')

subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on
u=plot(mH_up{1}(1:end-1,1),dmdH_up{1},'ro-','MarkerSize',3);
d=plot(mH_dn{1}(1:end-1,1),dmdH_dn{1},'bo-','MarkerSize',3);
ylim([0 3.5e-5])
xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (EMU/Oe)')
legend([u,d],'Sweep up', 'Sweep dn')

%{
for t=3:4
File=['GaMoS_mH_5T_' num2str(T(t)) 'K_dn.dc.dat'];
data=dlmread(fullfile(Folder,File),',',31,0);
mH_dn{t}=[data(:,3),data(:,5)];
dmdH_dn{t}=diff(mH_dn{t}(:,2))./diff(mH_dn{t}(:,1));


%plotting mH
subplot(2,1,1)
hold all
shift=0.1;



plot(mH_up{t}(:,1),mH_up{t}(:,2)+T(t)*shift,'o-','MarkerSize',3,'Color',cc(t-1,:))
plot(mH_dn{t}(:,1),mH_dn{t}(:,2)+T(t)*shift,'o-','MarkerSize',3,'Color',cc_dn(t-1,:))


%plotting dmdH
subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on


plot(mH_up{t}(1:end-1,1),dmdH_up{t}+T(t)*shift,'o-','MarkerSize',3,'Color',cc(t-1,:))
plot(mH_dn{t}(1:end-1,1),dmdH_dn{t}+T(t)*shift,'o-','MarkerSize',3,'Color',cc_dn(t-1,:))

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Comparing chiH and dm/dH @7K
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(6)
cla;
box on
grid on
hold all

l(1)=plot(mH_up{3}(1:end-1,1),dmdH_up{3},'ko-','MarkerSize',2);

%Read chiH @7K
Folder='D:\Adam\Skyrmion\GaMoS\Measurements\2016_11_16_to_Squid\11_16_mH_grid';
File='GaMoS_chiH_7K.ac.dat';

chiH7K=dlmread(fullfile(Folder,File),',',28,0);
freq=3;

data=[chiH7K(:,15) chiH7K(:,3) chiH7K(:,5)/3 chiH7K(:,7)/3];

data=[data(1:171,:);data(173:end,:)];
data7K=reshape(sortrows(data,1),size(data,1)/freq,freq*4);

fr=[10,110,1000];
cc=jet(freq);

for f=1:3
   l(f+1)=plot(data7K(:,f+freq),data7K(:,f+2*freq),'-','Color',cc(f,:));
end
title('Ac vs Dc Susceptibility')
xlabel('Magnetic Field, H(Oe)')
ylabel('Susceptibility, \partialm/\partialH, \chi (EMU/Oe)')
ylim([0,6e-5])
%legend(l,'dc','997Hz','110Hz','11Hz')
%}

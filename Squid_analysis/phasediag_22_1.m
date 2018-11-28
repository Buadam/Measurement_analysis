%clear all;

Folder='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_11_16_Squid\11_26_GaMoS_22_1_mH_grid';

T=[5,9,13,15,17,18,19];
cc=jet(length(T));
cc_dn=winter(3);

mH_up={};
dmdH_up={};

mH_up{1}=[];
dmdH_up{1}=[];

magn=[];
dmagn=[];

m=0.0754; %g   Large2
conv=1.6; %from EMU to muB/fu. (M=710.028 g/mol, m=75.4mg)

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting mH and dm/dH curves for the field swept up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
figure(1)
for t=1:2
    File=['GaMoS_large2_001_mH_5T_' num2str(T(t)) 'K_up.dc.dat'];
    data=dlmread(fullfile(Folder,File),',',31,0);
    mH_up{t}=[data(:,3),data(:,5)*conv];
    dmdH_up{t}=diff(mH_up{t}(:,2))./diff(mH_up{t}(:,1));


%plotting mH
subplot(2,1,1)
grid on
hold all
shift=0.1;
magn(t)=plot(mH_up{t}(:,1),mH_up{t}(:,2)+(T(t)-T(1))*shift,'o-','MarkerSize',3,'Color',cc(t,:));

%plotting dmdH
subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on
dmagn(t)=plot(mH_up{t}(1:end-1,1),dmdH_up{t}+(T(t)-T(1))*shift,'o-','MarkerSize',3,'Color',cc(t,:));

end
%}
figure(1532)
for t=1:1
    File=['GaMoS_large2_22_1_mH_5T_' num2str(T(t)) 'K_up.dc.dat'];
    data=dlmread(fullfile(Folder,File),',',31,0);
    mH_up{t}=[data(:,3),data(:,5)*conv];
    dmdH_up{t}=diff(mH_up{t}(:,2))./diff(mH_up{t}(:,1));

%plotting mH
subplot(2,1,1)
grid on
hold all
shift=0.1;
magn(t)=plot(mH_up{t}(:,1),mH_up{t}(:,2)+(T(t)-T(1))*shift,'o-','MarkerSize',3,'Color',cc(t,:));

%plotting dmdH
subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on
dmagn(t)=plot(mH_up{t}(1:end-1,1),dmdH_up{t}+(T(t)-T(1))*shift,'o-','MarkerSize',3,'Color',cc(t,:));

end

for t=2:length(T)
    File=['GaMoS_large2_22_1_mH_3T_' num2str(T(t)) 'K_up.dc.dat'];

    data=dlmread(fullfile(Folder,File),',',31,0);
    mH_up{t}=[data(:,3),data(:,5)*conv];
    dmdH_up{t}=diff(mH_up{t}(:,2))./diff(mH_up{t}(:,1));
    

%plotting mH
subplot(2,1,1)
grid on
hold all
shift=0.1;
magn(t)=plot(mH_up{t}(:,1),mH_up{t}(:,2)+(T(t)-T(1))*shift,'o-','MarkerSize',3,'Color',cc(t,:));

%plotting dmdH
subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on
dmagn(t)=plot(mH_up{t}(1:end-1,1),dmdH_up{t}+(T(t)-T(1))*shift,'o-','MarkerSize',3,'Color',cc(t,:));

end

figure(1)
subplot(2,1,1)
legend(magn,'5K','9K','13K','15K','17K','18K','19K')
xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(\mu_B/f.u.)')

subplot(2,1,2)
legend(dmagn,'5K','9K','13K','15K','17K','18K','19K')
xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (\mu_B/f.u./Oe)')


figure(2)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Checking the hysteresis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mH_dn={};
dmdH_dn={};

data=dlmread(fullfile(Folder,'GaMoS_large2_22_1_mH_5T_5K_dn.dc.dat'),',',31,0);
mH_dn{1}=[data(:,3),data(:,5)*conv];
dmdH_dn{1}=diff(mH_dn{1}(:,2))./diff(mH_dn{1}(:,1));

figure(2)
cla
subplot(2,1,1)
hold on
box on
grid on
u=plot(mH_up{1}(:,1),mH_up{1}(:,2),'ro-','MarkerSize',3);
d=plot(mH_dn{1}(:,1),mH_dn{1}(:,2),'bo-','MarkerSize',3);
ylim([0 0.8])
xlabel('Magnetic Field, H(Oe)')
ylabel('Magnetization, m(\mu_B/f.u.)')
legend([u,d],'Sweep up', 'Sweep dn')

subplot(2,1,2)
shift=1e-5;
hold all
box on
grid on
u=plot(mH_up{1}(1:end-1,1),dmdH_up{1},'ro-','MarkerSize',3);
d=plot(mH_dn{1}(1:end-1,1),dmdH_dn{1},'bo-','MarkerSize',3);
ylim([0 5e-5])
xlim([0 5e4])
xlabel('Magnetic Field, H(Oe)')
ylabel('\partialm/\partialH (\mu_B/f.u./Oe)')
legend([u,d],'Sweep up', 'Sweep dn')


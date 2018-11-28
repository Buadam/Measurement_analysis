clear all

Folder='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_10_19_222GHz_001\Meas';

N=20;
col_up=autumn(N);
col_dn=winter(N);
figure()
cla
hold all
shift=50e-6;
h=[];

for i=1:N
    
k=i*2;
    if k<10
        File=['gamos_001_222ghz_fc_000' num2str(k) '.dat'];
    else
        File=['gamos_001_222ghz_fc_00' num2str(k) '.dat'];
    end

   
dat=dlmread(fullfile(Folder,File),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
esr_bl=dat(:,2)-bl;

h(i)=plot(B,esr_bl+i*shift,'Color',col_up(i,:));

k=i*2+1;
if k<10
        File=['gamos_001_222ghz_fc_000' num2str(k) '.dat'];
    else
        File=['gamos_001_222ghz_fc_00' num2str(k) '.dat'];
 end
    
dat=dlmread(fullfile(Folder,File),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
esr_bl=dat(:,2)-bl;

d(i)=plot(B,esr_bl+i*shift,'Color',col_dn(i,:));
%}
end

xlabel('Magnetic Field, B(T)')
ylabel('ESR signal (a.u.)')
title('GaMo4S8 B||[001], f=222GHz')
box on
%{
ax1 = gca;
ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position',ax1_pos,...
    'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');
ax2.XColor='none';
ax2.YTick=ax1.YTick;
%}
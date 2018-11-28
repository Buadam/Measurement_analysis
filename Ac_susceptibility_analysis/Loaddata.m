function [all,dmdhc,freq,fr]= Loaddata()
clear all;
cla reset;



Folder='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full';
T11K=dlmread(fullfile(Folder,'GaVS_TR234_tf_11_f_full.ac.dat'),',',28,0);
T11p25K=dlmread(fullfile(Folder,'GaVS_TR234_tf_11p25_f_full.ac.dat'),',',28,0);
T11p5K=dlmread(fullfile(Folder,'GaVS_TR234_tf_11p5_f_full.ac.dat'),',',28,0);
T10p75K=dlmread(fullfile(Folder,'GaVS_TR234_tf_10p75_f_full.ac.dat'),',',28,0);
T12K=dlmread(fullfile(Folder,'GaVS_TR234_tf_12_f_full.ac.dat'),',',28,0);
T10p5K=dlmread(fullfile(Folder,'GaVS_TR234_tf_10p5_f_full.ac.dat'),',',28,0);
T10K=dlmread(fullfile(Folder,'GaVS_TR234_tf_10_f_full.ac.dat'),',',28,0);
T9p5K=dlmread(fullfile(Folder,'GaVS_TR234_tf_9p5_f_full.ac.dat'),',',28,0);
T9K=dlmread(fullfile(Folder,'GaVS_TR234_tf_9_f_full.ac.dat'),',',28,0);
T8K=dlmread(fullfile(Folder,'GaVS_TR234_tf_8_f_full.ac.dat'),',',28,0);
T7K=dlmread(fullfile(Folder,'GaVS_TR234_tf_7_f_full.ac.dat'),',',28,0);
T6p5K=dlmread(fullfile(Folder,'GaVS_TR234_tf_6p5_f_full.ac.dat'),',',28,0);
T8p5K=dlmread(fullfile(Folder,'GaVS_TR234_tf_8p5_f_full.ac.dat'),',',28,0);

%{
T11rso=dlmread(fullfile(Folder,'GaVS_TR234_tf_11.rso.dat'),',',32,0);
data11dc=[T11rso(:,3) T11rso(:,5)];
[dmdh11(:,1),dmdh11(:,2)]=centdiff(data11dc);

T11p5rso=dlmread(fullfile(Folder,'GaVS_TR234_tf_11p5.rso.dat'),',',32,0);
data11p5dc=[T11p5rso(:,3) T11p5rso(:,5)];
[dmdh11p5(:,1),dmdh11p5(:,2)]=centdiff(data11p5dc);
%}


Folder_dc='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\06_01_GVS_111_TR234_re\06_01_mH_rso';

T6p5rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_6p5K_mH_rso.rso.dat'),',',32,0);
data6p5dc=[T6p5rso(:,3) T6p5rso(:,5)];
[dmdh6p5(:,1),dmdh6p5(:,2)]=centdiff(data6p5dc);

T7rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_7K_mH_rso.rso.dat'),',',32,0);
data7dc=[T7rso(:,3) T7rso(:,5)];
[dmdh7(:,1),dmdh7(:,2)]=centdiff(data7dc);

T8rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_8K_mH_rso.rso.dat'),',',32,0);
data8dc=[T8rso(:,3) T8rso(:,5)];
[dmdh8(:,1),dmdh8(:,2)]=centdiff(data8dc);

T8p5rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_8p5K_mH_rso.rso.dat'),',',32,0);
data8p5dc=[T8p5rso(:,3) T8p5rso(:,5)];
[dmdh8p5(:,1),dmdh8p5(:,2)]=centdiff(data8p5dc);

T9rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_9K_mH_rso.rso.dat'),',',32,0);
data9dc=[T9rso(:,3) T9rso(:,5)];
[dmdh9(:,1),dmdh9(:,2)]=centdiff(data9dc);

T9p5rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_9p5K_mH_rso.rso.dat'),',',32,0);
data9p5dc=[T9p5rso(:,3) T9p5rso(:,5)];
[dmdh9p5(:,1),dmdh9p5(:,2)]=centdiff(data9p5dc);

T10rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_10K_mH_rso.rso.dat'),',',32,0);
data10dc=[T10rso(:,3) T10rso(:,5)];
[dmdh10(:,1),dmdh10(:,2)]=centdiff(data10dc);

T10p5rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_10p5K_mH_rso.rso.dat'),',',32,0);
data10p5dc=[T10p5rso(:,3) T10p5rso(:,5)];
[dmdh10p5(:,1),dmdh10p5(:,2)]=centdiff(data10p5dc);

T10p75rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_10p75K_mH_rso.rso.dat'),',',32,0);
data10p75dc=[T10p75rso(:,3) T10p75rso(:,5)];
[dmdh10p75(:,1),dmdh10p75(:,2)]=centdiff(data10p75dc);

T11rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_11K_mH_rso.rso.dat'),',',32,0);
data11dc=[T11rso(:,3) T11rso(:,5)];
[dmdh11(:,1),dmdh11(:,2)]=centdiff(data11dc);

T11p25rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_11p25K_mH_rso.rso.dat'),',',32,0);
data11p25dc=[T11p25rso(:,3) T11p25rso(:,5)];
[dmdh11p25(:,1),dmdh11p25(:,2)]=centdiff(data11p25dc);

T11p5rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_11p5K_mH_rso.rso.dat'),',',32,0);
data11p5dc=[T11p5rso(:,3) T11p5rso(:,5)];
[dmdh11p5(:,1),dmdh11p5(:,2)]=centdiff(data11p5dc);

T12rso=dlmread(fullfile(Folder_dc,'GaVS_TR234_re_12K_mH_rso.rso.dat'),',',32,0);
data12dc=[T12rso(:,3) T12rso(:,5)];
[dmdh12(:,1),dmdh12(:,2)]=centdiff(data12dc);

freq=7;

data=[T6p5K(:,15) T6p5K(:,3) T6p5K(:,5)/3 T6p5K(:,7)/3];
data6p5=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T8K(:,15) T8K(:,3) T8K(:,5)/3 T8K(:,7)/3];
data8=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T8p5K(:,15) T8p5K(:,3) T8p5K(:,5)/3 T8p5K(:,7)/3];
data8p5=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T7K(:,15) T7K(:,3) T7K(:,5)/3 T7K(:,7)/3];
data7=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T9K(:,15) T9K(:,3) T9K(:,5)/3 T9K(:,7)/3];
data=data(1:217,:);
data9=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T9p5K(:,15) T9p5K(:,3) T9p5K(:,5)/3 T9p5K(:,7)/3];
data9p5=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T10K(:,15) T10K(:,3) T10K(:,5)/3 T10K(:,7)/3];
data10=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T10p5K(:,15) T10p5K(:,3) T10p5K(:,5)/3 T10p5K(:,7)/3];
data10p5=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T10p75K(:,15) T10p75K(:,3) T10p75K(:,5)/3 T10p75K(:,7)/3];
data10p75=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T11K(:,15) T11K(:,3) T11K(:,5)/3 T11K(:,7)/3];
data11=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T11p25K(:,15) T11p25K(:,3) T11p25K(:,5)/3 T11p25K(:,7)/3];
data11p25=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T11p5K(:,15) T11p5K(:,3) T11p5K(:,5)/3 T11p5K(:,7)/3];
data11p5=reshape(sortrows(data,1),size(data,1)/freq,freq*4);
data=[T12K(:,15) T12K(:,3) T12K(:,5)/3 T12K(:,7)/3];
data12=reshape(sortrows(data,1),size(data,1)/freq,freq*4);

all={data6p5,data7,data8,data8p5,data9,data9p5,data10,data10p5,data10p75,data11,data11p25,data11p5,data12};
dmdhc={dmdh6p5,dmdh7,dmdh8,dmdh8p5,dmdh9,dmdh9p5,dmdh10,dmdh10p5,dmdh10p75,dmdh11,dmdh11p25,dmdh11p5,dmdh12};


fr={};
freq=[];
T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
data=data8p5;
cc=jet(7);



%%
%Plot data
%%
%Plot susceptibility
figure(1)
shift=10e-4;
cla
hold all
box on
grid on
xlim([0,700])
ylim([0,6.1e-3])
xlabel('Magnetic field, H(Oe)')
ylabel('\chi^{,} (EMU/Oe)')
for t=1:numel(T)
    freq(t)=size(all{t},2)/4;
    fr{t}=all{t}(1,1:freq(t));
    for f=1:freq(t)
        h_f(f)=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+(T(t)-T(1))*shift,'o-','Color',cc(f,:),'MarkerSize',4);
    end
    %Plot dc susceptibilities
    if ~isempty(dmdhc{t})
        dmdhcent=dmdhc{t};
        h_dc=plot(dmdhcent(:,1),dmdhcent(:,2)+(T(t)-T(1))*shift,'ko-','MarkerSize',4);
    end
end
legend([h_dc,h_f],'dc','0.1Hz','1Hz','10Hz','45Hz','110Hz','500Hz','1000Hz')


%Plot discipation
figure(2)
shift=2e-4;
cla
hold all
box on
grid on
xlim([0,700])
ylim([0,1.2e-3])
xlabel('Magnetic field, H(Oe)')
ylabel('\chi^{,} (EMU/Oe)')
for t=1:numel(T)
    for f=1:freq(t)
        h_f(f)=plot(all{t}(:,f+freq(t)),all{t}(:,f+3*freq(t))+(T(t)-T(1))*shift,'o-','Color',cc(f,:),'MarkerSize',4);
    end
end
legend([h_f],'0.1Hz','1Hz','10Hz','45Hz','110Hz','500Hz','1000Hz')

end
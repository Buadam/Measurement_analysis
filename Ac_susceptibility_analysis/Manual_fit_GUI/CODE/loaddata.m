function all=loaddata()


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

T11p5rso=dlmread(fullfile(Folder,'GaVS_TR234_tf_11p5.rso.dat'),',',32,0);
T11rso=dlmread(fullfile(Folder,'GaVS_TR234_tf_11.rso.dat'),',',32,0);
data11dc=[T11rso(:,3) T11rso(:,5)];
data11p5dc=[T11p5rso(:,3) T11p5rso(:,5)];

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

end
%{
fits_CC_cycfm={};
fits_CC_cycsky={};
fits_CC_skyfm={};
fits_CC_cycfm_bl={};
fits_CC_cycsky_bl={};
fits_CC_skyfm_bl={};
%}
addpath('G:\Adam\Install\Mathworks.Matlab.R2015a.x64.ISO-TBE\altmany-export_fig-2763b78\altmany-export_fig-2763b78')

T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
Savefolder='Fitted_Cole_Cole_publ';
s=1; %save images?

cl=1;
dB=20;

Bt1=[20,20,20,20,80,100,120,160,180,180,180,180,160]; %Total range to plot
Bt2=[280,300,380,400,480,520,580,620,620,640,640,700,700]; %Total range to plot

B1=[20,40,60,100,160,180];
B2=[240,260,360,380,400,460];
B11=[B1,240,180,240,220,220,220,180];
B21=[B2,340,340,340,320,320,300,260];
B12=[B1,340,380,400,420,480,480,480];
B22=[B2,500,560,580,620,620,620,660];



t=3;
    Branges=[80,380,100,360];
    fit_susc_B_T_publ(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},0,logtau(t),s,Savefolder,cl);
%{
t=8;
    Branges=[200,580,220,540];
    fit_susc_B_T_publ(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},0,logtau(t),s,Savefolder,cl);
 
t=9;
    Branges=[220,600,240,580];
    fit_susc_B_T_publ(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},0,logtau(t),s,Savefolder,cl);    


t=10;
    Branges=[200,640,220,620];
    fit_susc_B_T_publ(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},0,logtau(t),s,Savefolder,cl); 
%}
%{
for t=7:13
    s=0;
    cl=1;
    Branges=[Bt1(t),Bt2(t),B11(t),B21(t)];
    fits_CC_cycsky{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},0,logtau(t),s,Savefolder,cl,s2,functionfolder1);
    cl=0;
    s=2;
    Branges=[Bt1(t),Bt2(t),B12(t),B22(t)];
    fits_CC_skyfm{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},0,logtau(t),s,Savefolder,cl,s2,functionfolder1);
end    


for t=7:13    
    s=0;
    cl=1;
    Branges=[Bt1(t),Bt2(t),B11(t),B21(t)];
    fits_CC_cycsky_bl{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},1,logtau(t),s,Savefolder,cl,s2,functionfolder2);
    cl=0;
    s=2;
    Branges=[Bt1(t),Bt2(t),B12(t),B22(t)];
    fits_CC_skyfm_bl{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},1,logtau(t),s,Savefolder,cl,s2,functionfolder2);
end
%}
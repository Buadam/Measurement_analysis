fits_CC_cycfm_bl={};
fits_CC_cycsky_bl={};
fits_CC_skyfm_bl={};


T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
Savefolder='Fitted_Cole_Cole_blcorr';
s=1; %save images?
s2=0; %save functions and parameters
functionfolder='Fitted_fns_blcorr';
blcorr=[1,1,1,1,1,1,1,1,1,1,1,1,1]; %Use baseline-corrected chi signals
logtau=[0,0,0,0,0,0,0,0,0,0,0,0,0]; %Use logarithmic scale when fitting tau

cl=1;
dB=20;

Bt1=[20,20,100,140,160,180,200,200,180,180,180,180,160]; %Total range to plot
Bt2=[280,300,380,400,440,520,580,620,620,640,640,700,700]; %Total range to plot

B1=[80,80,120,180,220,220];
B2=[240,260,360,380,400,420];
B11=[B1,240,240,240,220,220,220,180];
B21=[B2,340,340,340,320,320,300,260];
B12=[B1,340,380,400,420,480,480,480];
B22=[B2,500,560,580,620,620,620,660];



for t=1:6
    Branges=[Bt1(t),Bt2(t),B1(t),B2(t)];
    fits_CC_cycfm_bl{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},blcorr(t),logtau(t),s,Savefolder,cl,s2,functionfolder);
end


for t=7:13
    s=0;
    cl=1;
    Branges=[Bt1(t),Bt2(t),B11(t),B21(t)];
    fits_CC_cycsky_bl{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},blcorr(t),logtau(t),s,Savefolder,cl);
    cl=0;
    s=2;
    Branges=[Bt1(t),Bt2(t),B12(t),B22(t)];
    fits_CC_skyfm_bl{t}=fit_susc_B_T(fr{t},all,dmdhc{t},t,Branges,dB,Chi_blcorr,Chi_baseline{t},blcorr(t),logtau(t),s,Savefolder,cl);
end

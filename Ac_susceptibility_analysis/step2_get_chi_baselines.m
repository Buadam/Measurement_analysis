baseline={};

chi_cyc=zeros(13,1);
chi_sky=zeros(13,1);
chi_fm=zeros(13,1);

chi_cyc2=zeros(3,1);
chi_sky2=zeros(3,1);
chi_fm2=zeros(3,1);

shift=10e-4;
B={};

for t=1:5
%Find chi baselines
    B{t} = all{t}(1,8):0.1:all{t}(end,8);
    w=[70,75,50,50,50];
    B0=[125,150,200,230,280];
    ind1=find(all{t}(:,8)>B0(t)-3*w(t),1);
    if (B0(t)+3*w(t))>=all{t}(end,8)
        ind2=numel(all{t}(:,8));
    else
        ind2=find(all{t}(:,8)>3*w(t)+B0(t),1);
    end

    chi_fm(t)=all{t}(ind2,5+2*freq(t));
    chi_cyc(t)=all{t}(ind1,5+2*freq(t));
    D=chi_fm(t)-chi_cyc(t);
    Chi_baseline{t} = D*normcdf(B{t},B0(t),w(t))+chi_cyc(t);
    %dlmwrite(['Fitresults\Chi_baseline_T' num2str(T(t)) 'K.txt'],[B' Chi_baseline{t}'],'-append')
    f=7;
    Bmeas{t}=all{t}(:,f+freq(t));
   
    for f=1:7
        baseline{t}=interp1(B{t},Chi_baseline{t},all{t}(:,f+freq(t)));
        Chi_blcorr{t}{f}=all{t}(:,f+2*freq(t))-baseline{t};
    end
    %saveas(gca,['Fitresults\Chi_baseline_removed_T' num2str(T(t)) 'K.png'])
end

for t=3:5
%Find chi baselines
    B{t} = all{t}(1,8):0.1:all{t}(end,8);
    w1=[10,15,25];
    w2=[50,30,25];
    B01=[150,195,230];
    B02=[265,310,340];
    ind1=find(all{t}(:,8)>B01(t-2)-3*w1(t-2),1);
    ind2=find(all{t}(:,8)>3*w1(t-2)+B01(t-2),1);
    ind3=find(all{t}(:,8)>3*w2(t-2)+B02(t-2),1);

    chi_fm2(t)=all{t}(ind3,7+2*freq(t));
    chi_sky2(t)=all{t}(ind2,7+2*freq(t));
    chi_cyc2(t)=all{t}(ind1,7+2*freq(t));

    D2=chi_fm2(t)-chi_sky2(t);
    D1=chi_sky2(t)-chi_cyc2(t);

    Chi_baseline{t} = D1*normcdf(B{t},B01(t-2),w1(t-2))+D2*normcdf(B{t},B02(t-2),w2(t-2))+chi_cyc2(t); 
    Bmeas{t}=all{t}(:,f+freq(t));
    for f=1:7
        baseline{t}=interp1(B{t},Chi_baseline{t},all{t}(:,f+freq(t)));
        Chi_blcorr{t}{f}=all{t}(:,f+2*freq(t))-baseline{t};
    end

end

for t=6:13
%Find chi baselines
    B{t} = all{t}(1,8):0.1:all{t}(end,8);
    w1=[20,30,15,20,20,20,25,50];
    w2=[35,40,40,25,25,25,40,80];
    B01=[255,255,250,255,250,240,240,210];
    B02=[370,420,500,540,570,600,560,580];
    ind1=find(all{t}(:,8)>B01(t-5)-3*w1(t-5),1);
    ind2=find(all{t}(:,8)>3*w1(t-5)+B01(t-5),1);
    ind3=find(all{t}(:,8)>3*w2(t-5)+B02(t-5),1);

    chi_fm(t)=all{t}(ind3,7+2*freq(t));
    chi_sky(t)=all{t}(ind2,7+2*freq(t));
    chi_cyc(t)=all{t}(ind1,7+2*freq(t));

    D2=chi_fm(t)-chi_sky(t);
    D1=chi_sky(t)-chi_cyc(t);

    Chi_baseline{t} = D1*normcdf(B{t},B01(t-5),w1(t-5))+D2*normcdf(B{t},B02(t-5),w2(t-5))+chi_cyc(t); 
    Bmeas{t}=all{t}(:,f+freq(t));
    for f=1:7
        
        baseline{t}=interp1(B{t},Chi_baseline{t},all{t}(:,f+freq(t)));
        Chi_blcorr{t}{f}=all{t}(:,f+2*freq(t))-baseline{t};
    end

end

figure(3)
cla
hold all
box on
grid on
xlim([0,700])
xlabel('Magnetic field, H(Oe)')
ylabel('\chi^{,} (EMU/Oe)')
for t=1:13
    for f=1:7
        h_f(f)=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+(T(t)-T(1))*shift,'o-','Color',cc(f,:),'MarkerSize',4);
    end
    
    %Plot baselines
    h_bl=plot(B{t},Chi_baseline{t}+(T(t)-T(1))*shift,'g-.');
    
    %Plot dc susceptibilities
    if t==10
        chidc=data11dc;
        dmdh=(chidc(2:end,2)-chidc(1:end-1,2))./(chidc(2:end,1)-chidc(1:end-1,1));
        dmdhx=(chidc(1:end-1,1)+chidc(2:end,1))/2;
        h_dc=plot(dmdhx,dmdh+(T(t)-T(1))*shift,'k-');
    elseif t==12
        chidc=data11p5dc;
        dmdhx=(chidc(1:end-1,1)+chidc(2:end,1))/2;
        dmdh=(chidc(2:end,2)-chidc(1:end-1,2))./(chidc(2:end,1)-chidc(1:end-1,1));
        plot(dmdhx,dmdh+(T(t)-T(1))*shift,'k-')
    end
end
legend([h_bl,h_dc,h_f],'Baseline','dc','0.1Hz','1Hz','10Hz','45Hz','110Hz','500Hz','1000Hz')


baseline={};
chi_cyc=zeros(13,1);
chi_sky=zeros(13,1);
chi_fm=zeros(13,1);

shift=10e-4;

for t=1:5
    
figure(1)
hold on
for f=1:freq(t)
   plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+(T(t)-T(1))*shift,'-','Color',cc(f,:))
end

%Find chi baselines
B = all{t}(1,8):0.1:all{t}(end,8);
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
Chi_baseline{t} = D*normcdf(B,B0(t),w(t))+chi_cyc(t);
%dlmwrite(['Fitresults\Chi_baseline_T' num2str(T(t)) 'K.txt'],[B' Chi_baseline{t}'],'-append')
%D*sigmoid(B,w(t)/10000,B0(t))+all{t}(ind1,7+2*freq(t));
plot(B,Chi_baseline{t}+(T(t)-T(1))*shift,'g-.')
%saveas(gca,['Fitresults\Chi_baseline_T' num2str(T(t)) 'K.png'])

Bmeas{t}=all{t}(:,f+freq(t));
figure(2)
hold on
for f=1:freq(t)
baseline{t}=interp1(B,Chi_baseline{t},all{t}(:,f+freq(t)));
Chi_blcorr{t}{f}=all{t}(:,f+2*freq(t))-baseline{t};
plot(Bmeas{t},Chi_blcorr{t}{f}+(T(t)-T(1))*shift,'-','Color',cc(f,:))
end
%saveas(gca,['Fitresults\Chi_baseline_removed_T' num2str(T(t)) 'K.png'])
end

for t=6:13
%Find chi baselines
B = all{t}(1,8):0.1:all{t}(end,8);
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

Chi_baseline{t} = D1*normcdf(B,B01(t-5),w1(t-5))+D2*normcdf(B,B02(t-5),w2(t-5))+chi_cyc(t);
plot(B,Chi_baseline{t}+(T(t)-T(1))*shift,'g-.')
%dlmwrite(['Fitresults\Chi_baseline_T' num2str(T(t)) 'K.txt'],[B' Chi_baseline{t}'],'-append')

%Plot baseline-corrected Re(Chi)
Bmeas{t}=all{t}(:,f+freq(t));
figure(1)
hold on
for f=1:7
Chi_blcorr{t}{f}=all{t}(:,f+2*freq(t))-interp1(B,Chi_baseline{t},all{t}(:,f+freq(t)));
plot(Bmeas{t},Chi_blcorr{t}{f}+(T(t)-T(1))*shift,'-','Color',cc(f,:))
end
end

for t=1:13;

figure(1)
hold on

%Include dc susceptibility
if t==10
    chidc=data11dc;
    dmdh=(chidc(2:end,2)-chidc(1:end-1,2))./(chidc(2:end,1)-chidc(1:end-1,1));
    plot(chidc(1:end-1,1),dmdh+(T(t)-T(1))*shift,'k-')
elseif t==12
    chidc=data11p5dc;
    dmdh=(chidc(2:end,2)-chidc(1:end-1,2))./(chidc(2:end,1)-chidc(1:end-1,1));
    plot(chidc(1:end-1,1),dmdh+(T(t)-T(1))*shift,'k-')
end

for f=1:7
   plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+(T(t)-T(1))*shift,'-','Color',cc(f,:))
end
end
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Fit resonances
%shift=5e-5;

shift=5e-4;
for t=1:5
for f=1:freq(t)
signal=[Bmeas{t} Chi_blcorr{t}{f}];
figure(100)
[FitRes{t}{f},GOF,baseline,coeff,residual,x{t}{f},y{t}{f}]=...
peakfit(signal,...
    0,... %Center
    0,... %Data window
    1,...   %NumPeaks
    1,...   %PeakShape: 1:Gaussian, 2:Lorenzian
    0,...   %Extra: exponentially broadened fns
    5,...  %NumTrials
    [200       100],... %Initial parameters start=[position1 width1 position2 width2 ...]
    0,...   %Autozero 0:no baseline, 1:linear baseline, 2:quadratic, 3:flat baseline
    [3.7],... %
    1 ,...  %Plot 0:no plotting, 1:default plotting
    0,...   %Bipolar: 0:only positive peak, 1:negative peak allowed
    30,...  %Minimal peak width
    5.8... 
     );
    %8.3156e-05... %Delta: restart variance if NumTrials>1
    
%dlmwrite('Fitresults\CycFM_chi_all.txt',FitResults,'-append')

end
end

for t=6:13
for f=1:freq(t)
signal=[Bmeas{t} Chi_blcorr{t}{f}];
figure(100)

if ((t==7) && (f==5))
   [FitRes{t}{f},GOF,baseline,coeff,residual,x{t}{f},y{t}{f}]= peakfit(signal,570,1140,2,1,0,10, [288.8586      43.32707      418.3249      122.9822], 0, [5.1], 1 ,0,20,0,4.0617e-05);
elseif ((t==7) && (f==6))
   [FitRes{t}{f},GOF,baseline,coeff,residual,x{t}{f},y{t}{f}]= peakfit(signal,570,1140,2,1,0,10, [307.6763      27.95413      417.3648      110.4792], 0, [5.1], 1 ,0,20,0,2.0623e-05);
else
[FitRes{t}{f},GOF,baseline,coeff,residual,x{t}{f},y{t}{f}]=...
peakfit(signal,...
    550,... %Center
    1100,... %Data window
    2,...   %NumPeaks
    1,...   %PeakShape: 1:Gaussian, 2:Lorenzian 26:Slope
    0,...   %Extra: exponentially broadened fns
    1,...  %NumTrials
    [267.5754       49.1547      485.4511        71.708],... %Initial parameters start=[position1 width1 position2 width2 ...]
    0,...   %Autozero 0:no baseline, 1:linear baseline, 2:quadratic, 3:flat baseline
    [3],... %
    1 ,...  %Plot 0:no plotting, 1:default plotting
    0,...   %Bipolar: 0:only positive peak, 1:negative peak allowed
    20,...  %Minimal peak width
    11 ... 
     );
    %8.3156e-05... %Delta: restart variance if NumTrials>1
end

%dlmwrite('Fitresults\CycSky_chi_all.txt',FitResults(1,:),'-append')
%dlmwrite('Fitresults\SkyFM_chi_all.txt',FitResults(2,:),'-append')

end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting

%Plotting all fitted curves in the same graph
hFig=figure(200);
cla
hold all
box on
%title('GaV_4S_8 [111], Out-of-phase signal')

xlabel('Magnetic Field, H(Oe)','FontSize',10)
ylabel('\chi_{ac}^{,} (EMU/Oe)','FontSize',10)
shift=5e-4;
xlim([0 700])
ylim([0 3.2e-3])
for t=1:numel(T)
B = all{t}(1,8):0.1:all{t}(end,8);
bl=plot(B,Chi_baseline{t}+(T(t)-T(1))*shift,'g-.');
    for f=1:freq(t)
        if t<6
           plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+(T(t)-T(1))*shift,'o','MarkerSize',2,'Color',cc(f,:));
           plot(x{t}{f},y{t}{f}+interp1(B,Chi_baseline{t},x{t}{f})+(T(t)-T(1))*shift,'Color',cc(f,:),'Linewidth',0.5);
           
        else
            me(f)=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+(T(t)-T(1))*shift,'o','MarkerSize',2,'Color',cc(f,:));       
            fi(f)=plot(x{t}{f},y{t}{f}(1,:)+y{t}{f}(2,:)+interp1(B,Chi_baseline{t},x{t}{f})+(T(t)-T(1))*shift,'Color',cc(f,:),'Linewidth',0.5);
        end
    end
end
legend([fi bl],'f=0.1Hz','f=1Hz','f=10Hz','f=45Hz','f=110Hz','f=500Hz','f=1000Hz','Baseline \chi_{eq}' )

set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 8.6 10]);
set(gca,'FontSize',8)


%}
%{

%Plot the static susceptibilities
figure(321)
hold on
c=plot(T(1:13),chi_cyc(1:13),'bo-');
f=plot(T(1:13),chi_fm(1:13),'ro-');
s=plot(T(6:13),chi_sky(6:13),'go-');
legend([c,s,f],'Cycloidal Phase','Skyrmion Phase','Ferromagnetic Phase')
box on
title('Zero-freq(t)uency limit of the AC-\chi')
xlabel('Temperature, T(K)')
ylabel('AC-Susceptibility, \chi_{AC}(0)')

figure(421)
hold on
c=plot(T(1:13),1./chi_cyc(1:13),'bo-');
f=plot(T(1:13),1./chi_fm(1:13),'ro-');
s=plot(T(6:13),1./chi_sky(6:13),'go-');
legend([c,s,f],'Cycloidal Phase','Skyrmion Phase','Ferromagnetic Phase')
box on
title('Zero-freq(t)uency limit of the AC-\chi')
xlabel('T(K)')
ylabel('\chi_{AC}^{-1}(EMU/Oe)^{-1}')

%}
%{
%Plot one specific fit
figure(5)
box on
xlabel('Magnetic Field, H(Oe)')
ylabel('Susceptibility, Re(\chi_{AC})')
t=10;
f=5;
B = all{t}(1,8):0.1:all{t}(end,8);
if t<6
   meas=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t)),'ko');
   hold on
   fit=plot(x{t}{f},y{t}{f}+interp1(B,Chi_baseline{t},x{t}{f}),'r-');
   bl=plot(B,Chi_baseline{t},'g-.');
   legend([meas,fit,bl],'Measured Data', 'Gaussian Fit', 'Subtracted baseline')
else
   meas=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t)),'ko');
   hold on
   fit=plot(x{t}{f},y{t}{f}(1,:)+y{t}{f}(2,:)+interp1(B,Chi_baseline{t},x{t}{f}),'r-');
   fit1=plot(x{t}{f},y{t}{f}(1,:),'b-');
   fit2=plot(x{t}{f},y{t}{f}(2,:),'b-');
   bl=plot(B,Chi_baseline{t},'g-.');
   legend([meas,fit,fit1,fit2,bl],'Measured Data', 'Gaussian Fit', 'Cyc->Sky peak', 'Sky->FM peak', 'Subtracted baseline')
end
hold off
%}

%{
for t=1:numel(T)
figure(t+10)
hold all
box on
title(['T= ' num2str(T(t))  'K'])
xlabel('Magnetic Field, H(Oe)')
ylabel('Ac-Susceptibility, Re(m) (EMU/Oe)')
    for f=1:freq(t)
    signal=[Bmeas{t} Chi_blcorr{t}{f}];
        if t<6
            h(f)=plot(signal(:,1),signal(:,2)+f*shift,'o','Color',cc(f,:),'MarkerSize', 3);
            plot(x{t}{f},y{t}{f}+f*shift,'-','Color',cc(f,:));
        else
            h(f)=plot(signal(:,1),signal(:,2)+f*shift,'o','Color',cc(f,:),'MarkerSize', 3);
            plot(x{t}{f},y{t}{f}(1,:)+y{t}{f}(2,:)+f*shift,'-','Color',cc(f,:));
        end
    end
legend(h,'f=0.1Hz','f=1Hz','f=10Hz','f=45Hz','f=110Hz','f=500Hz','f=1000Hz')
%saveas(figure(t+10),['Resonances_Chi_T_' num2str(T(t)) 'K.png'])
end
%}



%{
%Plotting all fitted curves separately
figure(1000)
box on
xlabel('Magnetic Field, H(Oe)')
ylabel('Susceptibility, Re(\chi_{AC})(f)')
for t=1:numel(T)
B = all{t}(1,8):0.1:all{t}(end,8);
    for f=1:freq(t)
        if t<6
            meas=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t)),'ko');
            hold on
            fit=plot(x{t}{f},y{t}{f}+interp1(B,Chi_baseline{t},x{t}{f}),'r-');
            bl=plot(B,Chi_baseline{t},'g-.');
            legend([meas,fit,bl],'Measured Data', 'Gaussian Fit', 'Subtracted baseline')
        else
            meas=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t)),'ko');
            hold on
            fit=plot(x{t}{f},y{t}{f}(1,:)+y{t}{f}(2,:)+interp1(B,Chi_baseline{t},x{t}{f}),'r-');
            fit1=plot(x{t}{f},y{t}{f}(1,:),'b-');
            fit2=plot(x{t}{f},y{t}{f}(2,:),'b-');
            bl=plot(B,Chi_baseline{t},'g-.');
            legend([meas,fit,fit1,fit2,bl],'Measured Data', 'Gaussian Fit', 'Cyc->Sky peak', 'Sky->FM peak', 'Subtracted baseline')
        end
        
        hold off
        %saveas(figure(1000),['Fitresults\Fittedchi\Fitted_curve_T_' num2str(T(t)) 'K_f_' num2str(fr(f)) 'Hz.png']);
    end
end


%Plotting fitted curves at each temperature, shifted proportional to log(f)
figure(2000)
for t=1:numel(T)
B = all{t}(1,8):0.1:all{t}(end,8);
    for f=1:freq(t)
        if t<6
        meas=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+f*shift,'ko');
        hold on
        fit=plot(x{t}{f},y{t}{f}+interp1(B,Chi_baseline{t},x{t}{f})+f*shift,'r-');
        bl=plot(B,Chi_baseline{t}+f*shift,'g-.');
        else
        meas=plot(all{t}(:,f+freq(t)),all{t}(:,f+2*freq(t))+f*shift,'ko');
        hold on
        fit=plot(x{t}{f},y{t}{f}(1,:)+y{t}{f}(2,:)+interp1(B,Chi_baseline{t},x{t}{f})+f*shift,'r-');
        bl=plot(B,Chi_baseline{t}+f*shift,'g-.');    
        fit1=plot(x{t}{f},y{t}{f}(1,:)+f*shift,'b-');
        fit2=plot(x{t}{f},y{t}{f}(2,:)+f*shift,'b-');
        end
    end
box on
xlabel('Magnetic Field, H(Oe)')
ylabel('Susceptibility, Re(\chi_{AC})(f)')
if t<6
legend([meas,fit,bl],'Measured Data', 'Gaussian Fit', 'Subtracted baseline')
else
legend([meas,fit,fit1,fit2,bl],'Measured Data', 'Gaussian Fit', 'Cyc->Sky peak', 'Sky->FM peak', 'Subtracted baseline')
end    
%saveas(figure(2000),['Fitresults\Fittedchi\Fitted_curves_T_' num2str(T(t)) 'K.png']);
hold off
end

%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Write fitting results to file
%{
CycFMchi=zeros(freq(t),5*4);
SkyFMchi=zeros(freq(t),8*4);
CycSkychi=zeros(freq(t),8*4);
for f=1:freq(t)
    for t=1:numel(T)
        if t<6
            CycFMchi(f,(t-1)*4+1:t*4)=FitRes{t}{f}(2:end);
        else
            CycSkychi(f,(t-6)*4+1:(t-5)*4)=FitRes{t}{f}(1,2:end); 
            SkyFMchi(f,(t-6)*4+1:(t-5)*4)=FitRes{t}{f}(2,2:end); 
        end
    end
    
end
%Header

dlmwrite('Fitresults\CycFM_chi.txt',CycFMchi,'-append')
dlmwrite('Fitresults\CycSky_chi.txt',CycSkychi,'-append')
dlmwrite('Fitresults\SkyFM_chi.txt',SkyFMchi,'-append')
%}


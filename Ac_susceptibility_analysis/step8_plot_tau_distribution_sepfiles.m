Folder='G:\Adam\Research\Skyrmion\GVS\2016_02_Squid\GaVS_111_TR234\GaVS_111_chi_H_full\_0_Summary\Fit_Chi_B_T_f_Cole_Cole\Fitted_fns_bestfits';
addpath('G:\Adam\Install\Mathworks.Matlab.R2015a.x64.ISO-TBE\altmany-export_fig-2763b78\altmany-export_fig-2763b78')


Bcycfm={60:20:240,...   %6.5K
        80:20:260,...   %7K
        160:20:360,...  %8K
        180:20:380,...  %8.5K
        220:20:400,...  %9K
        180:20:460};    %9.5K
        
Bcycsky={240:20:340,... %10K
         240:20:320,... %10.5K
         240:20:320,... %10.75K
         220:20:300,... %11K
         220:20:320,... %11.25K
         220:20:300,... %11.5K
         180:20:260};   %12K
         
Bskyfm= {340:20:500,... %10K
        400:20:540,...  %10.5K
        440:20:560,...  %10.75K
        460:20:580,...  %11K
        420:20:620,...  %11.25K
        480:20:620,...  %11.5K
        [480:20:560,600]};  %12K

    
    
tau_cycfm_logmean=zeros(5,1);
tau_cycsky_logmean=zeros(8,1);
tau_skyfm_logmean=zeros(8,1);  

tau_cycfm_mean=zeros(5,1);
tau_cycsky_mean=zeros(8,1);
tau_skyfm_mean=zeros(8,1);  
    
T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];  

parameters={};
for t=1:13
    parameters{t}=dlmread(fullfile(Folder,['params_' num2str(T(t)) 'K.txt']),'\t',0,0);
end


figure(123456)
cla
hold all
box on
grid on
colT=jet(length(T));
set(gca,'ZScale','log')
view(100,25)
for t=1:6
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1);
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
   
   % plot3(B,T(t)*ones(length(B)),fits_eq_blcorr{t}(:,2),'.-','Color','r')%colT(t,:))
    %plot3(B,T(t)*ones(length(B)),fits_neq_blcorr{t}(:,2),'.-','Color','b')%colT(t,:))
    x=B;
    y=T(t)*ones(1,length(B));
    z=tau';
    col=log10(z);
    scatter3(x,y,z,10,col)
    %line(B',T(t)*ones(1,length(B))',fits_neq_blcorr{t}(:,2))
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);
    
end

for t=7:13
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycsky{t-6})
        tempind=find(Ball>Bcycsky{t-6}(i),1);
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    x=B;
    y=T(t)*ones(1,length(B));
    z=tau;
    col=log10(z);
    scatter3(x,y,z,10,col)
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);
    
    
    ind=[];
    for i=1:numel(Bskyfm{t-6})
        tempind=find(Ball>Bskyfm{t-6}(i),1);
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end
    
    B=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    
    x=B;
    y=T(t)*ones(1,length(B));
    z=tau;
    col=log10(z);
    scatter3(x,y,z,10,col)
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);

end



%Plotting Tau distributions
hFig1=figure(123458);
cla
hold all
box on
grid on
colt=jet(numel(T));
view(40,10)
set(gca,'XScale','log')

tauD=logspace(-10,10,50);
shift=0.4;
for t=1:5 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
          ind(i)=numel(Ball);
        else
          ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(1))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
end


hFig2=figure(123459);
cla
hold all
box on
grid on

view(40,10)
set(gca,'XScale','log')
for t=6:6 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(t-6)*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)  
    end
end

shift=0.4;

for t=[7,8,10,12,13]
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycsky{t-6})
        tempind=find(Ball>Bcycsky{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)
        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
    
end

hFig3=figure(123460);
cla
hold all
box on
grid on

view(40,10)
set(gca,'XScale','log')

for t=6:6 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
end

for t=[7,8,10,12,13]
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bskyfm{t-6})
        tempind=find(Ball>Bskyfm{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
end

figure(123458);
xlabel('\tau(s)')
ylabel('\mu_0H(mT)')
ylim([5,40])
%set(gca,'ztick',[])
set(gca,'FontSize',8);


figure(123459);
xlabel('\tau(s)')
ylabel('\mu_0H(mT)')
ylim([15,50])
set(gca,'FontSize',8);
%set(gca,'ztick',[])


figure(123460);
ylim([15,60])
xlabel('\tau(s)')
ylabel('\mu_0H(mT)')
set(gca,'FontSize',8);
%set(gca,'ztick',[])
set(gca,'ytick',[20,30,40,50,60])

set(hFig1, 'Color', 'w');
set(hFig1,'Units','centimeters');
set(hFig1, 'Position', [10.0013 2.3019 5.5 8.8]);



savefolder='Plots_publ';
filename=['tau_distr_cycfm'];
%export_fig(hFig1,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig1,fullfile(savefolder,filename),'-eps')

set(hFig2, 'Color', 'w');
set(hFig2,'Units','centimeters');
set(hFig2, 'Position', [16.0867 2.2754 5.5 8.8]);


savefolder='Plots_publ';
filename=['tau_distr_cycsky'];
%export_fig(hFig2,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig2,fullfile(savefolder,filename),'-eps')


set(hFig3, 'Color', 'w');
set(hFig3,'Units','centimeters');
set(hFig3, 'Position', [22.1985 2.2490 5.5 8.8]);

savefolder='Plots_publ';
filename=['tau_distr_skyfm'];
%export_fig(hFig3,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig3,fullfile(savefolder,filename),'-eps')


%%
%{
%Plotting Tau distributions
figure(123459)
subplot(1,2,2)
cla
hold all
box on
grid on
colt=jet(numel(T));
view(40,10)
set(gca,'XScale','log')

tauD=logspace(-10,10,50);
shift=0.5;
for t=1:5 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
          ind(i)=numel(Ball);
        else
          ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(1))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
end


subplot(1,2,1)
cla
hold all
box on
grid on

view(40,10)
set(gca,'XScale','log')
for t=6:6 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(t-6)*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)  
    end
end

shift=1;

for t=[7,8,10,12,13]
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycsky{t-6})
        tempind=find(Ball>Bcycsky{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)
        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
    
    
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bskyfm{t-6})
        tempind=find(Ball>Bskyfm{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
    
end

subplot(1,2,1)
ylim([15,60])

subplot(1,2,2)
ylim([5,40])



savefolder='Plots';
filename=['tau_distr_' num2str(T(t)) 'K'];
%}

%Plot average tau
figure(32523)
cla
hold all
set(gca,'YScale','log')
shift=1e6;

for t=1:6
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    
    if t==6
        tau_cycsky_mean(1)=mean(tau(1:4));
        tau_cycsky_logmean(1)=(mean(log10(tau(1:4))));  
        d_tau_cycsky_logmean(1)=(std(log10(tau(1:4)))); 
        
        tau_skyfm_mean(1)=mean(tau(7:end));
        d_tau_skyfm_mean(1)=std(tau(7:end));
        
        tau_skyfm_logmean(1)=(mean(log10(tau(7:end)))); 
        d_tau_skyfm_logmean(1)=(std(log10(tau(7:end)))); 
       
    else
        tau_cycfm_mean(t)=mean(tau);
        tau_cycfm_logmean(t)=(mean(log10(tau)));
        d_tau_cycfm_logmean(t)=(std(log10(tau)));
        
        plot([B(1) B(end)],[tau_cycfm_mean(t) tau_cycfm_mean(t)]*shift^t,'-','Color',colT(t,:))
        plot([B(1) B(end)],[tau_cycfm_logmean(t) tau_cycfm_logmean(t)]*shift^t,'--','Color',colT(t,:))
    end
    
    plot(B,tau*shift^t,'o-','Color',colT(t,:))
    
    
end
for t=7:13
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycsky{t-6})
        tempind=find(Ball>Bcycsky{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    tau_cycsky_mean(t-5)=mean(tau);
    tau_cycsky_logmean(t-5)=(mean(log10(tau)));
    d_tau_cycsky_logmean(t-5)=(std(log10(tau)));
    
    ind=[];
    for i=1:numel(Bskyfm{t-6})
        tempind=find(Ball>Bskyfm{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end
    
    B=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    tau_skyfm_logmean(t-5)=mean(tau);
    tau_skyfm_logmean(t-5)=(mean(log10(tau)));
    d_tau_skyfm_logmean(t-5)=(std(log10(tau)));
end


figure(342532)
cla
hold on
grid on
%set(gca,'YScale','log')
%ylim([1e-4,1e2])
Yt=[-4,-3,-2,-1,0,1,2];
set(gca,'YTick',Yt)
%plot(T(1:6),tau_cycfm_mean,'ko-')
errorbar(T(1:5),tau_cycfm_logmean,d_tau_cycfm_logmean,'ko-')
%plot(T(7:13),tau_cycsky_mean,'ro-')
errorbar(T(6:13),tau_cycsky_logmean,d_tau_cycsky_logmean,'ro-')
%plot(T(7:13),tau_skyfm,'bo-')
errorbar(T(6:13),tau_skyfm_logmean,d_tau_skyfm_logmean,'bo-')


figure(23456)
cla
hold all
box on
grid on
colT=jet(length(T));
set(gca,'ZScale','lin')
view(100,25)
for t=1:6
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B=Ball(ind);
    alpha=parameters{t}(ind,3);
   
   % plot3(B,T(t)*ones(length(B)),fits_eq_blcorr{t}(:,2),'.-','Color','r')%colT(t,:))
    %plot3(B,T(t)*ones(length(B)),fits_neq_blcorr{t}(:,2),'.-','Color','b')%colT(t,:))
    x=B;
    y=T(t)*ones(1,length(B));
    z=alpha';
    col=z;
    scatter3(x,y,z,10,col)
    %line(B',T(t)*ones(1,length(B))',fits_neq_blcorr{t}(:,2))
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);
    
end

for t=7:13
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycsky{t-6})
        tempind=find(Ball>Bcycsky{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B=Ball(ind);
    alpha=parameters{t}(ind,3);
    
    x=B;
    y=T(t)*ones(1,length(B));
    z=alpha';
    col=z;
    scatter3(x,y,z,10,col)
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);
    
    
    ind=[];
    for i=1:numel(Bskyfm{t-6})
        tempind=find(Ball>Bskyfm{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end
    
    B=Ball(ind);
    alpha=parameters{t}(ind,3);
    
    
    x=B;
    y=T(t)*ones(1,length(B));
    z=alpha';
    col=z;
    scatter3(x,y,z,10,col)
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);

end


%{
%Plotting alpha(H,T)
hFig1=figure(23458);
cla
hold all
box on
grid on
colt=jet(numel(T));
view(40,10)
set(gca,'XScale','lin')


shift=0.4;
for t=1:5 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
          ind(i)=numel(Ball);
        else
          ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    alpha=parameters{t}(ind,3);
    plot3(T(t)*ones(size(B0)),B0/10,alpha,'-','LineWidth',1,'Color',colt(t,:))
    
end


hFig2=figure(23459);
cla
hold all
box on
grid on

view(40,10)
set(gca,'XScale','lin')
for t=6:6 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(t-6)*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)  
    end
end

shift=0.4;

for t=[7,8,10,12,13]
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycsky{t-6})
        tempind=find(Ball>Bcycsky{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)
        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
    
end

hFig3=figure(123460);
cla
hold all
box on
grid on

view(40,10)
set(gca,'XScale','log')

for t=6:6 
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bcycfm{t})
        tempind=find(Ball>Bcycfm{t}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
end

for t=[7,8,10,12,13]
    ind=[];
    %Fitted parameters
    Ball=parameters{t}(:,1);
    for i=1:numel(Bskyfm{t-6})
        tempind=find(Ball>Bskyfm{t-6}(i),1)-1;
        if isempty(tempind)
            ind(i)=numel(Ball);
        else
            ind(i)=tempind;
        end
    end

    p1=parameters{t}(ind,:);

    B0=Ball(ind);
    tau=parameters{t}(ind,2);
    alpha=parameters{t}(ind,3);
    
    for b=1:numel(B0)

        g_CC=calc_taudistr(tauD,tau(b),alpha(b),1);
        %g_HN=calc_taudistr(tauD,tau2(b),alpha2(b),beta2(b));
   
        plot3(tauD,B0(b)/10*ones(length(tauD)),g_CC+(T(t)-T(6))*shift,'-','LineWidth',1,'Color',colt(t,:))
        %plot3(tauD,B0(b)*ones(length(tauD)),g_HN+(T(t)-T(1))*shift,'-','Color','r','LineWidth',1)
    end
end

figure(123458);
xlabel('\tau(s)')
ylabel('\mu_0H(mT)')
ylim([5,40])
%set(gca,'ztick',[])
set(gca,'FontSize',8);


figure(123459);
xlabel('\tau(s)')
ylabel('\mu_0H(mT)')
ylim([15,50])
set(gca,'FontSize',8);
%set(gca,'ztick',[])


figure(123460);
ylim([15,60])
xlabel('\tau(s)')
ylabel('\mu_0H(mT)')
set(gca,'FontSize',8);
%set(gca,'ztick',[])
set(gca,'ytick',[20,30,40,50,60])

set(hFig1, 'Color', 'w');
set(hFig1,'Units','centimeters');
set(hFig1, 'Position', [10.0013 2.3019 5.5 8.8]);



savefolder='Plots_publ';
filename=['tau_distr_cycfm'];
%export_fig(hFig1,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig1,fullfile(savefolder,filename),'-eps')

set(hFig2, 'Color', 'w');
set(hFig2,'Units','centimeters');
set(hFig2, 'Position', [16.0867 2.2754 5.5 8.8]);


savefolder='Plots_publ';
filename=['tau_distr_cycsky'];
%export_fig(hFig2,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig2,fullfile(savefolder,filename),'-eps')


set(hFig3, 'Color', 'w');
set(hFig3,'Units','centimeters');
set(hFig3, 'Position', [22.1985 2.2490 5.5 8.8]);

savefolder='Plots_publ';
filename=['tau_distr_skyfm'];
%export_fig(hFig3,fullfile(savefolder,filename),'-png','-m3')
%export_fig(hFig3,fullfile(savefolder,filename),'-eps')
%}
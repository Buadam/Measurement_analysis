%Unit conversion
m=23.4e-3; %g
M=530.02; %g/mol
mu0=4*pi*1e-7; 
muB=9.27e-24;


%Plotting all fitted curves in the same graph
hFig = figure(100);
cla
shift=2e-4;
hold all
box on

xlabel('\mu_{0}H(mT)','FontSize',10)
ylabel('\chi_{ac}^{,,} (emu/mol)','FontSize',10)
xlim([0 70])
ylim([0 7*shift]/m*M)
for t=1:numel(T)
    for f=1:freq
        if t<6
           plot(all{t}(:,f+freq)/10,all{t}(:,f+3*freq)/m*M+(T(t)-T(1))*shift/m*M,'o-','MarkerSize',2,'Color',cc(f,:));
        else
           plot(all{t}(:,f+freq)/10,all{t}(:,f+3*freq)/m*M+(T(t)-T(1))*shift/m*M,'o-','MarkerSize',2,'Color',cc(f,:));       
        end
    end
end

%legend(meas,'f=0.1Hz','f=1Hz','f=10Hz','f=45Hz','f=110Hz','f=500Hz','f=1000Hz')
set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 8.6 10]);
set(gca,'FontSize',8)


%Plotting all fitted curves in the same graph
hFig=figure(200);
cla


hold all
box on
%title('GaV_4S_8 [111], Out-of-phase signal')
xlabel('\mu_{0}H(mT)','FontSize',10)
ylabel('\chi_{ac}^{,} (emu/mol)','FontSize',10)
shift=10e-4;
xlim([0 70])
ylim([0 14*5e-4]/m*M)
for t=1:numel(T)
B = all{t}(1,8):0.1:all{t}(end,8);
%bl=plot(B/10,Chi_baseline{t}/m*M+(T(t)-T(1))*shift/m*M,'g-.');

    if ~isempty(dmdhc{t})
        dmdhcent=dmdhc{t};
        h_dc=plot(dmdhcent(2:end,1)/10,dmdhcent(2:end,2)/m*M+(T(t)-T(1))*shift/m*M,'o-','MarkerSize',2,'Color',[0.3,0.3,0.3]);
    end


    for f=1:freq
        if t<6
           plot(all{t}(:,f+freq)/10,all{t}(:,f+2*freq)/m*M+(T(t)-T(1))*shift/m*M,'o-','MarkerSize',2,'Color',cc(f,:));          
        else
            plot(all{t}(:,f+freq)/10,all{t}(:,f+2*freq)/m*M+(T(t)-T(1))*shift/m*M,'o-','MarkerSize',2,'Color',cc(f,:));       
         end
    end
end


set(hFig,'Units','centimeters');
set(hFig, 'Position', [5 2 8.6 10]);
set(gca,'FontSize',8)
set(gcf, 'Color', 'w');

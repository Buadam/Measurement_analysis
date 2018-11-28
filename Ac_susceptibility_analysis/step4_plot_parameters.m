Ball=0:20:800;
Tall=T;

blcorr=1;

fits=fits_neq_blcorr;
fits_2=fits_neq_2_blcorr;
paramno=2;
figno=100002;
normalize=0;


%Plot 3D graphs
Bgr=1e-9*ones(length(Ball),length(Tall));
plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,paramno,figno,0);

Bgr=1e0*ones(length(Ball),length(Tall));
plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,paramno,1000022,1);

Bgr=1*ones(length(Ball),length(Tall));
plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,3,100003,1);

Bgr=1e-4*ones(length(Ball),length(Tall));
plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,1,100001,0);

Bgr=1e-4*ones(length(Ball),length(Tall));
plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,4,100004,0);

Bgr=1e-5*ones(length(Ball),length(Tall));
plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,5,100005,0);


%%
%Plot waterfalls
%plot_waterfall(B1,B2,fits,fits_2,paramno,shift,fignum);
%Plot chi(0)
figure(200001)
cla
box on
xlabel('Magnetic field, H(Oe)')
ylabel('\chi(0)-\chi(\infty) (EMU/Oe)')
plot_waterfall(B1,B2,B1_2,B2_2,fits,fits_2,1,2e-3,200001)
hold on
plot_waterfall(B1,B2,B1_2,B2_2,fits,fits_2,4,2e-3,200001)

figure(2000012)
cla
box on
hold all
xlabel('Magnetic field, H(Oe)')
ylabel('\chi^{,}/\chi^{,,}')
shift=2;
col=jet(13);
    for t=1:13
        B=B1(t):20:B2(t);
        plot(B,fits{t}(:,1)./fits{t}(:,4)-1+t*shift,'o-','Color',col(t,:))
        plot([0,700],t*shift*[1,1],'Color',col(t,:))
    end
    for t=12:13
        B=B1_2((t-11)):20:B2_2((t-11));
        plot(B,fits_2{(t-11)}(:,1)./fits_2{(t-11)}(:,4)-1+t*shift,'o-','Color',col(t,:))
        plot([0,700],t*shift*[1,1],'Color',col(t,:))
    end
ylim([0 32])


%Plot tau
figure(200002)
box on
xlabel('Magnetic field, H(Oe)')
ylabel('\tau (s)')
plot_waterfall(B1,B2,B1_2,B2_2,fits,fits_2,2,1e5,200002)

%Plot tau norm
figure(2000022)
hold all
col=jet(13);

shift=10;
box on
xlabel('Magnetic field, H(Oe)')
ylabel('\tau (s)')
set(gca,'YScale','log')
    for t=1:13
        B=B1(t):20:B2(t);
        plot(B,10.^(log10(fits{t}(:,2))/min(log10(fits{t}(:,2))))*shift^t,'o-','Color',col(t,:))
        plot([0,700],shift^t*[1,1],'Color',col(t,:))
    end
    for t=12:13
        B=B1_2((t-11)):20:B2_2((t-11));
        plot(B,10.^(log10(fits_2{t-11}(:,2))/min(log10(fits_2{t-11}(:,2))))*shift^t,'o-','Color',col(t,:))
        plot([0,700],shift^t*[1,1],'Color',col(t,:))
    end

%Plot alpha
figure(200003)
box on
xlabel('Magnetic field, H(Oe)')
ylabel('\chi(0)-\chi(\infty) (EMU/Oe)')
plot_waterfall(B1,B2,B1_2,B2_2,fits,fits_2,3,0.5,200003)



%{
if blcorr==1
    fits=fits_eq_blcorr;
    fits2=fits_eq_2_blcorr;
    fits_neq=fits_neq_blcorr;
    fits2_neq=fits_neq_2_blcorr;
else
    fits=fits_eq;
    fits2=fits_eq_2;
    fits_neq=fits_neq;
    fits2_neq=fits_neq;
end

for t=1:13
    B=B1(t):20:B2(t);
    for b=1:length(B)
        ind=find(Ball==B(b));
        Bgr(ind,t)=fits{t}(b,1);
    end
end

for t=12:13
    B=B1_2(t-11):dB:B2_2(t-11);
    for b=1:length(B)
        ind=find(Ball==B(b));
        Bgr(ind,t)=fits_2{t-11}(b,1);
    end
end

figure(352434)
cla
[X,Y]=meshgrid(Ball,T);
surf(X,Y,Bgr','facecolor', 'interp')
hold on

%Display the dc phase diagram
T1=[5	6	7	8	9	9.5	10	10.5	11	11.5	12	12.5	13];
Bcyc=[-15	140	190	260	330	340	330	310	300	280	240	190	100];
T2=[9	9.5	10	10.5	11	11.5	12	12.5	13];
Bsky=[330	420	460	520	570	620	660	580	500];

plot(Bcyc,T1,'ko-')
plot(Bsky,T2,'ro-')


figure(2332131)
col=jet(13);
shift=1e5;
cla
hold all
set(gca,'YScale','log')
for t=1:13
    B=B1(t):20:B2(t);
    plot(B,fits_neq_blcorr{t}(:,2)*shift^t,'o-','Color',col(t,:))
    plot([0,700],shift^t*[1,1],'Color',col(t,:))
end


figure(412124)
cla
hold all
set(gca,'YScale','log')
for t=1:13
    B=B1(t):20:B2(t);
    [~,ind]=max(fits{t}(:,1));
    Bm(t)=B(ind);
    maxtau(t)=fits{t}(ind,2);
end

    
    plot3(Bm,T,maxtau,'ko-')
    set(gca,'YScale','lin')
    set(gca,'ZScale','log')
    
    
figure(2131)
col=jet(13);
shift=5e-3;
cla
hold all
set(gca,'YScale','lin')
for t=1:13
    B=B1(t):20:B2(t);
    plot(B,fits{t}(:,1)+shift*(T(t)-T(1)),'o-','Color',col(t,:),'MarkerSize',3)
    plot([0,700],[0,0]+shift*(T(t)-T(1)),'Color',col(t,:))
end
box on
xlabel('Magnetic field, H(Oe)')
ylabel('Fitted \chi(0)-\chi(\infty)')

figure(2132)
col=jet(13);
shift=5e-3;
cla
hold all
set(gca,'YScale','lin')
for t=1:13
    B=B1(t):20:B2(t);
    plot(B,fits_neq{t}(:,1)+shift*(T(t)-T(1)),'o-','Color',col(t,:),'MarkerSize',3)
    plot(B,fits_neq{t}(:,4)+shift*(T(t)-T(1)),'o--','Color',col(t,:),'MarkerSize',3)
    plot([0,700],[0,0]+shift*(T(t)-T(1)),'Color',col(t,:))
end
box on
xlabel('Magnetic field, H(Oe)')
ylabel('Fitted \chi(0)-\chi(\infty)')

figure(2133)
col=jet(13);
shift=5e-4;
cla
hold all
set(gca,'YScale','lin')
for t=1:13
    B=B1(t):20:B2(t);
    plot(B,fits_neq{t}(:,5)+shift*(T(t)-T(1)),'o--','Color',col(t,:),'MarkerSize',3)
    plot(B,fits{t}(:,5)+shift*(T(t)-T(1)),'o-','Color',col(t,:),'MarkerSize',3)
    plot([0,700],[0,0]+shift*(T(t)-T(1)),'Color',col(t,:))
end
box on
xlabel('Magnetic field, H(Oe)')
ylabel('Fitted \chi(\infty)')

%}
function plot_param(Bgr,fits,fits_2,B1,B2,B1_2,B2_2,paramno,figno,normalize)

dB=20;
%Data for the dc phase diagram
T1=[5	6	7	8	9	9.5	10	10.5	11	11.5	12	12.5	13];
Bcyc=[-15	140	190	260	330	340	330	310	300	280	240	190	100];
T2=[9	9.5	10	10.5	11	11.5	12	12.5	13];
Bsky=[330	420	460	520	570	620	660	580	500];

T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
Ball=0:20:800;

for t=1:13
    B=B1(t):20:B2(t);
    for b=1:length(B)
        ind=find(Ball==B(b));
        if normalize
            Bgr(ind,t)=fits{t}(b,paramno)/min(fits{t}(:,paramno));
        else
            Bgr(ind,t)=fits{t}(b,paramno);
        end
    end
end

for t=12:13
    B=B1_2(t-11):dB:B2_2(t-11);
    for b=1:length(B)
        ind=find(Ball==B(b));
        if normalize==1
            Bgr(ind,t)=fits_2{t-11}(b,paramno)/min(fits_2{t-11}(:,paramno));
        else
            Bgr(ind,t)=fits_2{t-11}(b,paramno);
        end  
    end
end

figure(figno)
cla
hold all

[X,Y]=meshgrid(T,Ball);
if paramno==2
    surf(X,Y,Bgr,log10(Bgr),'facecolor', 'interp')
else
    surf(X,Y,Bgr,'facecolor', 'interp')  
end
%[xx,yy] = meshgrid(T(1):0.5:T(end),Ball(1):20:Ball(end));  
%surf(xx,yy,interp2(X,Y,Bgr,xx,yy))

plot(T1,Bcyc,'ko-')
plot(T2,Bsky,'ro-')

if paramno==2
    set(gca,'ZScale','log')
else
    set(gca,'ZScale','lin')
end
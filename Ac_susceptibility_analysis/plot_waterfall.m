function plot_waterfall(B1,B2,B1_2,B2_2,fits,fits_2,paramno,shift,fignum)

figure(fignum)
col=jet(13);

%cla
hold all

if paramno==2
    set(gca,'YScale','log')
    for t=1:13
        B=B1(t):20:B2(t);
        plot(B,fits{t}(:,paramno)*shift^t,'o-','Color',col(t,:))
        plot([0,700],shift^t*[1,1],'Color',col(t,:))
    end
    for t=12:13
        B=B1_2((t-11)):20:B2_2((t-11));
        plot(B,fits_2{(t-11)}(:,paramno)*shift^t,'o-','Color',col(t,:))
        plot([0,700],shift^t*[1,1],'Color',col(t,:))
    end
else
    set(gca,'YScale','lin')
    for t=1:13
        B=B1(t):20:B2(t);
        plot(B,fits{t}(:,paramno)+t*shift,'o-','Color',col(t,:))
        plot([0,700],t*shift*[1,1],'Color',col(t,:))
    end
    for t=12:13
        B=B1_2((t-11)):20:B2_2((t-11));
        plot(B,fits_2{(t-11)}(:,paramno)+t*shift,'o-','Color',col(t,:))
        plot([0,700],t*shift*[1,1],'Color',col(t,:))
    end
end
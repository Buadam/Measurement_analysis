figure(123456)
cla
hold all
box on
grid on
colT=jet(length(T));
set(gca,'ZScale','log')
view(100,25)


for t=1:13
    B=B1(t):dB:B2(t);
   % plot3(B,T(t)*ones(length(B)),fits_eq_blcorr{t}(:,2),'.-','Color','r')%colT(t,:))
    %plot3(B,T(t)*ones(length(B)),fits_neq_blcorr{t}(:,2),'.-','Color','b')%colT(t,:))
    x=B;
    y=T(t)*ones(1,length(B));
    z=fits_neq_blcorr{t}(:,2)';
    col=log10(z);
    scatter3(x,y,z,10,col)
    %line(B',T(t)*ones(1,length(B))',fits_neq_blcorr{t}(:,2))
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);
    
end

for t=12:13
    B=B1_2(t-11):dB:B2_2(t-11);
    x=B;
    y=T(t)*ones(1,length(B));
    z=fits_neq_2_blcorr{t-11}(:,2)';
    col=log10(z);
    scatter3(x,y,z,10,col)
    
    surface([x;x],[y;y],[z;z],[col;col],...
        'facecol','no',...
        'edgecol','interp',...
        'linew',1);

end
load('Cartesian_mesh.mat','Xc','Yc','Zc');
load('GMS_volumetric_cart_1deg_sm_2.mat','I_cart_cartint');

%{
figure(21)
slice(Xc,Yc,Zc,I_cart_cartint,[0],[0],[0])
colormap(jet)
caxis([0,10])
shading flat
%}

%{
figure(22)
p = patch(isosurface(Xc,Yc,Zc,I_cart,10));
isonormals(Xc,Yc,Zc,I_cart,p)
p.FaceColor = 'red';
p.EdgeColor = 'none';
daspect([1 1 1])
view(3); 
axis tight
camlight 
lighting gouraud
%}

figure(23)
thr_low=4.2;
thr_high=6;

ind=find(I_cart_cartint<thr_high & I_cart_cartint>thr_low);
[K,L,M]=ind2sub([151,151,151],ind);
vx=Xc(K,1,1); %ndgrid: 1st index K, meshgrid: 2nd index K
vy=Yc(1,L,1); %ndgrid: 2nd index L, meshgrid: 1st index L
vz=Zc(1,1,M);

subplot(1,3,1)
cla
scatter3(vx,vy,vz,1,I_cart_cartint(ind))
daspect([0.75 0.75 1])
phi=54.7*pi/180;
view([cos(phi)+sin(phi),sin(phi)-cos(phi),0])

subplot(1,3,2)
cla
scatter3(vx,vy,vz,1,I_cart_cartint(ind))
daspect([0.75 0.75 1])
view([1,1,0])  


subplot(1,3,3)
cla
scatter3(vx,vy,vz,1,I_cart_cartint(ind))
daspect([0.75 0.75 1])
view([1,-1,0])

size=75;
[v1t,v2t,v3t,v4t]=Hexagons(size,0);

figure(24)
ax1=subplot(1,2,1);
cla
scatter3(vx,vy,vz,2,I_cart_cartint(ind))
view([1,1,1])

hold on
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r','LineWidth',1.5)
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b','LineWidth',1.5)
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g','LineWidth',1.5)
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y','LineWidth',1.5)
axis square

ax2=subplot(1,2,2);
cla
hold all
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')

%}
text(0,0,size,'(1,-1,0)')
text(size,0,0,'(1,1,-2)')
text(0,size,0,'(1,1,1)')
box on
view([1,1,1])
axis square
hlink = linkprop([ax1,ax2],{'CameraPosition','CameraUpVector'}); 
rotate3d on

%{
%%
%Perform symmetry operations
%Coordinate system ([11-2],[111],[1-10])
z2=[1;-1;0]/sqrt(2);
x2=[1;1;-2]/sqrt(6);
y2=[1;1;1]/sqrt(3);
T=[x2,y2,z2];

disp('Listing all Td symmetries in the ([11-2],[111],[1-10]) basis')
%C2 around <100>
disp('C2 symmetry axes')
v_100=T\[1;0;0]
v_010=T\[0;1;0]
v_001=T\[0;0;1] 

%C3 around <111>
disp('C3 symmetry axes') %C3 and C3^2 for each
v_111=T\[1;1;1]/sqrt(3)
v_1m1m1=T\[1;-1;-1]/sqrt(3)
v_m1m11=T\[-1;-1;1]/sqrt(3)
v_m11m1=T\[-1;1;-1]/sqrt(3)

%S4 around <100>: S4 and -S4
disp('S4 symmetry axes=C2 symmetry axes')

%Mirror planes
disp('Mirror planes')
m_110=T\[1;1;0]/sqrt(2)
m_1m10=T\[1;-1;0]/sqrt(2)
m_011=T\[0;1;1]/sqrt(2)
m_01m1=T\[0;1;-1]/sqrt(2)
m_101=T\[1;0;1]/sqrt(2)
m_10m1=T\[1;0;-1]/sqrt(2)

%Perform transformations
%C2
[Xt,Yt,Zt,I_C2_100]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,180,v_100); %C2 rotation around [100]
saveas(gca,'C2_100.fig')
save('C2_100.mat','I_C2_100')

[Xt,Yt,Zt,I_C2_010]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,180,v_010); %C2 rotation around [010]
saveas(gca,'C2_010.fig')
save('C2_010.mat','I_C2_010')

[Xt,Yt,Zt,I_C2_001]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,180,v_001); %C2 rotation around [001]
saveas(gca,'C2_001.fig')
save('C2_001.mat','I_C2_001')

%C3
[Xt,Yt,Zt,I_C3_111]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,120,v_111); %C3 rotation around [111]
saveas(gca,'C3_111.fig')
save('C3_111.mat','I_C3_111')
[Xt,Yt,Zt,I_2C3_111]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,240,v_111); %2C3 rotation around [111]
saveas(gca,'2C3_111.fig')
save('C32_111.mat','I_2C3_111')

[Xt,Yt,Zt,I_C3_1m1m1]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,120,v_1m1m1); %C3 rotation around [-1-11]
saveas(gca,'C3_1m1m1.fig')
save('C3_1m1m1.mat','I_C3_1m1m1')
[Xt,Yt,Zt,I_2C3_1m1m1]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,240,v_1m1m1); %C3 rotation around [-1-11]
saveas(gca,'2C3_1m1m1.fig')
save('C32_1m1m1.mat','I_2C3_1m1m1')


[Xt,Yt,Zt,I_C3_m1m11]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,120,v_m1m11); %C3 rotation around [1-1-1]
saveas(gca,'C3_m1m11.fig')
save('C3_m1m11.mat','I_C3_m1m11')
[Xt,Yt,Zt,I_2C3_m1m11]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,240,v_m1m11); %C3 rotation around [1-1-1]
saveas(gca,'2C3_m1m11.fig')
save('C32_m1m11.mat','I_2C3_m1m11')

[Xt,Yt,Zt,I_C3_m11m1]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,120,v_m11m1); %C3 rotation around [-11-1]
saveas(gca,'C3_m11m1.fig')
save('C3_m11m1.mat','I_C3_m11m1')
[Xt,Yt,Zt,I_2C3_m11m1]=Symmetry_rotate(Xc,Yc,Zc,I_cart_cartint,240,v_m11m1); %C3 rotation around [-11-1]
saveas(gca,'2C3_m11m1.fig')
save('C32_m11m1.mat','I_2C3_m11m1')

%S4
[Xt,Yt,Zt,I_S4_100]=Symmetry_impropRotate(Xc,Yc,Zc,I_cart_cartint,90,v_100); %S4 rotation around [100]
saveas(gca,'S4_100.fig')
save('S4_100.mat','I_S4_100')
[Xt,Yt,Zt,I_3S4_100]=Symmetry_impropRotate(Xc,Yc,Zc,I_cart_cartint,270,v_100); %S4 rotation around [100]
saveas(gca,'3S4_100.fig')
save('S43_100.mat','I_3S4_100')


[Xt,Yt,Zt,I_S4_010]=Symmetry_impropRotate(Xc,Yc,Zc,I_cart_cartint,90,v_010); %S4 rotation around [010]
saveas(gca,'S4_010.fig')
save('S4_010.mat','I_S4_010')
[Xt,Yt,Zt,I_3S4_010]=Symmetry_impropRotate(Xc,Yc,Zc,I_cart_cartint,270,v_010); %S4 rotation around [010]
saveas(gca,'3S4_010.fig')
save('S43_010.mat','I_3S4_010')

[Xt,Yt,Zt,I_S4_001]=Symmetry_impropRotate(Xc,Yc,Zc,I_cart_cartint,90,v_001); %S4 rotation around [001]
saveas(gca,'S4_001.fig')
save('S4_001.mat','I_S4_001')
[Xt,Yt,Zt,I_3S4_001]=Symmetry_impropRotate(Xc,Yc,Zc,I_cart_cartint,270,v_001); %S4 rotation around [001]
saveas(gca,'3S4_001.fig')
save('S43_001.mat','I_3S4_001')


%Mirror
[Xt,Yt,Zt,I_m_110]=Symmetry_mirror(Xc,Yc,Zc,I_cart_cartint,m_110); %Mirror to [110]
saveas(gca,'m_110.fig')
save('m_110.mat','I_m_110')
[Xt,Yt,Zt,I_m_1m10]=Symmetry_mirror(Xc,Yc,Zc,I_cart_cartint,m_1m10); %Mirror to [1-10]
saveas(gca,'m_1m10.fig')
save('m_1m10.mat','I_m_1m10')

[Xt,Yt,Zt,I_m_011]=Symmetry_mirror(Xc,Yc,Zc,I_cart_cartint,m_011); %Mirror to [110]
saveas(gca,'m_011.fig')
save('m_011.mat','I_m_011')

[Xt,Yt,Zt,I_m_01m1]=Symmetry_mirror(Xc,Yc,Zc,I_cart_cartint,m_01m1); %Mirror to [1-10]
saveas(gca,'m_01m1.fig')
save('m_01m1.mat','I_m_01m1')

[Xt,Yt,Zt,I_m_101]=Symmetry_mirror(Xc,Yc,Zc,I_cart_cartint,m_101); %Mirror to [110]
saveas(gca,'m_101.fig')
save('m_101.mat','I_m_101')
[Xt,Yt,Zt,I_m_10m1]=Symmetry_mirror(Xc,Yc,Zc,I_cart_cartint,m_10m1); %Mirror to [1-10]
saveas(gca,'m_01m1.fig')
save('m_10m1.mat','I_m_10m1')

I_av=(I_cart_cartint+...
    I_C2_100+I_C2_010+I_C2_001+...
    I_C3_111+I_2C3_111+I_C3_1m1m1+I_2C3_1m1m1+I_C3_m1m11+I_2C3_m1m11+I_C3_m11m1+I_2C3_m11m1+...
    I_S4_100+I_3S4_100+I_S4_010+I_3S4_010+I_S4_001+I_3S4_001+...
    I_m_110+I_m_1m10+I_m_101+I_m_10m1+I_m_011+I_m_01m1)/24;
%}

thr_low=4.2;
thr_high=6;

ind=find(I_av<thr_high & I_av>thr_low);
[K,L,M]=ind2sub([151,151,151],ind);
vx=Xc(K,1,1); %ndgrid: 1st index K, meshgrid: 2nd index K
vy=Yc(1,L,1); %ndgrid: 2nd index L, meshgrid: 1st index L
vz=Zc(1,1,M);

figure(28)
ax1=subplot(1,2,1);
cla
scatter3(vx,vy,vz,2,I_av(ind))
view([1,1,1])

hold on
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r','LineWidth',1.5)
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b','LineWidth',1.5)
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g','LineWidth',1.5)
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y','LineWidth',1.5)
axis square

ax2=subplot(1,2,2);
cla
hold all
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')

%}
text(0,0,size,'(1,-1,0)')
text(size,0,0,'(1,1,-2)')
text(0,size,0,'(1,1,1)')
box on
view([1,1,1])
axis square
hlink = linkprop([ax1,ax2],{'CameraPosition','CameraUpVector'}); 
rotate3d on


figure(29)
subplot(1,3,1)
cla
scatter3(vx,vy,vz,2,I_av(ind))
hold all
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')
view(T\[1;1;1])
title('[111] view')
axis square

subplot(1,3,2)
cla
scatter3(vx,vy,vz,2,I_av(ind))
hold all
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')
view(T\[0;0;1])
axis square
title('[001] view')

subplot(1,3,3)
cla
scatter3(vx,vy,vz,2,I_av(ind))
hold all
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')
view(T\[1;1;0])
axis square
title('[110] view')

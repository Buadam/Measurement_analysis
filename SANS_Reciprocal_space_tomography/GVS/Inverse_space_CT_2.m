load('Cartesian_mesh.mat','Xc','Yc','Zc');
load('GVS_volumetric_cart_sm.mat','I_cart_cartint');


figure(21)
slice(Xc,Yc,Zc,I_cart_cartint,[0],[0],[0])
colormap(jet)
caxis([0,10])
shading flat

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
thr_low=2.5;
thr_high=10;

ind=find(I_cart_cartint<thr_high & I_cart_cartint>thr_low);
[K,L,M]=ind2sub([81,81,128],ind);
vx=Xc(1,K,1);
vy=Yc(L,1,1);
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
hsp2 = get(gca, 'Position');    
%set(gca, 'Position', [hsp2(1:2) 3.5/5*hsp2(3) hsp2(4)])


figure(24)
cla
scatter3(vx,vy,vz,2,I_cart_cartint(ind))
daspect([0.75 0.75 1])
view([1,1,1])



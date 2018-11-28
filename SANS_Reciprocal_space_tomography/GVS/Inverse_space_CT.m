load('Cartesian_mesh.mat','Xc','Yc','Zc')
load('GVS_volumetric.mat','I_cart')

figure(21)
slice(Xc,Yc,Zc,I_cart,[0],[0],[0])
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
thr_low=7;
thr_high=20;

ind=find(I_cart<thr_high & I_cart>thr_low);
[K,L,M]=ind2sub([81,81,128],ind);
vx=Xc(1,K,1);
vy=Yc(L,1,1);
vz=Zc(1,1,M);
scatter3(vx,vy,vz,1,I_cart(ind))
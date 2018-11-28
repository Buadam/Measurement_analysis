me=load('Cylinder_mesh_dense_cart.mat','X_cyl_dense','Y_cyl_dense','Z_cyl_dense');
Int=load('GVS_volumetric_cyl_sm.mat','I_cyl_cylint');

Xc=me.X_cyl_dense;
Yc=me.Y_cyl_dense;
Zc=me.Z_cyl_dense;
I=Int.I_cyl_cylint;

Xc=permute(Xc,[2,1,3]);
Yc=permute(Yc,[2,1,3]);
Zc=permute(Zc,[2,1,3]);

I=permute(I,[2,1,3]);


%Coordinate system
rmin=0.5;
rmax=92.5;
zmin=-127.5;
zmax=127.5;

Rmax=30; %forward scattered intensity
sigma=1;

%I=SANS_image_postconditioning(I,sigma,rmin,rmax,zmin,zmax,Rmax);


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

figure(33)
thr_low=3;
thr_high=7;

ind=find(I<thr_high & I>thr_low);
[K,L,M]=ind2sub([361,61,128],ind);

vx=[];
vy=[];
vz=[];
for i=1:size(K,1)
    vx(i)=Xc(K(i),L(i),M(i));
    vy(i)=Yc(K(i),L(i),M(i));
    vz(i)=Zc(K(i),L(i),M(i));
end

subplot(1,3,1)
cla
scatter3(vx,vy,vz,1,I(ind))
daspect([0.75 0.75 1])
phi=54.7*pi/180;
view([cos(phi)+sin(phi),sin(phi)-cos(phi),0])

subplot(1,3,2)
cla
scatter3(vx,vy,vz,1,I(ind))
daspect([0.75 0.75 1])
view([1,1,0])  


subplot(1,3,3)
cla
scatter3(vx,vy,vz,1,I(ind))
daspect([0.75 0.75 1])
view([1,-1,0])
hsp2 = get(gca, 'Position');    

figure(34)
cla
scatter3(vx,vy,vz,2,I(ind))
daspect([0.75 0.75 1])
view([1,1,1])

hold on
%v1=[1,0,0];
%v2=[0,1,0];
%v3=[0,0,1];
n=[1,1,1];

xp=-70:1:70;
yp=-70:1:70;
[Xpl,Ypl]=meshgrid(xp,yp);
H=0;
Zpl=(H-n(1)*Xpl-n(2)*Ypl)/n(3);
%surf(Xpl,Ypl,Zpl);
caxis([thr_low,thr_high])

%Ipl=griddata(Xc,Yc,Zc,I,Xpl,Ypl,Zpl);

Xq=reshape(Xpl,1,[]);
Yq=reshape(Ypl,1,[]);
Zq=reshape(Zpl,1,[]);
%Ipl=interp3(Xc,Yc,Zc,I,Xq,Yq,Zq);
%Ipl=reshape(Ipl,size(Zpl));

figure(35)
%urf(Xpl,Ypl,Ipl)
view(2)

%{
hslice = surf(linspace(-rmax,rmax,100),...
   linspace(zmin,zmax,100),...
   zeros(100));

rotate(hslice,[-1,0,0],-45)

caxis([thr_low,thr_high])
xd = get(hslice,'XData');
yd = get(hslice,'YData');
zd = get(hslice,'ZData');
%}
load('Cartesian_mesh.mat','Xc','Yc','Zc');
Int=load('GMS_volumetric_cyl_sm.mat','I_cart_cylint');

I_sm=Int.I_cart_cylint;



%Coordinate system
rmin=0.5;
rmax=92.5;
zmin=-127.5;
zmax=127.5;

Rmax=30; %forward scattered intensity
sigma=1;

%I_sm=SANS_image_postconditioning(I,sigma,rmin,rmax,zmin,zmax,Rmax);


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
thr_high=12;

ind=find(I_sm<thr_high & I_sm>thr_low);
[K,L,M]=ind2sub([151,151,256],ind);

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
scatter3(vx,vy,vz,1,I_sm(ind))
daspect([0.75 0.75 1])
view([2/sqrt(6),1/sqrt(3),0])

subplot(1,3,2)
cla
scatter3(vx,vy,vz,1,I_sm(ind))
daspect([0.75 0.75 1])
view([1,1,0])  


subplot(1,3,3)
cla
scatter3(vx,vy,vz,1,I_sm(ind))
daspect([0.75 0.75 1])
view([1,-1,0])
hsp2 = get(gca, 'Position');    
set(gca, 'Position', [hsp2(1:2) hsp2(3) hsp2(4)])

figure(34)
cla
scatter3(vx,vy,vz,2,I_sm(ind))
daspect([0.75 0.75 1])
view([1,1,1])

hold on
%v1=[1,0,0];
%v2=[0,1,0];
%v3=[0,0,1];
n=[2/sqrt(6),1/sqrt(3),0];

xp-rmax:1:rmax;
yp=-rmax:1:rmax;
zp=zmin:1:zmax;
H=0;
if n(3)~=0
    [Xpl,Ypl]=meshgrid(xp,yp);
    Zpl=(H-n(1)*Xpl-n(2)*Ypl)/n(3);
else
    if n(1)~=0
        [Ypl,Zpl]=meshgrid(xp,yp);
        Xpl=(H-n(2)*Ypl)/n(1);
    else
        [Xpl,Zpl]=meshgrid(xp,yp);
        Ypl=(H-n(1)*Xpl)/n(2);
    end
end
surf(Xpl,Ypl,Zpl);
caxis([thr_low,thr_high])

%Ipl=griddata(Xc,Yc,Zc,I_sm,Xpl,Ypl,Zpl);

Xq=reshape(Xpl,1,[]);
Yq=reshape(Ypl,1,[]);
Zq=reshape(Zpl,1,[]);
Ipl=interp3(Xc,Yc,Zc,I_sm,Xq,Yq,Zq);
Ipl=reshape(Ipl,size(Zpl));

figure(35)
[xpl2,ypl2]=meshgrid(xp,yp);
surf(xpl2,ypl2,Ipl)
%{
if n(3)~=0
    surf(Xpl,Ypl,Ipl)
else
    if n(1)~=0
        surf(Ypl,Zpl,Ipl)
    else
        surf(Xpl,Zpl,Ipl)
    end
end
%}
caxis([thr_low,thr_high])
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
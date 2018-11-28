%Obtaining matrix images from grasp depths

n=20; %number of depth layers
%Im=zeros(256,192,n);
    

Im=grasp_data(1).data1{1,1}(:,:,:);
BGR=grasp_data(3).data1{1,1}(:,:,:); %grasp_data(2): empty cell, grasp_data(3): blocked beam
I_0=Im-BGR;


figure(12)
cla
x=-95.5:1:95.5;
z=-127.5:1:127.5;
[X,Z]=meshgrid(x,z);
pcolor(X,Z,I_0(:,:,1)); shading flat;
caxis([0,70])
axis square

%Intensity map in cylindrical mesh
%Separate the two halves of the inensity map in each angular slice
I_right=I_0(:,97:192,:);
figure(13)
cla
xr=0.5:1:95.5;
zr=-127.5:1:127.5;
[Xr,Zr]=meshgrid(xr,zr);
pcolor(Xr,Zr,I_right(:,:,1)); shading flat;
caxis([0,70])

I_left=I_0(:,96:-1:1,:);
figure(14)
cla
xl=0.5:1:95.5;
zl=-127.5:1:127.5;
[Xl,Zl]=meshgrid(xl,zl);
pcolor(Xl,Zl,I_left(:,:,1)); shading flat;
caxis([0,70])

%Assign the intensity data to the cylindrical grid
I_cyl=cat(3,I_right(:,:,1:18),I_left(:,:,1:19));
I_cyl=permute(I_cyl,[3,2,1]);

%Creating cylindrical grid for original data
%phi1=0:10:180; 
%phi2=-170:10:0;
%phi_deg=[phi1,phi2]; 
phi_deg=-180:10:180; phi_rad=phi_deg*pi/180;
r=0.5:1:95.5;
z=-127.5:1:127.5;
[phimesh,rmesh,zmesh]=meshgrid(phi_rad,r,z);
phimesh=permute(phimesh,[2,1,3]);
rmesh=permute(rmesh,[2,1,3]);
zmesh=permute(zmesh,[2,1,3]);

figure(15)
ind=19;
cla
X=squeeze(rmesh(ind,:,:));
Y=squeeze(zmesh(ind,:,:));
I=squeeze(I_cyl(ind,:,:));
pcolor(X,Y,I);
%hold on
%contour(X,Y,I,[1,2,3,4,5,6],'Color','r');
shading flat;
caxis([0,70])



%defining Cartesian grid inside the cylinder
xcart=-67:1:67;
ycart=-67:1:67;
zcart=-127.5:1:127.5;
[Xc,Yc,Zc]=meshgrid(xcart,ycart,zcart);
[Phi_c,R_c,Z_c]=cart2pol(Xc,Yc,Zc);

%interpolate data on the Cartesian grid expressed in polar coordinates
I_cart=griddata(phimesh,rmesh,zmesh,I_cyl,Phi_c,R_c,Z_c);

figure(16)
slice(Xc,Yc,Zc,I_cart,[0],[0],[0])
colormap(jet)
caxis([0,70])
shading flat

%[xmesh,ymesh,zmesh]=pol2cart(phimesh,rmesh,zmesh);
%}
%{
%defining grid inside the cylinder
xcart=-67:1:67;
ycart=-67:1:67;
zcart=-127.5:1:127.5;
[Xc,Yc,Zc]=meshgrid(xcart,ycart,zcart);

%%




%I_cyl_resh=reshape(I_cyl,[],37);



[phi_c,r_c,z_c]=cart2pol(Xc,Yc,Zc);
%I_cart=griddata(phimesh,rmesh,zmesh,I_cyl,phi_c,r_c,z_c);

figure(2132)
slice(Xc,Yc,Zc,I_cart,[0,50,100],[0],[0])
colormap(jet)
caxis([0,70])
shading flat

%Data sampling on the Cartesian grid
%I_cart3=zeros(135,135,256);
%for i=1:256
%    I_cart3(:,:,i)=interp2(xmesh(:,:,i),ymesh(:,:,i),I_cyl(:,:,i),Xc(:,:,i),Yc(:,:,i));
%end
%I_cart=interp3(xmesh,ymesh,zmesh,I_cyl,Xc,Yc,Zc);

%I_cart=griddata(xmesh,ymesh,zmesh,I_cyl,Xc,Yc,Zc);
%}
%{
for i=1:length(xcart)
    for j=length(ycart)
        xi=xcart(i);
        yj=ycart(j);
        r=sqrt(xi^2+yj^2);
        phi_ij=atan(yj/xi);
        I_cart(i,j,:)=interp1(I_cyl(:,r,z)
    end
end
%}
%%

%Obtain data for continuous alpha
%alpha_0=0:10:180;
%d_alpha=0.5; %resolution of the interpolated data
%alpha_cont=0:d_alpha:180;

%Intensity data
%IR=reshape(I_0(:,:,1:18),[],18); %reshape Intensity matrix to a vector for sampling
%I_contR=interp1(alpha_0,IR',alpha_cont); %Interpolate at a higher resolution in alpha
%I_cont=reshape(I_contR',256,192,[]); %I_cont=(x,y,alpha_cont): in cylindrical coordinates r=x,y,alpha_cont

%transformation to Cartesian coordinates: R=(x,y,z)=

%[R,Z,Phi]=meshgrid(1:256,1:192,1:361);
%{
figure(31231)
cla
z=1:256;
r=1:192;
phi=0:10:190;

[rmesh,phimesh,zmesh]=meshgrid(r,phi,z);
[xmesh,ymesh,zmesh]=pol2cart(phimesh,rmesh,zmesh);
[xg, yg, zg] = meshgrid(1:192,1:192,1:256);
%gdata = griddata(xmesh,ymesh,zmesh,I_0,xg,yg,zg);

slice(xg,yg,zg,gdata,[0,50,100,150,192],[],[])
shading flat
caxis([0,70])
colormap(jet)
%}
%{
X = R.*cos(Phi);
Y = R.*sin(Phi);


rslice=[];
zslice=[];
Phislice=[0,5,10,15,20];
slice(I_0,rslice,zslice,Phislice)
%}
%thr=-500;
%[Sl1,Sl2,Sl3]=ind2sub(size(I_0),find(I_0<thr));
%scatter3(Sl1,Sl2,Sl3)
%{
subplot(3,1,2)
image(BGR(:,:,1))
axis square

subplot(3,1,3)
image(Im(:,:,1)-BGR(:,:,1))
axis square
%}
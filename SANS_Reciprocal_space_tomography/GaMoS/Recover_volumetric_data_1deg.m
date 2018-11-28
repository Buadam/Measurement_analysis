%Obtaining matrix images from grasp depths

Im=grasp_data(1).data1{1,1}(:,:,1:181);
BGR=grasp_data(2).data1{1,1}(:,:,1:181); %grasp_data(2): empty cell, grasp_data(3): blocked beam
I_0=Im-BGR;
save('I0_orig_1deg.mat','I_0')

%Center positions
c_x=93;
c_y=122;
pix_x=192;
pix_y=256;
ratio=pix_x/pix_y;
Rmax=40; %forward scattered intensity
sigma=2;

I_0=SANS_image_conditioning(I_0,c_x,c_y,pix_x,pix_y,Rmax,sigma);

x=0.5-c_x:1:pix_x-c_x-0.5;
z=ratio*(0.5-c_y:1:pix_y-c_y-0.5); %rescale z axis due to detector resolution (ORNL: 256x192)
[X,Z]=meshgrid(x,z);
%[X,Z]=ndgrid(x,z);

figure(12)
cla
pcolor(X,Z,I_0(:,:,4)); shading flat;
caxis([0,70])
axis square

%Intensity map in cylindrical mesh
%Separate the two halves of the inensity map in each angular slice
I_right=I_0(:,c_x+1:end,:);

xr=0.5:1:98.5;
zr=ratio*(0.5-c_y:1:pix_y-c_y-0.5); %rescale z axis due to detector resolution (ORNL: 256x192)
[Xr,Zr]=meshgrid(xr,zr);
%[Xr,Zr]=ndgrid(xr,zr);

I_left=I_0(:,c_x:-1:1,:);
xl=0.5:1:92.5;
zl=ratio*(0.5-c_y:1:pix_y-c_y-0.5); %rescale z axis due to detector resolution (ORNL: 256x192)
[Xl,Zl]=meshgrid(xl,zl);
%[Xl,Zl]=ndgrid(xl,zl);

%%
%GRIDS
%Creating cylindrical grid for original data
phi_deg=-162:1:198; phi_rad=phi_deg*pi/180;
r=0.5:1:92.5;
z=ratio*(0.5-c_y:1:pix_y-c_y-0.5);
[phimesh,rmesh,zmesh]=ndgrid(phi_rad,r,z);
%phimesh=permute(phimesh,[2,1,3]);
%rmesh=permute(rmesh,[2,1,3]);
%zmesh=permute(zmesh,[2,1,3]);

%Assign the intensity data to the cylindrical grid
I_cyl=cat(3,I_right(:,1:93,1:180),I_left(:,:,1:181));
I_cyl=permute(I_cyl,[3,2,1]);
figure(15)
ind=35;
cla
X=squeeze(rmesh(ind,:,:));
Y=squeeze(zmesh(ind,:,:));
I=squeeze(I_cyl(ind,:,:));
pcolor(X,Y,I);

%Original cylindrical grid in Cartesian coordinates
[X_cyl,Y_cyl,Z_cyl]=pol2cart(phimesh,rmesh,zmesh);
save('Cylinder_mesh_1deg_cart.mat','X_cyl','Y_cyl','Z_cyl')

%Cartesian grid inside the cylinder
xcart=-75:1:75;
ycart=-75:1:75;
zcart=-75:1:75;
%zcart=0.5-c_y:1:pix_y-c_y-0.5;
[Xc,Yc,Zc]=ndgrid(xcart,ycart,zcart);
save('Cartesian_mesh.mat','Xc','Yc','Zc')


%%
%DATA
%Save original volumetric data on Cyl grid
save('GMS_volumetric_polar_1deg_sm_2.mat','I_cyl')


%interpolate data on the Cartesian grid expressed in Cartesian coordinates
I_cart_cartint=griddata(X_cyl,Y_cyl,Z_cyl,I_cyl,Xc,Yc,Zc); %interpolation according to Cartesian metric
save('GMS_volumetric_cart_1deg_sm_2.mat','I_cart_cartint')

%interpolate data on the Cartesian grid expressed in Cylindrical coordinates
[Phi_c,R_c,Z_c]=cart2pol(Xc,Yc,Zc);
I_cart_cylint=griddata(phimesh,rmesh,zmesh,I_cyl,Phi_c,R_c,Z_c);
save('GMS_volumetric_cyl_1deg_sm_2.mat','I_cart_cylint')

figure(16)
slice(Xc,Yc,Zc,I_cart_cylint,[0],[0],[0])
colormap(jet)
caxis([0,70])
shading flat

figure(17)
slice(Xc,Yc,Zc,I_cart_cartint,[0],[0],[0])
colormap(jet)
caxis([0,70])
shading flat
%}
%}


%%
%test plots
%{
figure(12)
cla
pcolor(X,Z,I_0(:,:,4)); shading flat;
caxis([0,70])
axis square

figure(13)
cla
pcolor(Xr,Zr,I_right(:,:,1)); shading flat;
caxis([0,70])

figure(14)
cla
xl=0.5:1:92.5;
zl=0.5-c_y:1:pix_y-c_y-0.5;
pcolor(Xl,Zl,I_left(:,:,1)); shading flat;
caxis([0,70])

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
%}
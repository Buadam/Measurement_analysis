phi_deg=(-180:10:180); 
phi_rad=phi_deg*pi/180;
r=(0:0.1:10);
z=(-10:0.1:10);

a=1;
b=2;
c=5;
r_ab=a*b./sqrt(b^2*cos(phi_rad).^2+a^2*sin(phi_rad).^2);

[phi_m,r_m,z_m]=meshgrid(phi_rad,r,z);
I_cyl=r_m.^2./(r_ab.^2)+z_m.^2/c^2;

I_cyl=permute(I_cyl,[2,1,3]);
phi_m=permute(phi_m,[2,1,3]);
r_m=permute(r_m,[2,1,3]);
z_m=permute(z_m,[2,1,3]);

figure(2)
ind=1;
cla
X=squeeze(r_m(ind,:,:));
Y=squeeze(z_m(ind,:,:));
I=squeeze(I_cyl(ind,:,:));
pcolor(X,Y,I);
hold on
contour(X,Y,I,[1,2,3,4,5,6],'Color','r');
shading flat;

dx=0.1;
dy=0.1;
dz=0.1;
x_cart=-5:dx:5;
y_cart=-5:dy:5;
z_cart=-10:dz:10;

[X_cartm,Y_cartm,Z_cartm]=meshgrid(x_cart,y_cart,z_cart);
[Phi_cart,R_cart,Z_cart]=cart2pol(X_cartm,Y_cartm,Z_cartm);
I_cart=griddata(phi_m,r_m,z_m,I_cyl,Phi_cart,R_cart,Z_cart);

figure(3)
ind=abs(min(x_cart))/dx+1;
cla
X=squeeze(R_cart(:,ind,:));
Y=squeeze(Z_cart(:,ind,:));
I=squeeze(I_cart(:,ind,:));
pcolor(X,Y,I);
hold on
contour(X,Y,I,[1,2,3,4,5,6],'Color','r');
shading flat;

figure(4)
ind=abs(min(x_cart))/dx+1;
cla
X=squeeze(X_cartm(ind,:,:));
Y=squeeze(Z_cartm(ind,:,:));
I=squeeze(I_cart(ind,:,:));
pcolor(X,Y,I);
hold on
contour(X,Y,I,[1,2,3,4,5,6],'Color','r');
shading flat;


figure(5)
slice(X_cartm,Y_cartm,Z_cartm,I_cart,[0],[0],[0])
colormap(jet)
caxis([0,70])
shading flat
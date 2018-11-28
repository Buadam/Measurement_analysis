function I_0_sm=SANS_image_postconditioning_cart(I_0,sigma,rmax,zmin,zmax,Rmax)


x=-rmax:1:rmax;
y=-rmax:1:rmax;
z=zmin:1:zmax;
[X,Y,Z]=meshgrid(x,y,z);

rg=X.^2+Y.^2+Z.^2;
I_0(rg<Rmax^2)=NaN;


sz = 2*ceil(2.6 * sigma) + 1; % See note below
mask = fspecial('gauss', sz, sigma);

I_0_sm=I_0;

%for i=1:size(I_0,1)
%    I_temp = conv2(squeeze(I_0(i,:,:)), mask, 'same');
%    I_0_sm(i,:,:)=I_temp;
%end

%{
figure(12)
cla
pcolor(X,Z,I_0_sm(:,:,4)); shading flat;
caxis([0,70])
axis square

hold on
plot(0.5,0.5,'rx')
%}
end
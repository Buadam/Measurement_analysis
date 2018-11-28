function I_0_sm=SANS_image_postconditioning(I_0,sigma,rmin,rmax,zmin,zmax,Rmax)


x=rmin:1:rmax;
z=zmin:1:zmax;
[X,Z]=meshgrid(x,z);

rg=X.^2+Z.^2;
rg=permute(rg,[2,1]);

sz = 2*ceil(2.6 * sigma) + 1; % See note below
mask = fspecial('gauss', sz, sigma);

I_0_sm=[];

for i=1:size(I_0,1)
    I_temp = conv2(squeeze(I_0(i,:,:)), mask, 'same');
    I_temp(rg<Rmax^2)=NaN;
    I_0_sm(i,:,:)=I_temp;
end

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
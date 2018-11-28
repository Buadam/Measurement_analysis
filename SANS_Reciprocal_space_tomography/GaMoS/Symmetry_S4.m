function [Xt,Yt,Zt,Itr]=Symmetry_Rotate(X,Y,Z,I,v1)
%Perform Rotation transformation
q=75; %hexagon size
a=phi*pi/180;

R=[
    cos(a),-sin(a),0;...
    sin(a),cos(a),0;...
    0,0,-1;...
];
%Rotation axis

vz=v1/norm(v1);
vxy=null(vz(:)');
T=[vxy,vz];  %The rows of this matrix are the axes
A=T*R*T';
assignin('base','A',A);
Xt=zeros(size(X,1),size(Y,2),size(Z,3));
Yt=zeros(size(X,1),size(Y,2),size(Z,3));
Zt=zeros(size(X,1),size(Y,2),size(Z,3));
for i=1:size(X,1)
    for j=1:size(Y,2)
        for k=1:size(Z,3)
           vtr=A*[X(i,j,k);Y(i,j,k);Z(i,j,k)];
           Xt(i,j,k)=vtr(1);
           Yt(i,j,k)=vtr(2);
           Zt(i,j,k)=vtr(3);
        end
    end
end

%Interpolate on original grid
Itr=griddata(Xt,Yt,Zt,I,X,Y,Z);

%Plot together original and transformed data
figure
ax3=subplot(1,2,1);
cla
title(['Rotation around: ' mat2str(v1) ' by: ' num2str(phi) '°'])
box on
grid on
axis square
hold on
thr_low=4.2;
thr_high=6;

ind=find(I<thr_high & I>thr_low);
[K,L,M]=ind2sub([size(X,1),size(Y,2),size(Z,3)],ind);
vx=X(K,1,1); %ndgrid: 1st index K, meshgrid: 2nd index K
vy=Y(1,L,1); %ndgrid: 2nd index L, meshgrid: 1st index L
vz=Z(1,1,M);
scatter3(vx,vy,vz,2,I(ind))
%Plot hexagonal model
[v1t,v2t,v3t,v4t] = Hexagons(q,0);
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r','LineWidth',1.5)
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b','LineWidth',1.5)
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g','LineWidth',1.5)
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y','LineWidth',1.5)

text(0,0,q,'(1,-1,0)')
text(q,0,0,'(1,1,-2)')
text(0,q,0,'(1,1,1)')

view([1,1,1])

ax4=subplot(1,2,2);
cla
title('Rotated')
hold on
axis square
grid on
box on

ind=find(Itr<thr_high & Itr>thr_low);
[K,L,M]=ind2sub([size(X,1),size(Y,2),size(Z,3)],ind);
vx=X(K,1,1); %ndgrid: 1st index K, meshgrid: 2nd index K
vy=Y(1,L,1); %ndgrid: 2nd index L, meshgrid: 1st index L
vz=Z(1,1,M);
scatter3(vx,vy,vz,2,Itr(ind))

%Plot hexagonal model
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')

text(0,0,q,'(1,-1,0)')
text(q,0,0,'(1,1,-2)')
text(0,q,0,'(1,1,1)')

view([1,1,1])

hlink = linkprop([ax3,ax4],{'CameraPosition','CameraUpVector'}); 
rotate3d on
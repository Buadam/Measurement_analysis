x=-6.2:0.5:6.2; x=x';
y=-6.2:0.5:6.2; y=y';
z=-6.2:0.5:6.2; z=z';

[X,Y,Z]=ndgrid(x,y,z);
I=sin(X).*sin(Y).*sin(Z);

thr_low=0.4;
thr_hi=0.6;

ind=find(I<thr_hi & I>thr_low);

K=[]; L=[]; M=[];
[K,L,M]=ind2sub([length(x),length(y),length(z)],ind);

vx=[];
vy=[];
vz=[];
for i=1:length(K)
    vx(i)=X(K(i),L(i),M(i));
    vy(i)=Y(K(i),L(i),M(i));
    vz(i)=Z(K(i),L(i),M(i));
end

figure(4322312)
subplot(1,2,1)
cla
scatter3(vx,vy,vz,25,I(ind))
view(3)
xlim([min(x),max(x)])
ylim([min(y),max(y)])
zlim([min(z),max(z)])
caxis([thr_low,thr_hi])

%%
%Perform symmetry operation

phi=120;
v1=[1;1;1];
[Xt,Yt,Zt,Itr]=Symmetry_rotate(X,Y,Z,I,phi,v1);
%%
figure(4322312)
subplot(1,2,2)
ind=find(Itr<thr_hi & Itr>thr_low);

K=[]; L=[]; M=[];
[K,L,M]=ind2sub([length(x),length(y),length(z)],ind);

vx=[];
vy=[];
vz=[];
for i=1:length(K)
    vx(i)=X(K(i),L(i),M(i));
    vy(i)=Y(K(i),L(i),M(i));
    vz(i)=Z(K(i),L(i),M(i));
end

cla
scatter3(vx,vy,vz,25,Itr(ind))
view(3)
xlim([min(x),max(x)])
ylim([min(y),max(y)])
zlim([min(z),max(z)])
caxis([thr_low,thr_hi])


%Perform mirror symmetry operation

m1=[1;1;0];
[Xt,Yt,Zt,Itr]=Symmetry_mirror(X,Y,Z,I,m1);
%%
figure(4322312)
subplot(1,2,2)
ind=find(Itr<thr_hi & Itr>thr_low);

K=[]; L=[]; M=[];
[K,L,M]=ind2sub([length(x),length(y),length(z)],ind);

vx=[];
vy=[];
vz=[];
for i=1:length(K)
    vx(i)=X(K(i),L(i),M(i));
    vy(i)=Y(K(i),L(i),M(i));
    vz(i)=Z(K(i),L(i),M(i));
end

cla
scatter3(vx,vy,vz,25,Itr(ind))
view(3)
xlim([min(x),max(x)])
ylim([min(y),max(y)])
zlim([min(z),max(z)])
caxis([thr_low,thr_hi])


s1=[1;0;0];
phi=90;
[Xt,Yt,Zt,Itr]=Symmetry_impropRotate(X,Y,Z,I,phi,s1);
%%
figure(4322312)
subplot(1,2,2)
ind=find(Itr<thr_hi & Itr>thr_low);

K=[]; L=[]; M=[];
[K,L,M]=ind2sub([length(x),length(y),length(z)],ind);

vx=[];
vy=[];
vz=[];
for i=1:length(K)
    vx(i)=X(K(i),L(i),M(i));
    vy(i)=Y(K(i),L(i),M(i));
    vz(i)=Z(K(i),L(i),M(i));
end

cla
scatter3(vx,vy,vz,25,Itr(ind))
view(3)
xlim([min(x),max(x)])
ylim([min(y),max(y)])
zlim([min(z),max(z)])
caxis([thr_low,thr_hi])

%{
%%
subplot(1,3,2)
ind=find(I<thr_hi & I>thr_low);

K=[]; L=[]; M=[];
[K,L,M]=ind2sub([length(x),length(y),length(z)],ind);

vx=[];
vy=[];
vz=[];
for i=1:length(K)
    vx(i)=Xt(K(i),L(i),M(i));
    vy(i)=Yt(K(i),L(i),M(i));
    vz(i)=Zt(K(i),L(i),M(i));
end

cla
scatter3(vx,vy,vz,25,I(ind))
view(3)
xlim([min(x),max(x)])
ylim([min(y),max(y)])
zlim([min(z),max(z)])
caxis([thr_low,thr_hi])
%}
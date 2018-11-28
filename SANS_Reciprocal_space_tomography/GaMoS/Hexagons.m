function [v1t,v2t,v3t,v4t] = Hexagons(size,offset)

v1=[
    -1,0,1;... 
    0,-1,1;... 
    1,-1,0;...  
    1,0,-1;...
    0,1,-1;...
    -1,1,0;...
    -1,0,1;... 
    ]/sqrt(2);
v2=[
    -1,0,-1;...
    -1,-1,0;...
    0,-1,1;...
    1,0,1;...
    1,1,0;...
    0,1,-1;...
    -1,0,-1;...
    ]/sqrt(2);
v3=[
    
    0,-1,-1;...
    1,-1,0;...
    1,0,1;...
    0,1,1;...
    -1,1,0;...
   -1,0,-1;...
    0,-1,-1;...
    ]/sqrt(2);
v4=[
    0,-1,-1;...
    1,0,-1;...
    1,1,0;... 
    0,1,1;...
    -1,0,1;...
    -1,-1,0;...
    0,-1,-1;...
    ]/sqrt(2);

%Transform to [1-10]
z2=[1;-1;0]/sqrt(2);
x2=[1;1;-2]/sqrt(6);
y2=[1;1;1]/sqrt(3);

T=[x2,y2,z2];

v1t=(T\v1')'; 
v2t=(T\v2')';
v3t=(T\v3')';
v4t=(T\v4')';

alpha=offset*pi/180;
T2=[cos(alpha),-sin(alpha),0;sin(alpha),cos(alpha),0;0,0,1];

v1t=size*(T2*v1t')'; 
v2t=size*(T2*v2t')';
v3t=size*(T2*v3t')';
v4t=size*(T2*v4t')';

%{
figure(423452)
subplot(1,2,1)
cla
hold all
%drawCube([0,0,0],2)
plot3(v1(:,1),v1(:,2),v1(:,3),'Color','r')
plot3(v2(:,1),v2(:,2),v2(:,3),'Color','b')
plot3(v3(:,1),v3(:,2),v3(:,3),'Color','g')
plot3(v4(:,1),v4(:,2),v4(:,3),'Color','y')
text(1,-1,0,'(1,-1,0)')
text(1/2,1/2,-1,'(1,1,-2)')
text(1,1,1,'(1,1,1)')
box on
axis square

subplot(1,2,2)
cla
hold all
plot3(v1t(:,1),v1t(:,2),v1t(:,3),'Color','r')
plot3(v2t(:,1),v2t(:,2),v2t(:,3),'Color','b')
plot3(v3t(:,1),v3t(:,2),v3t(:,3),'Color','g')
plot3(v4t(:,1),v4t(:,2),v4t(:,3),'Color','y')


text(0,0,1,'(1,-1,0)')
text(1,0,0,'(1,1,-2)')
text(0,1,0,'(1,1,1)')
box on
axis square
%}

end
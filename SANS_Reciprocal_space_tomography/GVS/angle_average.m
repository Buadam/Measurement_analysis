for i=1:19 
if i<10
    ang=dlmread(['G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_01_GaMoS_SANS_Oakridge\06_01_Wide_angle_scan\Analysis\I_vs_Xi\I_vs_Xi_3bin_full_00', num2str(i), '.dat'],'\t',31,0);
else
    ang=dlmread(['G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_01_GaMoS_SANS_Oakridge\06_01_Wide_angle_scan\Analysis\I_vs_Xi\I_vs_Xi_3bin_full_0', num2str(i), '.dat'],'\t',31,0);
end 
xi1=(0.5:1:89.5)'; 
q1=ang(1:90,2:3);
q2=flipud(ang(91:180,2:3));
q3=ang(181:270,2:3);
q4=flipud(ang(271:360,2:3));

ang_sum=(q1(:,1)+q2(:,1)+q3(:,1)+q4(:,1))/4;

figure(10)
hold on
plot(xi1,ang_sum+i*0.01,'wo-','MarkerSize',2)

end
%folder_name = uigetdir;
folder_name='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_01_GaMoS_SANS_Oakridge\06_01_Wide_angle_scan\Analysis\SANS_images\crop';
images=dir(fullfile(folder_name,'*jpg'));
mkdir([fullfile(folder_name) '\collect2']);

Ready=[];

rows=9
columns=round(size(images,1)/rows)+1
for j=1:columns
  Full=[];
for i=1:rows
    if (j-1)*rows+i<=size(images,1)
        %Temp=imread(fullfile(folder_name,[num2str((((j-1)*columns+i)-1)*30) 'deg.jpg']));
        Temp=imread(fullfile(folder_name,images((j-1)*rows+i).name)); images((j-1)*rows+i).name
        Mag=imresize(Temp,[NaN 400]);
        Full=cat(1,Full,Mag);
    else
        Full=cat(1,Full,256*ones(size(Mag,1),size(Mag,2),3));
    end
end
Ready=cat(2,Ready,Full);
end


imwrite(Ready,fullfile([folder_name '\collect2'],'images_appended_rows.jpg'),'jpg')


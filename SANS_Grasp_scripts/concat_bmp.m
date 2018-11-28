%folder_name = uigetdir;
folder_name='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_01_GaMoS_SANS_Oakridge\06_01_Wide_angle_scan\Analysis\Images\crop';
images=dir(fullfile(folder_name,'*jpg'));
mkdir([fullfile(folder_name) '\collect']);

Ready=[];

columns=10
rows=round(size(images,1)/columns)+1
for j=1:rows
  Full=[];
for i=1:columns
    if (j-1)*columns+i<=size(images,1)
        %Temp=imread(fullfile(folder_name,[num2str((((j-1)*columns+i)-1)*30) 'deg.jpg']));
        Temp=imread(fullfile(folder_name,images((j-1)*columns+i).name)); images((j-1)*columns+i).name
        Mag=imresize(Temp,[NaN 400]);
        Full=cat(2,Full,Mag);
    else
        Full=cat(2,Full,256*ones(size(Mag,1),size(Mag,2),3));
    end
end
Ready=cat(1,Ready,Full);
end


imwrite(Ready,fullfile([folder_name '\collect'],'images_appended_rows.jpg'),'jpg')


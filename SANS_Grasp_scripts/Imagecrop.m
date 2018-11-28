%folder_name = uigetdir;
folder_name='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_01_GaMoS_SANS_Oakridge\06_01_Wide_angle_scan\Analysis\Images';
images=dir(fullfile(folder_name,'*jpg'));
mkdir([fullfile(folder_name) '\crop']);

%Renaming single numbered files
Key   = 'GMS_wideangle';
N=size(images,1);
for i=1:N
Index = strfind(images(i).name, Key);
number = sscanf(images(i).name(Index(1) + length(Key):end), '%g', 1)    
%number=N-number+1;


Temp=imread(fullfile(folder_name,images(i).name));
if number < 10
    %strrep(images(i).name, num2str(number), ['0' num2str(number)]);
    %images(i).name=[images(i).name(1:Index(1)+length(Key)-1) '0' images(i).name(Index(1) + length(Key):end)];
    images(i).name=[images(i).name(1:Index(1)+length(Key)-1) '00' num2str(number) '.jpg'];
elseif number < 100
    %strrep(images(i).name, num2str(number), ['0' num2str(number)]);
    %images(i).name=[images(i).name(1:Index(1)+length(Key)-1) '0' images(i).name(Index(1) + length(Key):end)];
    images(i).name=[images(i).name(1:Index(1)+length(Key)-1) '0' num2str(number) '.jpg'];

end


images(i).name
Crop=Temp(80:80+540,80:80+540,:);
imwrite(Crop,fullfile([folder_name '\crop'],images(i).name),'jpg')
end


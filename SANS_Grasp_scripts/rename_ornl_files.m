Folder='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_05_22_SANS_OakRidge\05_23_meas3_S2_42mg_Bscan_10K\Original_data';
Target='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2017_05_22_SANS_OakRidge\05_23_meas3_S2_42mg_Bscan_10K\Renamed_data';
files = dir(fullfile(Folder,'*xml'));

for id = 1:length(files)
    %{
    newname=strrep(files(id).name,'_00','00');
    
    newname=strrep(newname,'scan0','scan_1');
    
    n = str2num(newname(strfind(newname, 'scan_')+5:strfind(newname, '.')-1));
    
    n2 = str2num(newname(strfind(newname, 'scan_')+7:strfind(newname, 'scan_')+8));
    if mod(n2,2) == 0
        n_new=n-9979;
        newname = [newname(1:strfind(newname, 'scan_')+4) num2str(n_new) '.xml'];
    end
    %}
    
    
    newname=[num2str(id,'%04d') '.xml'];
    copyfile(fullfile(Folder,files(id).name),fullfile(Target,newname));
end

%{
for id = 106:length(files)
    newname=strrep(files(id).name,'_00','00');
    newname=strrep(newname,'scan0','scan_1');
    
    n = str2num(newname(strfind(newname, 'scan_')+5:strfind(newname, '.')-1));
    
    n2 = str2num(newname(strfind(newname, 'scan_')+7:strfind(newname, 'scan_')+8));
    if mod(n2,2) == 1
        n_new=n-9979;
        newname = [newname(1:strfind(newname, 'scan_')+4) num2str(n_new) '.xml'];
    end
    
    copyfile(fullfile(Folder,files(id).name),fullfile(Target,newname));
end
%}

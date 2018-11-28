function loadall(first,last,seq,gap)

global grasp_env



%Select data
str='';
for act=first:(seq+gap):last;
  str=[str sprintf('%d:%d;',act,act+seq-1)];
end

a=textscan(str,'%s','Delimiter',';');
load_str = (char(a{1,1}));
disp('Loading data:')
disp(load_str)
%{
for i=1:size(load_str,1);
if (i>grasp_env.worksheet.worksheets)
add_worksheet(1);
end
    load_data(1, i, load_str(i,:));

end
%}
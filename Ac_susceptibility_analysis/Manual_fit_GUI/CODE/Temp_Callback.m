% --- Executes on selection change in Temp.
function Temp_Callback(hObject, eventdata, handles)
global all

T=[6.5,7,8,8.5,9,9.5,10,10.5,10.75,11,11.25,11.5,12];   
%get actual abs and chi data
t=get(handles.Temp,'Value');


freq=7;
B=all{t}(1:end,1+freq);


%Populate B list
set(handles.Field,'String',num2str(B))

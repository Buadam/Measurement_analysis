% --- Executes on selection change in Field.
function Field_Callback(hObject, eventdata, handles)

global all chi_B_T abs_B_T

t=get(handles.Temp,'Value');
ind=get(handles.Field,'Value');
f=1:1:7;

chi_B_T=all{t}(ind,f+2*7);
abs_B_T=all{t}(ind,f+3*7);

Refresh_Callback(handles);

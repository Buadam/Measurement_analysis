% --- Executes on slider movement.
function Scale_Callback(hObject, eventdata, handles)

sc=get(handles.Scale,'Value');

for i=1:20 
    temp(i)=get(handles.(['slider' num2str(i)]),'Value');
end

m=max(temp);

for i=1:20 
    set(handles.(['slider' num2str(i)]),'Value',temp(i)*sc/m);
end

get_amplitudes(handles);



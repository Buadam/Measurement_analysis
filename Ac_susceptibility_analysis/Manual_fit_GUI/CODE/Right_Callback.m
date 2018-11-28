% --- Executes on button press in Right.
function Right_Callback(hObject, eventdata, handles)

global N
disp('shift right')
for i=1:N-1

    temp=get(handles.(['slider' num2str(N-i)]),'Value');
    set(handles.(['slider' num2str(N-i+1)]),'Value',temp);
end

set(handles.slider1,'Value',0);
get_amplitudes(handles);
Refresh_Callback(handles);
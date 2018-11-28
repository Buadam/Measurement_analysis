
% --- Executes on button press in Left.
function Left_Callback(hObject, eventdata, handles)
%
global N
disp('shift left')
for i=1:N-1

    temp=get(handles.(['slider' num2str(i+1)]),'Value');
    set(handles.(['slider' num2str(i)]),'Value',temp);
end

set(handles.slider20,'Value',0);
get_amplitudes(handles);
Refresh_Callback(handles);
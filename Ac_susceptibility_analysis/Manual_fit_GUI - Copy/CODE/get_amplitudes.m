function get_amplitudes(handles)

%get amplitudes
global A N
for i=1:N
    A(i)=1e-4*get(handles.(['slider' num2str(i)]),'Value');
end

assignin ('base','Ampl',A)

Refresh_Callback(handles);
end
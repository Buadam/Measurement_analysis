% --- Executes on button press in KK.
function KK_Callback(hObject, eventdata, handles)

global abs_B_T 

fr=[0.1,1,10,45,110,500,1000];
f_m=logspace(-1,3,100);
    abscont=interp1(log10(fr),abs_B_T,log10(f_m),'cubic');
    

    %% get KK of the absorption
    [f_meas,ReChiKK_cont]=KramersKronig1(f_m,abscont');
    
    set(handles.ImChi,'Nextplot','add')
    plot(handles.ImChi,f_m,abscont,'--','Color','g')
    set(handles.ImChi,'Nextplot','replace')
    
    set(handles.ReChi,'Nextplot','add')
    plot(handles.ReChi,f_meas,ReChiKK_cont,'--','Color','g')
    set(handles.ReChi,'Nextplot','replace')
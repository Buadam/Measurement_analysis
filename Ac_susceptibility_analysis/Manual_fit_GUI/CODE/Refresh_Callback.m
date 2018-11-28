% --- Executes on button press in Refresh.
function Refresh_Callback(handles)
% hObject    handle to Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global chi_B_T abs_B_T N A fcont ReChi1 ReChi2 ImChi1 ImChi2 g_CC g_HN

set(handles.ReChi,'Nextplot','replace')
set(handles.ImChi,'Nextplot','replace')
set(handles.Taudist,'Nextplot','replace')

fr=[0.1,1,10,45,110,500,1000];
fcont=logspace(-10,10,100);
%Fixed parameters
taumin=str2double(get(handles.taumin,'String'));     %smallest tau
taumax=str2double(get(handles.taumax,'String'));     %largest tau



plot(handles.ReChi,fr,chi_B_T,'o','Color','b')
plot(handles.ImChi,fr,abs_B_T,'o','Color','b')

set(handles.ReChi,'XScale','log','Nextplot','add')
set(handles.ImChi,'XScale','log','Nextplot','add')



tau_seg=logspace(log10(taumin),log10(taumax),N);    %Logarithmic segments of tau.
omega=2*pi*fcont;
imchi=zeros(size(omega))'; 
rechi=zeros(size(omega))';

chi_inf_re=get(handles.chi_inf,'Value')*1e-4;
tau_seg=logspace(log10(taumin),log10(taumax),N);
Ntau=1000; %number of integration step in tau

for t=1:length(tau_seg)-1  
    tau=logspace(log10(tau_seg(t)),log10(tau_seg(t+1)),Ntau);  %domain of integration in the actual segment
    chi=trapz(log10(tau),1./(1+1i*(omega'*tau)),2); %integrating for tau in the actual segment
    imchi=imchi-A(t)*imag(chi);
    rechi=rechi+A(t)*real(chi);
    
    plot(handles.ReChi,fcont,A(t)*real(chi),'r-')
    plot(handles.ImChi,fcont,-A(t)*imag(chi),'r-')
    
    
end
rechi=rechi+chi_inf_re;


plot(handles.ReChi,fcont,rechi,'k-')
plot(handles.ImChi,fcont,imchi,'k-')


plot(handles.Taudist,tau_seg,A*1e4,'ko-')
set(handles.Taudist,'XScale','log')
set(handles.Taudist,'Nextplot','add')

if ~isempty(ReChi1)
        plot(handles.ReChi,fcont,ReChi1,'r-')
        plot(handles.ImChi,fcont,ImChi1,'r-')
        plot(handles.Taudist,tau_seg,g_CC,'ro-')
end
if ~isempty(ReChi2)
        plot(handles.ReChi,fcont,ReChi2,'b--')
         plot(handles.ImChi,fcont,ImChi2,'b--')
         plot(handles.Taudist,tau_seg,g_HN,'ro-')
end

set(handles.Taudist,'Nextplot','replace')


%{
%%KK-test
[f_out,ReChiKK]=KramersKronig1(omega/2/pi,imchi);
[f_meas,ReChiKK_meas]=KramersKronig1(fr,abs_B_T');

figure(12212)
subplot(2,1,1)

plot(f_out,ReChiKK+chi_inf_re,'b-.','Linewidth',2)
plot(f_meas,ReChiKK_meas+chi_inf_re,'g--')


%%plot tau distribution
figure(1231231)

%}
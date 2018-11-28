% --- Executes on button press in Fit.
function Fit_Callback(hObject, eventdata, handles)


global chi_B_T abs_B_T fcont N g_HN g_CC g_RE g_IM ReChi1 ReChi2 ImChi1 ImChi2 ReChi_Re ReChi_Im ImChi_Re ImChi_Im A


CC=get(handles.CC,'Value'); %Fit Cole-Cole
HN=get(handles.HN,'Value'); %Fit Havriliak-Negami
RE=get(handles.RE,'Value'); %Fit Real
IM=get(handles.IM,'Value'); %Fit Imag

%%%%%%%%%
%Fitting%
%%%%%%%%%
fr=[0.1,1,10,45,110,500,1000];
omega=2*pi*fr;
taumin=str2double(get(handles.taumin,'String'));
taumax=str2double(get(handles.taumax,'String'));
tauD=logspace(log10(taumin),log10(taumax),N);    

%rescaling curves to unity to obtain better conditioning
%[maxabs indmax]=max(abs_B_T);
          
rescale_re=max(chi_B_T);
rescale_im=max(abs_B_T);
ratio=rescale_re/rescale_im;
        
if isempty(rescale_re)
     rescale_re=chi_B_T(1);
end
        
%%
%Initial parameters
tau=0.1;    %p(1)
alpha=0.7;  %p(2)
beta=1;     %p(3)
Chi0=rescale_re; %p(4)
Chi0_inf_re=0;  %p(5)
     
       
p0_1=[tau,...
      alpha,...
      Chi0/rescale_re,...
      Chi0_inf_re/rescale_re];
        
p0_2=[tau,...
     alpha,...
     beta,...
     Chi0/rescale_re,...
     Chi0_inf_re/rescale_re];
       
%%
%Fitting

    ChiComp1=@(p3,omega)complexsusc_CC(p3,omega,ratio);
    ChiComp2=@(p3,omega)complexsusc_HN(p3,omega,ratio);
    ChiComp3=@(p3,omega)complexsusc_Re(p3,omega);
    ChiComp4=@(p3,omega)complexsusc_Im(p3,omega);
  
        %Least-square fitting to the experimental data
        lb1=[0,0,0,0];
        ub1=[1e10,1,100,1];
        lb2=[0,0,0,0,0];
        ub2=[1e10,1,1,100,1];

 if CC==1
        [p3,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp1,p0_1,omega,[abs_B_T'/rescale_im chi_B_T'/rescale_re],lb1,ub1);
        param1=[p3(1),p3(2),p3(3)*rescale_re,p3(4)*rescale_re];
        CompChi=complexsusc_CC(param1,2*pi*fcont,1); %Im(Chi) and Re(Chi) are fitted together
        ImChi1=CompChi(:,1);
        ReChi1=CompChi(:,2);
        
        for i=1:4
            set(handles.(['p1_' num2str(i)]),'String',num2str(param1(i)))
        end
        
        taumin=str2double(get(handles.taumin,'String'));
        taumax=str2double(get(handles.taumax,'String'));
        tauD=logspace(log10(taumin),log10(taumax),N);
        [g_CC,f_max]=calc_taudistr(tauD,p3(1),p3(2),1);
        assignin ('base','Ampl_CC',g_CC)
        
        %rescale g_HN
        g_CC=g_CC*max(A)/max(g_CC)*1e4;
        
        set(handles.ReChi,'Nextplot','add')
        set(handles.ImChi,'Nextplot','add')
        set(handles.Taudist,'Nextplot','add')
        plot(handles.ReChi,fcont,ReChi1,'r-')
        plot(handles.ImChi,fcont,ImChi1,'r-')
        plot(handles.Taudist,tauD,g_CC,'ro-')
        set(handles.ReChi,'Nextplot','replace')
        set(handles.ImChi,'Nextplot','replace')
        set(handles.Taudist,'Nextplot','replace')
 end
 if HN==1
        [p4,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp2,p0_2,omega,[abs_B_T'/rescale_im chi_B_T'/rescale_re],lb2,ub2);
        param2=[p4(1),p4(2),p4(3),p4(4)*rescale_re,p4(5)*rescale_re];
        CompChi=complexsusc_HN(param2,2*pi*fcont,1); %Im(Chi) and Re(Chi) are fitted together
        ImChi2=CompChi(:,1);
        ReChi2=CompChi(:,2);
        
        for i=1:5
            set(handles.(['p2_' num2str(i)]),'String',num2str(param2(i)))
        end
        
        [g_HN,f_max]=calc_taudistr(tauD,p4(1),p4(2),p4(3));
        assignin ('base','Ampl_HN',g_HN)
        
        %rescale g_HN
        g_HN=g_HN*max(A)/max(g_HN)*1e4;
        
        
        set(handles.ReChi,'Nextplot','add')
        set(handles.ImChi,'Nextplot','add')
        set(handles.Taudist,'Nextplot','add')
        plot(handles.ReChi,fcont,ReChi2,'b--')
        plot(handles.ImChi,fcont,ImChi2,'b--')
        plot(handles.Taudist,tauD,g_HN,'bo-')
        set(handles.ReChi,'Nextplot','replace')
        set(handles.ImChi,'Nextplot','replace')
        set(handles.Taudist,'Nextplot','replace')
 end       
        

if RE==1
        [p1,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp3,p0_1,omega,chi_B_T'/rescale_re,lb1,ub1);
        param3=[p1(1),p1(2),p1(3)*rescale_re,p1(4)*rescale_re];
        CompChi=complexsusc_CC(param3,2*pi*fcont,1); % Re(Chi) fitted only
        ImChi_Re=CompChi(:,1);
        ReChi_Re=CompChi(:,2);
        
        for i=1:4
            set(handles.(['p3_' num2str(i)]),'String',num2str(param3(i)))
        end
        
        [g_RE,f_max]=calc_taudistr(tauD,p1(1),p1(2),1);
        assignin ('base','Ampl_HN',g_RE)
        
        %rescale g_HN
        g_RE=g_RE*max(A)/max(g_RE)*1e4;
        
        
        set(handles.ReChi,'Nextplot','add')
        set(handles.ImChi,'Nextplot','add')
        set(handles.Taudist,'Nextplot','add')
        plot(handles.ReChi,fcont,ReChi_Re,'g--')
        plot(handles.ImChi,fcont,ImChi_Re,'g--')
        plot(handles.Taudist,tauD,g_RE,'go-')
        set(handles.ReChi,'Nextplot','replace')
        set(handles.ImChi,'Nextplot','replace')
        set(handles.Taudist,'Nextplot','replace')
end  
 
if IM==1
        [p2,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp4,p0_1,omega,abs_B_T'/rescale_re,lb1,ub1);
        param4=[p2(1),p2(2),p2(3)*rescale_re,p2(4)*rescale_re];
        CompChi=complexsusc_CC(param4,2*pi*fcont,1); % Re(Chi) fitted only
        ImChi_Im=CompChi(:,1);
        ReChi_Im=CompChi(:,2);
        
        for i=1:4
            set(handles.(['p4_' num2str(i)]),'String',num2str(param4(i)))
        end
        
        [g_IM,f_max]=calc_taudistr(tauD,p2(1),p2(2),1);
        assignin ('base','Ampl_HN',g_IM)
        
        %rescale g_HN
        g_IM=g_IM*max(A)/max(g_IM)*1e4;
        
        
        set(handles.ReChi,'Nextplot','add')
        set(handles.ImChi,'Nextplot','add')
        set(handles.Taudist,'Nextplot','add')
        plot(handles.ReChi,fcont,ReChi_Im,'r--')
        plot(handles.ImChi,fcont,ImChi_Im,'r--')
        plot(handles.Taudist,tauD,g_IM,'ro-')
        set(handles.ReChi,'Nextplot','replace')
        set(handles.ImChi,'Nextplot','replace')
        set(handles.Taudist,'Nextplot','replace')
 end 
        
        
        
        
  
  











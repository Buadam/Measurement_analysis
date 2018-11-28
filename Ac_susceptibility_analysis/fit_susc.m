function [ReChi1,ImChi1,param1]=fit_susc(fr,fcont,chi_B_T,abs_B_T,logtau,blcorr)
        
        %%
        %%%%%%%%%
        %Fitting%
        %%%%%%%%%
        omega=2*pi*fr;
        
        %rescaling curves to unity to obtain better conditioning
        %[maxabs indmax]=max(abs_B_T);
        
        rescale_im=max(abs_B_T);
        rescale_re=max(chi_B_T);
        ratio=rescale_re/rescale_im;
        
        if isempty(rescale_im)
            rescale_im=abs_B_T(1);
        end
        if isempty(rescale_re)
            rescale_re=chi_B_T(1);
        end
        
        %Initial parameters
        if logtau==1
            tau=-1;
        else
            tau=0.1;    %p(1)
        end
        alpha=0.7;  %p(2)
        Chi0=rescale_re; %p(3)
        Chi0_inf_re=chi_B_T(end);  %p(4)
        
        p0_1=[tau,...
            alpha,...
            Chi0/rescale_re,...
            Chi0_inf_re/rescale_re];
        
       
        %%
        %Fitting Cole-Cole
        ChiComp1=@(p3,omega)complexsusc_CC(p3,omega,ratio,logtau);
        
        %Least-square fitting to the experimental data
        if blcorr==1
            lb1=[0,0,0,0];
        else
            lb1=[0,0,0,0];
        end
        ub1=[1e10,1,100,1];
        
        [p3,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp1,p0_1,omega,[abs_B_T'/rescale_im chi_B_T'/rescale_re],lb1,ub1);
        if logtau==1
            param1=[10^(p3(1)),p3(2),p3(3)*rescale_re,p3(4)*rescale_re];
        else
            param1=[p3(1),p3(2),p3(3)*rescale_re,p3(4)*rescale_re];
        end
        CompChi=complexsusc_CC(param1,2*pi*fcont,1,0); %Im(Chi) and Re(Chi) are fitted together
        ImChi1=CompChi(:,1);
        ReChi1=CompChi(:,2);
        
        
        %%Havriliak-Negami fit
        %{
        %Initial parameters
        tau=0.1;    %p(1)
        alpha=0.7;  %p(2)
        beta=1;     %p(3)
        Chi0=rescale_re; %p(4)
        Chi0_inf_re=chi_B_T(end);  %p(5)
        
        p0_2=[tau,...
            alpha,...
            beta,...
            Chi0/rescale_re,...
            Chi0_inf_re/rescale_re];        

        ChiComp2=@(p3,omega)complexsusc_HN(p3,omega,ratio,logtau);

        lb2=[0,0,0,0,0];
        ub2=[1e10,1,1,100,1];
        [p4,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp2,p0_2,omega,[abs_B_T'/rescale_im chi_B_T'/rescale_re],lb2,ub2);
        param2=[p4(1),p4(2),p4(3),p4(4)*rescale_re,p4(5)*rescale_re];
      
        CompChi=complexsusc_HN(param2,2*pi*fcont,1); %Im(Chi) and Re(Chi) are fitted together
        ImChi2=CompChi(:,1);
        ReChi2=CompChi(:,2);
        %}
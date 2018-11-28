function [ReChi,ImChi,param]=fit_susc(chi_B_T,abs_B_T,equal)

 
        
        
        
        %%
        %%%%%%%%%
        %Fitting%
        %%%%%%%%%
        fr=[0.1,1,10,45,110,500,1000];
        omega=2*pi*fr;
        fcont=logspace(-5,5,100);
        
        %rescaling curves to unity to obtain better conditioning
        %[maxabs indmax]=max(abs_B_T);
        
        rescale_im=max(abs_B_T);
        rescale_re=max(chi_B_T);
        
        if isempty(rescale_im)
            rescale_im=abs_B_T(1);
        end
        if isempty(rescale_re)
            rescale_re=chi_B_T(1);
        end
        
        %Initial parameters
        Chi0_im=rescale_im;
        tau=0.1;
        alpha=0.7;
        Chi0_re=rescale_re;
        Chi0_re_off=1.5e-4;%chi_B_T(7);
        
        
  if equal==0  
        p0=[Chi0_im/rescale_im,tau,alpha,Chi0_re/rescale_re,Chi0_re_off/rescale_re];
        ChiComp=@(p3,omega)complexsusc(p3,omega);
    
        %Least-square fitting to the experimental data
        lb=[0,0,0,0,0];
        ub=[100,1e10,1,100,1];
        [p3,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp,p0,omega,[abs_B_T'/rescale_im chi_B_T'/rescale_re],lb,ub);
        
        param=[p3(1)*rescale_im,p3(2),p3(3),p3(4)*rescale_re,p3(5)*rescale_re];
        CompChi=complexsusc(param,2*pi*fcont); %Im(Chi) and Re(Chi) are fitted together
        ImChi=CompChi(:,1);
        ReChi=CompChi(:,2);
  else
        p0=[Chi0_im/rescale_im,tau,alpha,Chi0_re_off/rescale_re];
        resc=rescale_im/rescale_re;
        ChiComp=@(p3,omega)complexsusc_eq(p3,omega,resc);
    
        %Least-square fitting to the experimental data
        lb=[0,0,0,0];
        ub=[100,1e10,1,1];
        [p3,resnorm3,residual3,exitflag3,output3]  = lsqcurvefit(ChiComp,p0,omega,[abs_B_T'/rescale_im chi_B_T'/rescale_re],lb,ub);
        param=[p3(1)*rescale_im,p3(2),p3(3),p3(1)*rescale_im,p3(4)*rescale_re];
        CompChi=complexsusc(param,2*pi*fcont); %Im(Chi) and Re(Chi) are fitted together
        ImChi=CompChi(:,1);
        ReChi=CompChi(:,2);
  end
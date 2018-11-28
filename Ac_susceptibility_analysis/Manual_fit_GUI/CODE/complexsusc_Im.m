function OUTPUT = complexsusc_Im(p,omega,ratio)
tau=p(1);
alpha=p(2);
chi_0=p(3);
chi_inf_re=p(4);



    imchi=(chi_0*ratio*cos(alpha*pi/2)./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    OUTPUT=imchi;


end
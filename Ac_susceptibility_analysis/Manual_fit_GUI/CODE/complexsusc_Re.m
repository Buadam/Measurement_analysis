function OUTPUT = complexsusc_Re(p,omega)
tau=p(1);
alpha=p(2);
chi_0=p(3);
chi_inf_re=p(4);



    rechi=chi_inf_re+(chi_0*((omega*tau).^(alpha-1)+sin(alpha*pi/2))./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    OUTPUT=rechi;


end
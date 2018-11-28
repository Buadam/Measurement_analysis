function OUTPUT = complexsusc_offset(p,omega,p4)
tau=p4(1)
alpha=p4(2)
chi_0=p4(3)

chi_inf_re=p



    rechi=chi_inf_re+(chi_0*((omega*tau).^(alpha-1)+sin(alpha*pi/2))./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    OUTPUT=rechi;


end
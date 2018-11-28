function OUTPUT = complexsusc_HN(p,omega,ratio)

tau=p(1);
alpha=p(2);
beta=p(3);
chi_0=p(4);
chi_inf_re=p(5);


    chi=(1./(1+(1i*omega*tau).^(1-alpha)).^beta)';
    imchi=chi_0*imag(chi)*ratio;
    rechi=chi_inf_re+chi_0*real(chi);
    
    %phi=atan(((omega*tau).^(alpha)*sin(pi*alpha/2))./(1+((omega*tau).^alpha)*cos(pi*alpha/2)));
    %imchi=(chi_0*(1+2*(omega*tau).^alpha*cos(pi*alpha/2)+(omega*tau).^(2*alpha)).^(-beta/2).*sin(beta*phi))';
    %rechi=(chi_inf_re+chi_0*(1+2*(omega*tau).^alpha*cos(pi*alpha/2)+(omega*tau).^(2*alpha)).^(-beta/2).*cos(beta*phi))';
    
    %imchi=(chi_0*cos(alpha*pi/2)./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    %rechi=chi_inf_re+(chi_0*((omega*tau).^(alpha-1)+sin(alpha*pi/2))./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    OUTPUT=[imchi,rechi];


end

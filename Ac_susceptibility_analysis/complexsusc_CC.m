function OUTPUT = complexsusc_CC(p,omega,ratio,logtau)
if logtau==1
    tau=10^(p(1));
else
    tau=p(1);
end
alpha=p(2);
chi_0=p(3);
chi_inf_re=p(4);

    imchi=(chi_0*ratio*cos(alpha*pi/2)./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    rechi=chi_inf_re+(chi_0*((omega*tau).^(alpha-1)+sin(alpha*pi/2))./((omega*tau).^(alpha-1)+(omega*tau).^(1-alpha)+2*sin(alpha*pi/2)))';
    OUTPUT=[imchi,rechi];

end

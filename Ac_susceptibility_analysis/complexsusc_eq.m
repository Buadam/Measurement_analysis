function OUTPUT = complexsusc_eq(p,omega,resc)

tau=p(2);

if ~isempty(find(omega==0)) %if zero frequency is included in the list
    ind=find(omega);  %looking for non-zero frequencies
    
    zeroind=find(omega==0);
    omega=omega(ind);
    
    imchi(zeroind)=0;
    rechi(zeroind)=p(1)+p(4);
   

    imchi(ind)=(p(1)*cos(p(3)*pi/2)./((omega*tau).^(p(3)-1)+(omega*tau).^(1-p(3))+2*sin(p(3)*pi/2)))';
    rechi(ind)=p(4)+(p(1)*resc*((omega*tau).^(p(3)-1)+sin(p(3)*pi/2))./((omega*tau).^(p(3)-1)+(omega*tau).^(1-p(3))+2*sin(p(3)*pi/2)))';
    OUTPUT=[imchi',rechi'];
else
    imchi=(p(1)*cos(p(3)*pi/2)./((omega*tau).^(p(3)-1)+(omega*tau).^(1-p(3))+2*sin(p(3)*pi/2)))';
    rechi=p(4)+(p(1)*resc*((omega*tau).^(p(3)-1)+sin(p(3)*pi/2))./((omega*tau).^(p(3)-1)+(omega*tau).^(1-p(3))+2*sin(p(3)*pi/2)))';
    OUTPUT=[imchi,rechi];
end   
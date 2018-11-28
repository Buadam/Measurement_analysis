function [g_NH,f_max]=calc_taudistr(tauD,tau,a,beta)

alpha=1-a;

%tau distribution

ar=sin(pi*alpha)./((tauD/tau).^alpha+cos(pi*alpha));
theta=zeros(size(tauD));
for i=1:numel(tauD)
    if ar(i)>=0
        theta(i)=atan(ar(i));
    else
        theta(i)=atan(ar(i))+pi;
    end
end
g_NH=1/pi*((tauD/tau).^(alpha*beta).*sin(beta*theta))./(((tauD/tau).^(2*alpha)+2*((tauD/tau).^alpha)*cos(pi*alpha)+1).^(beta/2));
f_max=(sin((pi*alpha)/(2*(beta+1)))/(sin(pi*alpha*beta/(2*(beta+1)))))^(1/alpha)*1/tau/2/pi;

end
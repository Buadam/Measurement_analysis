function [f_out,ReChiKK]=KramersKronig1(f_in,ImChi)


f1=1e-10;
f2=1e10;

ind1=find(f_in>f1);
if isempty(ind1)
    ind1=1;
end
ind2=find(f_in>f2)-1;
if isempty(ind2)
    ind2=numel(f_in);
end
omega=2*pi*f_in(ind1:ind2)';

f_out=logspace(-5,5,100);
om=f_out*2*pi;

ReChiKK=zeros(size(om));


for i=1:length(om)
    ReChiKK(i)=2/pi*integrate_logspace(omega,omega.*ImChi(ind1:ind2)./(omega.^2-om(i)^2));
end
function [param2,err2,p_err] =  fitall(fn,params,curvesno,guess_flag)
global status_flags

%1: Gaussian: 4 params
%2: Lorentzian: 4 params


param2=zeros(curvesno,params);
err2=zeros(curvesno,params);
p_err=[];

for i=1:curvesno
    fit1d(fn,i,guess_flag);
    param2(i,:)=status_flags.fitter.function_info_1d.values;
    err2(i,:)=status_flags.fitter.function_info_1d.err_values;
end

for i=1:params
    p_err=cat(2,p_err,[param2(:,i),err2(:,i)]);
end
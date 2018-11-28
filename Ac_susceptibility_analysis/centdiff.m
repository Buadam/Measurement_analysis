function [B,dmdhc] =centdiff(data)

B=data(:,1);
dmdhc=[0;(data(3:end,2)-data(1:end-2,2))./(data(3:end,1)-data(1:end-2,1));0];


end
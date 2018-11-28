str='';
start_numor=1;
step_san=21;
san_to_phi=21/2;
step_phi=11;
end_numor=147;

for n=start_numor:2*san_to_phi:end_numor
   str=[str sprintf('%d(%d), ',n,step_san)];
end
  disp(str);
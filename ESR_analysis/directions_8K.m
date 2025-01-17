Folder_111='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_10_04_ESR_111';
Folder_110='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_09_15_ESR_110';
Folder_001='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_10_07_ESR_001\Meas';
Folder_aab='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_10_10_ESR_aab\Meas';
Folder_110_wedge='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_10_12_ESR_110_wedge\Meas';
Folder_min35='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\2016_10_14_ESR_min35_aab\Meas';

File_110='a0004.dat';
File_111='b0002.dat';
File_001='c0084.dat';
File_aab='d0042.dat';
File_110_wedge='e0004.dat';
File_aab_min35='f0004.dat';


figure(22)
hold all
box on
shift=2;


dat=dlmread(fullfile(Folder_001,File_001),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_001=plot(B,ESR_n,'Color','r');

dat=dlmread(fullfile(Folder_min35,File_aab_min35),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_aab_min35=plot(B,ESR_n+1*shift,'Color','m');

dat=dlmread(fullfile(Folder_111,File_111),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_111=plot(B,ESR_n+2*shift,'Color','k');

dat=dlmread(fullfile(Folder_110,File_110),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_110=plot(B,ESR_n+3*shift,'Color',[0.9,0.9,0.9]);

dat=dlmread(fullfile(Folder_110_wedge,File_110_wedge),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_110_wedge=plot(B,ESR_n+4*shift,'Color','b');

dat=dlmread(fullfile(Folder_aab,File_aab),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_aab=plot(B,ESR_n+5*shift,'Color','g');



legend([h_001,h_aab_min35,h_111,h_110,h_110_wedge,h_aab,],'001 (54.5�)','aab (35.5�)','111 (0�)','110 (?)' ,'110 (-35.5�)','aab (-54.5�)')
% Create textbox
annotation(figure(22),'textbox',...
    [0.136734693877553 0.451119310057521 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.138775510204083 0.237618525128165 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [001]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.419387755102046 0.360067504720003 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.37755102040817 0.446409733919375 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.387755102040824 0.471527473322831 0.0346938768211676 0.0423861844479757],...
    'String',{'0�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.389795918367349 0.80747723784402 0.0561224476111179 0.0423861844479757],...
    'String',{'[11-1]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.392857142857147 0.832594977247475 0.0530612232125536 0.0423861844479757],...
    'String',{'15.8�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.142857142857146 0.816896390120316 0.0755102021353586 0.0423861844479757],...
    'String',{'B|| [22-1]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.140816326530615 0.363207222145434 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [114]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.526530612244902 0.810616955269453 0.0561224476111178 0.0423861844479757],...
    'String',{'[1-11]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.508163265306132 0.474667190748262 0.060204080142537 0.0423861844479757],...
    'String',{'70.52�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.518367346938788 0.447979592632094 0.0357142849540224 0.0423861844479757],...
    'String',{'3x'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.535714285714302 0.85928257536365 0.0357142849540224 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.45510204081633 0.807477237844021 0.0510204069468441 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.459183673469393 0.83102511853476 0.0530612232125536 0.0423861844479757],...
    'String',{'54.5�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.5295918367347 0.834164835960191 0.0530612232125536 0.0423861844479757],...
    'String',{'78.9�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.387755102040831 0.628513344594419 0.0357142849540224 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.421428571428578 0.386755102836176 0.0571428557439727 0.0423861844479757],...
    'String',{'-35.3�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.460204081632664 0.305122449774955 0.060204080142537 0.0423861844479757],...
    'String',{'57.02�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.529591836734706 0.31454160205125 0.0530612232125536 0.0423861844479757],...
    'String',{'74.2�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.473469387755123 0.353788069869148 0.0357142849540225 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.141836734693879 0.703866562804773 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [110]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.136734693877553 0.570428572223926 0.0755102021353586 0.0423861844479757],...
    'String',{'B|| [11-2]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.40918367346939 0.626943485881696 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.41224489795919 0.655200942710586 0.0530612232125536 0.0423861844479757],...
    'String',{'35.3�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.40714285714286 0.561009419947631 0.0561224476111179 0.0423861844479757],...
    'String',{'[11-1]'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.41020408163266 0.582987441925657 0.060204080142537 0.0423861844479757],...
    'String',{'19.47�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.471428571428581 0.579847724500227 0.060204080142537 0.0423861844479757],...
    'String',{'61.87�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.483673469387766 0.571428571428572 0.0377551020408065 0.0288273155416098],...
    'String','2x',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.523469387755112 0.562009419152277 0.0438775510203994 0.0602244897959254],...
    'String',{'90�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.525510204081653 0.631653062019852 0.0357142849540224 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.524489795918369 0.649921507064365 0.0438775510204106 0.0445259026687678],...
    'String',{'90�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.487755102040825 0.253317112255329 0.0530612232125536 0.0423861844479757],...
    'String',{'54.7�'},...
    'LineStyle','none');

% Create textbox
annotation(figure(22),'textbox',...
    [0.488775510204089 0.226629514139155 0.0459183662825701 0.0423861844479757],...
    'String',{'all 4'},...
    'LineStyle','none');



figure(21)
hold all
box on
shift=2;

File_111='b0002.dat';
dat=dlmread(fullfile(Folder_111,File_111),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_111=plot(B,ESR_n+2*shift,'Color','k');

File_111='b0003.dat';
dat=dlmread(fullfile(Folder_111,File_111),',',6,0);
B=dat(:,1);
ESR=dat(:,2);
bl=(mean(dat(end-10:end,2))-mean(dat(1:10,2)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_111=plot(B,ESR_n+2*shift,'Color','r');


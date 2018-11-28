Folder='G:\Adam\Research\Skyrmion\GaMoS\Measurements\2016_07_to_10_ESR\ESR_at_8K\Kramers_Kronig_rotated';

File_110='a0004_KK.dat';
File_111='b0002_KK.dat';
File_001='c0084_KK.dat';
File_aab='d0042_KK.dat';
File_110_wedge='e0004_KK.dat';
File_aab_min35='f0004_KK.dat';


figure(22)
hold all
box on
shift=4;


dat=dlmread(fullfile(Folder,File_001),',',6,0);
B=dat(:,1);
ESR=dat(:,3);
bl=(mean(ESR(end-10:end))-mean(ESR(1:10)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_001=plot(B,ESR_n,'Color','r');

dat=dlmread(fullfile(Folder,File_aab_min35),',',6,0);
B=dat(:,1);
ESR=dat(:,3);
bl=(mean(ESR(end-10:end))-mean(ESR(1:10)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_aab_min35=plot(B,ESR_n+1*shift,'Color','m');

dat=dlmread(fullfile(Folder,File_111),',',6,0);
B=dat(:,1);
ESR=dat(:,3);
bl=(mean(ESR(end-10:end))-mean(ESR(1:10)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_111=plot(B,ESR_n+2*shift,'Color','k');

dat=dlmread(fullfile(Folder,File_110),',',6,0);
B=dat(:,1);
ESR=dat(:,3);
bl=(mean(ESR(end-10:end))-mean(ESR(1:10)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_110=plot(B,ESR_n+3*shift,'Color',[0.9,0.9,0.9]);

dat=dlmread(fullfile(Folder,File_110_wedge),',',6,0);
B=dat(:,1);
ESR=dat(:,3);
bl=(mean(ESR(end-10:end))-mean(ESR(1:10)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_110_wedge=plot(B,ESR_n+4*shift,'Color','b');

dat=dlmread(fullfile(Folder,File_aab),',',6,0);
B=dat(:,1);
ESR=dat(:,3);
bl=(mean(ESR(end-10:end))-mean(ESR(1:10)))/(B(end)-B(1))*B;
ESR_bl=ESR-bl;
ESR_n=ESR_bl/max(abs(ESR_bl));
h_aab=plot(B,ESR_n+5*shift,'Color','g');



legend([h_001,h_aab_min35,h_111,h_110,h_110_wedge,h_aab,],'001 (54.5�)','aab (35.5�)','111 (0�)','110 (?)' ,'110 (-35.5�)','aab (-54.5�)')


% Create textbox
annotation(figure(22),'textbox',...
    [0.136734693877553 0.451119310057521 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [111]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.138775510204083 0.237618525128165 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [001]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.142857142857146 0.816896390120316 0.0755102021353586 0.0423861844479757],...
    'String',{'B|| [22-1]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.140816326530615 0.363207222145434 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [114]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.141836734693879 0.703866562804773 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [110]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.136734693877553 0.570428572223926 0.0755102021353586 0.0423861844479757],...
    'String',{'B|| [11-2]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.487755102040825 0.253317112255329 0.0530612232125536 0.0423861844479757],...
    'String',{'54.7�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.488775510204089 0.226629514139155 0.0459183662825701 0.0423861844479757],...
    'String',{'all 4'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.492002206287926 0.874156108950095 0.0530612232125538 0.0423861844479758],...
    'String',{'54.5�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.489851075565365 0.850608228259356 0.0510204069468441 0.0423861844479759],...
    'String',{'[111]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.416988416988421 0.87093363539444 0.0530612232125536 0.0423861844479758],...
    'String',{'15.8�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.415857694429125 0.849010784169899 0.0561224476111179 0.0423861844479756],...
    'String',{'[11-1]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.586210700496426 0.581178748225758 0.0438775510203994 0.0602244897959254],...
    'String',{'90�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.494953116381699 0.405761427410737 0.0602040801425369 0.0423861844479757],...
    'String',{'57.02�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.447490347490354 0.407521875999115 0.0571428557439727 0.0423861844479758],...
    'String',{'-35.3�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.542140099282963 0.874100938196613 0.0530612232125536 0.0423861844479758],...
    'String',{'78.9�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.539078874793165 0.852150501595331 0.0561224476111178 0.0423861844479759],...
    'String',{'[1-11]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.539078874793165 0.826591396164021 0.0561224476111178 0.0423861844479759],...
    'String','[-111]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.459376723662441 0.721192687159648 0.0510204069468443 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.462437948152241 0.746255255809626 0.0530612232125539 0.0423861844479757],...
    'String',{'35.3�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.45841147269719 0.700425913996709 0.0510204069468443 0.0423861844479757],...
    'String','[11-1]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.58530060672918 0.747365596521232 0.0438775510204106 0.0445259026687678],...
    'String',{'90�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.570380584666302 0.722790131249104 0.0510204069468444 0.0423861844479757],...
    'String','[-111]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.570380584666302 0.697231025817793 0.0510204069468444 0.0423861844479757],...
    'String','[1-11]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.415030336458916 0.642092873235559 0.060204080142537 0.0423861844479757],...
    'String',{'19.47�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.492664092664103 0.63895315581013 0.0602040801425371 0.0423861844479757],...
    'String',{'61.87�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.41583011583012 0.618517407168076 0.0561224476111179 0.0423861844479757],...
    'String',{'[11-1]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.576061776061781 0.578581304931653 0.0561224476111177 0.0423861844479757],...
    'String','[111]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.488223938223943 0.615322518989162 0.0561224476111178 0.0423861844479757],...
    'String','[-111]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.488223938223943 0.589763413557852 0.0561224476111178 0.0423861844479757],...
    'String','[1-11]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.407060121345844 0.537022680990562 0.0346938768211676 0.0423861844479757],...
    'String',{'0�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.39685603971319 0.507112609318736 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.496580253723121 0.533772622058165 0.060204080142537 0.0423861844479757],...
    'String',{'70.52�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.447380033094324 0.385626610151312 0.051020406946844 0.0423861844479758],...
    'String',{'[111]'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.510755653612805 0.511904941587105 0.0510204069468441 0.0423861844479757],...
    'String','[-111]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.492415885273037 0.382511970341098 0.051020406946844 0.0423861844479757],...
    'String','[-111]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.490485383342535 0.360147753088701 0.051020406946844 0.0423861844479757],...
    'String','[1-11]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.545035852178722 0.37524447745061 0.0530612232125536 0.0423861844479757],...
    'String',{'74.2�'},...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.508825151682304 0.491138168424165 0.0510204069468441 0.0423861844479757],...
    'String','[1-11]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.507859900717054 0.471968839350682 0.0510204069468441 0.0423861844479757],...
    'String','[11-1]',...
    'LineStyle','none',...
    'FitBoxToText','off');

% Create textbox
annotation(figure(22),'textbox',...
    [0.540678433535587 0.353757976730873 0.0510204069468441 0.0423861844479757],...
    'String','[11-1]',...
    'LineStyle','none',...
    'FitBoxToText','off');

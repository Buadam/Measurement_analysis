function createfigure(X1, YMatrix1, Y1)
%CREATEFIGURE(X1, YMATRIX1, Y1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
%  Y1:  vector of y data

%  Auto-generated by MATLAB on 14-Oct-2016 14:40:50

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
box(axes1,'on');
hold(axes1,'on');

% Create plot
plot1(1) = plot(X1,Y1,'DisplayName','001 (54.5�)','Color',[1 0 0]);

% Create multiple lines using matrix input to plot
plot1 = plot(X1,YMatrix1,'Parent',axes1);
set(plot1(1),'DisplayName','001 (54.5�)','Color',[1 0 0]);
set(plot1(2),'DisplayName','aab (35.5�)','Color',[1 0 1]);
set(plot1(3),'DisplayName','111 (0�)','Color',[0 0 0]);
set(plot1(4),'DisplayName','110 (?)','Color',[0.9 0.9 0.9]);
set(plot1(5),'DisplayName','110 (-35.5�)','Color',[0 0 1]);
set(plot1(6),'DisplayName','aab (-54.5�)','Color',[0 1 0]);
set(plot1(2),'DisplayName','aab (35.5�)','Color',[1 0 1]);
set(plot1(8),'DisplayName','111 (0�)','Color',[0 0 0]);
set(plot1(9),'DisplayName','110 (?)','Color',[0.9 0.9 0.9]);
set(plot1(10),'DisplayName','110 (-35.5�)','Color',[0 0 1]);
set(plot1(6),'DisplayName','aab (-54.5�)','Color',[0 1 0]);

% Create legend
legend(axes1,'show');

% Create textbox
annotation(figure1,'textbox',...
    [0.488775510204089 0.226629514139155 0.0459183662825701 0.0423861844479757],...
    'String',{'all 4'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.141836734693879 0.703866562804773 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [110]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.136734693877553 0.451119310057521 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.138775510204083 0.237618525128165 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [001]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.419387755102046 0.360067504720003 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.40918367346939 0.626943485881696 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.37755102040817 0.446409733919375 0.051020406946844 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.487755102040825 0.253317112255329 0.0530612232125536 0.0423861844479757],...
    'String',{'54.7�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.421428571428578 0.386755102836176 0.0571428557439727 0.0423861844479757],...
    'String',{'-35.3�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.387755102040824 0.471527473322831 0.0346938768211676 0.0423861844479757],...
    'String',{'0�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.389795918367349 0.80747723784402 0.0561224476111179 0.0423861844479757],...
    'String',{'[11-1]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.392857142857147 0.832594977247475 0.0530612232125536 0.0423861844479757],...
    'String',{'15.8�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.142857142857146 0.816896390120316 0.0755102021353586 0.0423861844479757],...
    'String',{'B|| [22-1]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.140816326530615 0.363207222145434 0.0704081614710847 0.0423861844479757],...
    'String',{'B|| [114]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.526530612244902 0.810616955269453 0.0561224476111178 0.0423861844479757],...
    'String',{'[1-11]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.508163265306132 0.474667190748262 0.060204080142537 0.0423861844479757],...
    'String',{'70.52�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.518367346938788 0.447979592632094 0.0357142849540224 0.0423861844479757],...
    'String',{'3x'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.41224489795919 0.655200942710586 0.0530612232125536 0.0423861844479757],...
    'String',{'35.3�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.535714285714302 0.85928257536365 0.0357142849540224 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.45510204081633 0.807477237844021 0.0510204069468441 0.0423861844479757],...
    'String',{'[111]'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.459183673469393 0.83102511853476 0.0530612232125536 0.0423861844479757],...
    'String',{'54.5�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.5295918367347 0.834164835960191 0.0530612232125536 0.0423861844479757],...
    'String',{'78.9�'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.387755102040831 0.628513344594419 0.0357142849540224 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.483673469387771 0.617524333605408 0.0357142849540224 0.0423861844479757],...
    'String',{'2x'},...
    'LineStyle','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.49081632653062 0.627943485086342 0.0479591836734618 0.0539450549450612],...
    'String',{'90�'},...
    'LineStyle','none',...
    'FitBoxToText','off');


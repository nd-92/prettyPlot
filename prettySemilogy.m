function prettySemilogy(varargin)

% Set latex interpreter
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');

% Check if symbolic toolbox is installed
symtoggle=license('test', 'symbolic_toolbox');

% Set default input parameters and parse
p=inputParser;
addParameter(p,'AxLabelOffset',0.75);
addParameter(p,'BoxMarginScale',0.1);
addParameter(p,'FontSize',10);
addParameter(p,'LineWidth',0.5);
addParameter(p,'TickNumberFormat','Decimal');
addParameter(p,'NXTicks',11);
addParameter(p,'NYTicks',11);
addParameter(p,'PaperMarginPoints',90);
addParameter(p,'PaperPoints',595);
addParameter(p,'PlotAspectRatio',1);
addParameter(p,'Title',strings(1));
addParameter(p,'UseXTickFractions',false);
addParameter(p,'UseXScientificNotation',false);
addParameter(p,'XLabel',strings(1));
addParameter(p,'XLim',[-5 5]);
addParameter(p,'XTickFormat',3);
addParameter(p,'YLabel',strings(1));
addParameter(p,'YLim',[1e-5 1e5]);
parse(p,varargin{:});
AxLabelOffset=p.Results.AxLabelOffset;
BoxMarginScale=p.Results.BoxMarginScale;
FontSize=p.Results.FontSize;
LineWidth=p.Results.LineWidth;
NXTicks=p.Results.NXTicks;
NYTicks=p.Results.NYTicks;
PaperMarginPoints=p.Results.PaperMarginPoints;
PaperPoints=p.Results.PaperPoints;
PlotAspectRatio=p.Results.PlotAspectRatio;
TitleString=p.Results.Title;
UseXTickFractions=p.Results.UseXTickFractions;
UseXScientificNotation=p.Results.UseXScientificNotation;
XLabelString=p.Results.XLabel;
XMax=p.Results.XLim(2);
XMin=p.Results.XLim(1);
XTickFormat=p.Results.XTickFormat;
YLabelString=p.Results.YLabel;
YMax=p.Results.YLim(2);
YMin=p.Results.YLim(1);

% Set figure and axis dimensions
xfigwidth=PaperPoints-(2*PaperMarginPoints);
boxmarginwidth=BoxMarginScale*xfigwidth;
xaxiswidth=xfigwidth-(2*boxmarginwidth);
yaxiswidth=double(xaxiswidth/PlotAspectRatio);
yfigwidth=yaxiswidth+(2*boxmarginwidth);

% Create x ticks and labels
if symtoggle==1
    XTicks=simplify(linspace(sym(XMin),sym(XMax),NXTicks),'Steps',100);
    XTickLabels=strings(1,NXTicks);
    if UseXTickFractions==false
        if UseXScientificNotation==false
            for a=1:NXTicks
                XTickLabels(a)=strcat('$',num2str(double(simplify(XTicks(a),'Steps',100)),XTickFormat),'$');
            end
        else
        end
        if UseXScientificNotation==true
            XExponent=double(floor(log10(XTicks(end))));
            XExponentLabel=strcat('$\times 10^{',num2str(XExponent,'%0.0f'),'}$');
            for a=1:NXTicks
                XTickLabels(a)=strcat('$',num2str(double(simplify(XTicks(a)/(sym(10)^XExponent),'Steps',100)),XTickFormat),'$');
            end
        else
        end
    else
    end
    if UseXTickFractions==true
        for a=1:NXTicks
            XTickLabels(a)=strcat('$',latex(simplify(XTicks(a),'Steps',100)),'$');
        end
    else
    end
else
end

% Create y ticks and labels
if symtoggle==1
    YOrders=floor(linspace(log10(sym(YMin)),log10(sym(YMax)),NYTicks));
    YTicks=sym(10).^YOrders;
    YTickLabels=strings(1,NYTicks);
    for a=1:NYTicks
        YTickLabels(a)=strcat('$10^{',num2str(double(YOrders(a))),'}$');
    end
else
    YOrders=floor(linspace(log10(YMin),log10(YMax),NYTicks));
    YTicks=sym(10).^YOrders;
    YTickLabels=strings(1,NYTicks);
    for a=1:NYTicks
        YTickLabels(a)=strcat('$10^{',num2str(double(YOrders(a))),'}$');
    end
end

% Set figure properties
fig=figure;
axis off;
set(fig,'Units','points');
set(fig,'Color',[1 1 1]);
set(fig,'InnerPosition',[boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth]);
set(fig,'Position',[0 0 xfigwidth yfigwidth]);
set(fig,'Renderer','painter');

% Create axes
ax=gca;
axis on;
hold on;
ax.Units='points';
ax.PositionConstraint='innerposition';
ax.Box='off';
ax.BoxStyle='back';
ax.CLim=[0 1];
ax.Color=[1 1 1];
ax.FontName='Times';
ax.FontSize=FontSize;
ax.FontUnits='points';
ax.GridColor=[0 0 0];
ax.LabelFontSizeMultiplier=1;
ax.LineWidth=LineWidth;
ax.MinorGridColor=[0 0 0];
ax.PlotBoxAspectRatio=[PlotAspectRatio 1 1];
ax.Position=[boxmarginwidth boxmarginwidth xaxiswidth yaxiswidth];
ax.TickLabelInterpreter='latex';
ax.TickLength=[0 0];
ax.View=[0 90];

% Create title
ax.Title.Units='points';
ax.Title.Color=[0 0 0];
ax.Title.FontName='Times';
ax.Title.FontSize=FontSize;
ax.Title.FontUnits='points';
ax.Title.HorizontalAlignment='center';
ax.Title.Interpreter='latex';
ax.Title.LineWidth=LineWidth;
ax.Title.Position=[xaxiswidth/2 yaxiswidth+(0.5*boxmarginwidth) 0];
ax.Title.String=TitleString;
ax.Title.VerticalAlignment='middle';
ax.Title.Visible='on';
ax.TitleFontSizeMultiplier=1;

% Create x axis
ax.XAxis.Color=[0 0 0];
ax.XAxis.FontName='Times';
ax.XAxis.FontSize=FontSize;
ax.XAxis.HandleVisibility='off';
ax.XAxis.Label.Color=[0 0 0];
ax.XAxis.Label.FontName='Times';
ax.XAxis.Label.FontSize=FontSize;
ax.XAxis.Label.FontUnits='points';
ax.XAxis.Label.HandleVisibility='off';
ax.XAxis.Label.HorizontalAlignment='center';
ax.XAxis.Label.Interpreter='latex';
ax.XAxis.Label.LineWidth=LineWidth;
ax.XAxis.Label.Units='points';
ax.XAxis.Label.Position=[xaxiswidth/2 -boxmarginwidth*AxLabelOffset 0];
ax.XAxis.Label.String=XLabelString;
ax.XAxis.Label.VerticalAlignment='middle';
ax.XAxis.Label.Visible='on';
ax.XAxis.Limits=[double(XMin) double(XMax)];
ax.XAxis.LineWidth=LineWidth;
ax.XAxis.TickLabelInterpreter='latex';
ax.XAxis.TickLabels=XTickLabels;
ax.XAxis.TickLength=[0 0];
ax.XAxis.TickValues=double(XTicks);
ax.XAxis.Visible='on';
ax.XColor=[0 0 0];
ax.XGrid='on';
ax.XLabel.BackgroundColor=[1 1 1];
ax.XLabel.Color=[0 0 0];
ax.XLabel.FontName='Times';
ax.XLabel.FontSize=FontSize;
ax.XLabel.FontUnits='points';
ax.XLabel.HandleVisibility='off';
ax.XLabel.HorizontalAlignment='center';
ax.XLabel.Interpreter='latex';
ax.XLabel.LineWidth=LineWidth;
ax.XLabel.Units='points';
ax.XLabel.Position=[xaxiswidth/2 -boxmarginwidth*AxLabelOffset 0];
ax.XLabel.String=XLabelString;
ax.XLabel.VerticalAlignment='middle';
ax.XLabel.Visible='on';
ax.XLim=[double(XMin) double(XMax)];
ax.XTick=double(XTicks);
ax.XTickLabel=XTickLabels;

% Create y axis
ax.YAxis.Color=[0 0 0];
ax.YAxis.FontName='Times';
ax.YAxis.FontSize=FontSize;
ax.YAxis.HandleVisibility='off';
ax.YAxis.Label.Color=[0 0 0];
ax.YAxis.Label.FontName='Times';
ax.YAxis.Label.FontSize=FontSize;
ax.YAxis.Label.FontUnits='points';
ax.YAxis.Label.HandleVisibility='off';
ax.YAxis.Label.HorizontalAlignment='center';
ax.YAxis.Label.Interpreter='latex';
ax.YAxis.Label.LineWidth=LineWidth;
ax.YAxis.Label.Units='points';
ax.YAxis.Label.Position=[-boxmarginwidth*AxLabelOffset yaxiswidth/2 0];
ax.YAxis.Label.String=YLabelString;
ax.YAxis.Label.VerticalAlignment='middle';
ax.YAxis.Label.Visible='on';
ax.YAxis.Limits=[double(YMin) double(YMax)];
ax.YAxis.LineWidth=LineWidth;
ax.YAxis.Scale='log';
ax.YAxis.TickLabelInterpreter='latex';
ax.YAxis.TickLabels=YTickLabels;
ax.YAxis.TickLength=[0 0];
ax.YAxis.TickValues=double(YTicks);
ax.YAxis.Visible='on';
ax.YColor=[0 0 0];
ax.YGrid='on';
ax.YLabel.BackgroundColor=[1 1 1];
ax.YLabel.Color=[0 0 0];
ax.YLabel.FontName='Times';
ax.YLabel.FontSize=FontSize;
ax.YLabel.FontUnits='points';
ax.YLabel.HandleVisibility='off';
ax.YLabel.HorizontalAlignment='center';
ax.YLabel.Interpreter='latex';
ax.YLabel.LineWidth=LineWidth;
ax.YLabel.Units='points';
ax.YLabel.Position=[-boxmarginwidth*AxLabelOffset yaxiswidth/2 0];
ax.YLabel.String=YLabelString;
ax.YLabel.VerticalAlignment='middle';
ax.YLabel.Visible='on';
ax.YLim=[double(YMin) double(YMax)];
ax.YScale='log';
ax.YTick=double(YTicks);
ax.YTickLabel=YTickLabels;

% Create z axis
ax.ZAxis.Color=[0 0 0];
ax.ZAxis.FontName='Times';
ax.ZAxis.FontSize=FontSize;
ax.ZAxis.HandleVisibility='off';
ax.ZAxis.Label=[];
ax.ZAxis.Limits=[0 1];
ax.ZAxis.LineWidth=LineWidth;
ax.ZAxis.TickLabelInterpreter='latex';
ax.ZAxis.TickLabels='';
ax.ZAxis.TickLength=[0 0];
ax.ZAxis.TickValues=[];
ax.ZAxis.Visible='off';
ax.ZColor=[0 0 0];
ax.ZGrid='off';
ax.ZLabel.BackgroundColor=[1 1 1];
ax.ZLabel.Color=[0 0 0];
ax.ZLabel.FontName='Times';
ax.ZLabel.FontSize=FontSize;
ax.ZLabel.FontUnits='points';
ax.ZLabel.HandleVisibility='off';
ax.ZLabel.HorizontalAlignment='center';
ax.ZLabel.Interpreter='latex';
ax.ZLabel.LineWidth=LineWidth;
ax.ZLabel.Position=[0.5 -0.1 0];
ax.ZLabel.String='';
ax.ZLabel.Units='data';
ax.ZLabel.VerticalAlignment='middle';
ax.ZLabel.Visible='off';
ax.ZLim=[0 1];
ax.ZTick=[];
ax.ZTickLabel='';

% Create border
if UseBorder==true
    line([double(XMin) double(XMax) double(XMax) double(XMin) double(XMin)],...
        [double(YMin) double(YMin) double(YMax) double(YMax) double(YMin)],...
        [1 1 1 1 1],...
        'Color',[0 0 0],...
        'HandleVisibility','off',...
        'LineStyle','-',...
        'LineWidth',LineWidth);
else
end

% Write x axis exponent label
if exist('XExponentLabel','var')
    XExponentText=text(0,0,XExponentLabel);
    XExponentText.Units='Points';
    XExponentText.BackgroundColor=[1 1 1];
    XExponentText.Color=[0 0 0];
    XExponentText.FontName='Times';
    XExponentText.FontSize=FontSize;
    XExponentText.FontUnits='Points';
    XExponentText.HandleVisibility='Off';
    XExponentText.HorizontalAlignment='Right';
    XExponentText.Interpreter='Latex';
    XExponentText.LineStyle='-';
    XExponentText.LineWidth=LineWidth;
    XExponentText.Position=[xaxiswidth -2.5*FontSize 0];
    XExponentText.String=XExponentLabel;
    XExponentText.VerticalAlignment='Middle';
else
end

% Write y axis exponent label
if exist('YExponentLabel','var')
    YExponentText=text(0,0,YExponentLabel);
    YExponentText.Units='Points';
    YExponentText.BackgroundColor=[1 1 1];
    YExponentText.Color=[0 0 0];
    YExponentText.FontName='Times';
    YExponentText.FontSize=FontSize;
    YExponentText.FontUnits='Points';
    YExponentText.HandleVisibility='Off';
    YExponentText.HorizontalAlignment='Left';
    YExponentText.Interpreter='Latex';
    YExponentText.LineStyle='-';
    YExponentText.LineWidth=LineWidth;
    YExponentText.Position=[0.5*FontSize yaxiswidth+(0.5*FontSize) 0];
    YExponentText.String=YExponentLabel;
    YExponentText.VerticalAlignment='Bottom';
else
end

end
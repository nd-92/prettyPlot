function [fig, ax] = pretty2d(varargin)

% Check if symbolic toolbox is installed
symtoggle = cast(license('test', 'symbolic_toolbox'), 'logical');

% Get information on screen size
set(0, 'Units', 'Points');
ResPoints = get(0, 'Screensize');
if symtoggle == true
    ResPoints = simplify(sym(ResPoints), 'Steps', 100);
else
end

% Create parser
p = inputParser;

% Scale
addParameter(p, 'TextWidthScale', 1);

% Interpreter parameters
addParameter(p, 'Interpreter', 'latex');

% Font parameters
addParameter(p, 'FontName', 'Times');
addParameter(p, 'FontSize', cast(10, 'uint64'));
addParameter(p, 'TitleFontWeight', 'Bold');
addParameter(p, 'LabelFontWeight', 'Normal');
addParameter(p, 'AxisFontWeight', 'Normal');

% Plot box parameters
addParameter(p, 'AxLabelOffset', 0.75);
addParameter(p, 'BoxMarginScale', 0.1);
addParameter(p, 'CBarWidthScale', 0.02);
addParameter(p, 'CBarLabelOffset', 0.75);
addParameter(p, 'DataAspectRatio', []);
addParameter(p, 'PaperMarginPoints', cast(cast(90, 'uint64'), 'double');
addParameter(p, 'PaperPoints', cast(cast(595, 'uint64'), 'double'));
addParameter(p, 'PlotAspectRatio', [1, 1, 1]);

% Axes parameters
addParameter(p, 'CAxis', [-5, 5]);
addParameter(p, 'NCBarTicks', 11);
addParameter(p, 'NXTicks', 11);
addParameter(p, 'NYTicks', 11);
addParameter(p, 'UseColorBar', false);
addParameter(p, 'UseCBarTickFractions', false);
addParameter(p, 'UseCBarScientificNotation', false);
addParameter(p, 'UseXAxis', true);
addParameter(p, 'UseXTickFractions', false);
addParameter(p, 'UseXScientificNotation', false);
addParameter(p, 'UseYAxis', true);
addParameter(p, 'UseYTickFractions', false);
addParameter(p, 'UseYScientificNotation', false);
addParameter(p, 'XLim', [-5, 5]);
addParameter(p, 'YLim', [-5, 5]);
addParameter(p, 'XTicks', []);
addParameter(p, 'YTicks', []);
addParameter(p, 'CBarTicks', []);

% Label parameters
addParameter(p, 'CBarLabel', strings(1));
addParameter(p, 'CBarTickFormat', 5);
addParameter(p, 'Title', strings(1));
addParameter(p, 'XLabel', strings(1));
addParameter(p, 'YLabel', strings(1));
addParameter(p, 'XTickFormat', 5);
addParameter(p, 'YTickFormat', 5);
addParameter(p, 'XTickLabels', []);
addParameter(p, 'YTickLabels', []);
addParameter(p, 'CBarTickLabels', []);

% Aesthetic parameters
addParameter(p, 'LineWidth', 0.5);
addParameter(p, 'UseBorder', true);
addParameter(p, 'UseGrid', false);
addParameter(p, 'UseMinorTick', false);

% Parse
parse(p, varargin{:});

TextWidthScale = p.Results.TextWidthScale;

% Parsed interpreter parameters
Interpreter = p.Results.Interpreter;

% Parsed font parameters
FontName = p.Results.FontName;
FontSize = p.Results.FontSize;
TitleFontWeight = p.Results.TitleFontWeight;
LabelFontWeight = p.Results.LabelFontWeight;
AxisFontWeight = p.Results.AxisFontWeight;

% Parsed plot box parameters
AxLabelOffset = p.Results.AxLabelOffset;
BoxMarginScale = p.Results.BoxMarginScale;
CBarWidthScale = p.Results.CBarWidthScale;
CBarLabelOffset = p.Results.CBarLabelOffset;
DataAspectRatio = p.Results.DataAspectRatio;
PaperMarginPoints = p.Results.PaperMarginPoints;
PaperPoints = p.Results.PaperPoints;
PlotAspectRatio = p.Results.PlotAspectRatio;

% Parsed axes parameters
CBarMax = p.Results.CAxis(2);
CBarMin = p.Results.CAxis(1);
NCBarTicks = p.Results.NCBarTicks;
NXTicks = p.Results.NXTicks;
NYTicks = p.Results.NYTicks;
UseColorBar = p.Results.UseColorBar;
UseCBarTickFractions = p.Results.UseCBarTickFractions;
UseCBarScientificNotation = p.Results.UseCBarScientificNotation;
UseXAxis = p.Results.UseXAxis;
UseXTickFractions = p.Results.UseXTickFractions;
UseXScientificNotation = p.Results.UseXScientificNotation;
UseYAxis = p.Results.UseYAxis;
UseYTickFractions = p.Results.UseYTickFractions;
UseYScientificNotation = p.Results.UseYScientificNotation;
XMax = p.Results.XLim(2);
XMin = p.Results.XLim(1);
YMax = p.Results.YLim(2);
YMin = p.Results.YLim(1);
XTicks = p.Results.XTicks;
YTicks = p.Results.YTicks;
CBarTicks = p.Results.CBarTicks;

% Parsed label parameters
CBarLabelString = p.Results.CBarLabel;
CBarTickFormat = p.Results.CBarTickFormat;
TitleString = p.Results.Title;
XTickFormat = p.Results.XTickFormat;
XLabelString = p.Results.XLabel;
YTickFormat = p.Results.YTickFormat;
YLabelString = p.Results.YLabel;
XTickLabels = p.Results.XTickLabels;
YTickLabels = p.Results.YTickLabels;
CBarTickLabels = p.Results.CBarTickLabels;

% Parsed aesthetic parameters
LineWidth = p.Results.LineWidth;
UseBorder = p.Results.UseBorder;
UseGrid = p.Results.UseGrid;
UseMinorTick = p.Results.UseMinorTick;

% Set figure and axis dimensions
if symtoggle == 1
    AxLabelOffset = simplify(sym(AxLabelOffset), 'Steps', 100);
    CBarWidthScale = simplify(sym(CBarWidthScale), 'Steps', 100);
    CBarLabelOffset = simplify(sym(CBarLabelOffset), 'Steps', 100);
    BoxMarginScale = simplify(sym(BoxMarginScale), 'Steps', 100);
    DataAspectRatio = simplify(sym(DataAspectRatio), 'Steps', 100);
    PaperMarginPoints = simplify(sym(PaperMarginPoints), 'Steps', 100);
    PaperPoints = simplify(sym(PaperPoints), 'Steps', 100);
    PlotAspectRatio = simplify(sym(PlotAspectRatio), 'Steps', 100);
    CBarMax = simplify(sym(CBarMax), 'Steps', 100);
    CBarMin = simplify(sym(CBarMin), 'Steps', 100);
    NCBarTicks = simplify(sym(NCBarTicks), 'Steps', 100);
    NXTicks = simplify(sym(NXTicks), 'Steps', 100);
    NYTicks = simplify(sym(NYTicks), 'Steps', 100);
    XMax = simplify(sym(XMax), 'Steps', 100);
    XMin = simplify(sym(XMin), 'Steps', 100);
    YMax = simplify(sym(YMax), 'Steps', 100);
    YMin = simplify(sym(YMin), 'Steps', 100);
    if isempty(DataAspectRatio)
        DataAspectRatioToggle = false;
    else
        DataAspectRatioToggle = true;
    end
    if DataAspectRatioToggle == true
        BoxAspectRatio = (XMax - XMin) / (YMax - YMin);
    else
        BoxAspectRatio = PlotAspectRatio(1) / PlotAspectRatio(2);
    end
    XFigWidth = simplify((PaperPoints - (sym(2) * PaperMarginPoints)) * TextWidthScale, 'Steps', 100);
    BoxMarginWidth = simplify((BoxMarginScale * XFigWidth) / TextWidthScale, 'Steps', 100);
    XAxisWidth = simplify(XFigWidth - (sym(2) * BoxMarginWidth), 'Steps', 100);
    YAxisWidth = simplify(XAxisWidth / BoxAspectRatio, 'Steps', 100);
    YFigWidth = simplify(YAxisWidth + (sym(2) * BoxMarginWidth), 'Steps', 100);
    FigInnerPosition = simplify([BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth], 'Steps', 100);
    AxisPosition = simplify([BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth], 'Steps', 100);
    TitlePosition = simplify([XAxisWidth / sym(2) YAxisWidth + (sym(0.5) * BoxMarginWidth) sym(0)], 'Steps', 100);
    CBarPosition = simplify([BoxMarginWidth + XAxisWidth + (sym(0.0025) * PaperPoints) BoxMarginWidth CBarWidthScale * PaperPoints YAxisWidth], 'Steps', 100);
    CBarLabelPosition = simplify([(CBarLabelOffset * BoxMarginWidth) YAxisWidth / sym(2) sym(0)], 'Steps', 100);
    XLabelPosition = simplify([XAxisWidth / sym(2) -BoxMarginWidth * AxLabelOffset sym(0)], 'Steps', 100);
    YLabelPosition = simplify([-BoxMarginWidth * AxLabelOffset YAxisWidth / sym(2) sym(0)], 'Steps', 100);
    XExponentPosition = simplify([XAxisWidth -sym(2.5) * sym(FontSize) sym(0)], 'Steps', 100);
    YExponentPosition = simplify([sym(0.5) * sym(FontSize) YAxisWidth + (sym(0.5) * sym(FontSize)) sym(0)], 'Steps', 100);
    FigXOrigin = simplify((ResPoints(3) / sym(2)) - (XFigWidth / sym(2)), 'Steps', 100);
    FigYOrigin = simplify((ResPoints(4) / sym(2)) - (YFigWidth / sym(2)), 'Steps', 100);
    FigPosition = simplify([FigXOrigin FigYOrigin XFigWidth YFigWidth], 'Steps', 100);
    CBarExponentPosition = simplify([XAxisWidth + (sym(0.25) * BoxMarginWidth) YAxisWidth + (sym(0.5) * FontSize) sym(0)], 'Steps', 100);
else
    if isempty(DataAspectRatio)
        DataAspectRatioToggle = false;
    else
        DataAspectRatioToggle = true;
    end
    if DataAspectRatioToggle == true
        BoxAspectRatio = (XMax - XMin) / (YMax - YMin);
    else
        BoxAspectRatio = PlotAspectRatio(1) / PlotAspectRatio(2);
    end
    XFigWidth = (PaperPoints - (sym(2) * PaperMarginPoints)) * TextWidthScale;
    BoxMarginWidth = BoxMarginScale * XFigWidth;
    XAxisWidth = XFigWidth - (2 * BoxMarginWidth);
    YAxisWidth = XAxisWidth / BoxAspectRatio;
    YFigWidth = YAxisWidth + (2 * BoxMarginWidth);
    FigInnerPosition = [BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth];
    AxisPosition = [BoxMarginWidth BoxMarginWidth XAxisWidth YAxisWidth];
    TitlePosition = [XAxisWidth / 2 YAxisWidth + (0.5 * BoxMarginWidth) 0];
    CBarPosition = [BoxMarginWidth + XAxisWidth + (0.025 * PaperPoints) BoxMarginWidth CBarWidthScale * PaperPoints YAxisWidth];
    CBarLabelPosition = [(CBarLabelOffset * BoxMarginWidth) YAxisWidth / 2 0];
    XLabelPosition = [XAxisWidth / 2 -BoxMarginWidth * AxLabelOffset 0];
    YLabelPosition = [-BoxMarginWidth * AxLabelOffset YAxisWidth / 2 0];
    XExponentPosition = [XAxisWidth -2.5 * FontSize 0];
    YExponentPosition = [0.5 * FontSize YAxisWidth + (0.5 * FontSize) 0];
    FigXOrigin = (ResPoints(3) / 2) - (XFigWidth / 2);
    FigYOrigin = (ResPoints(4) / 2) - (YFigWidth / 2);
    FigPosition = [FigXOrigin FigYOrigin XFigWidth YFigWidth];
    CBarExponentPosition = [XAxisWidth + (0.25 * BoxMarginWidth) YAxisWidth + (0.5 * FontSize) 0];
end

% Create ticks and labels
LatexToggle = strcmp(Interpreter, 'latex');
if isempty(XTickLabels)
    [XTicks, XTickLabels, XExponentLabel] = createTicksAndLabels(XMin, XMax, double(NXTicks), XTickFormat, LatexToggle, UseXTickFractions, UseXScientificNotation);
else
    [XTicks, ~, XExponentLabel] = createTicksAndLabels(XMin, XMax, length(XTickLabels), XTickFormat, LatexToggle, UseXTickFractions, UseXScientificNotation);
end
if isempty(YTickLabels)
    [YTicks, YTickLabels, YExponentLabel] = createTicksAndLabels(YMin, YMax, double(NYTicks), YTickFormat, LatexToggle, UseYTickFractions, UseYScientificNotation);
else
    [YTicks, ~, YExponentLabel] = createTicksAndLabels(YMin, YMax, length(YTickLabels), YTickFormat, LatexToggle, UseYTickFractions, UseYScientificNotation);
end
if isempty(CBarTickLabels)
    [CBarTicks, CBarTickLabels, CBarExponentLabel] = createTicksAndLabels(CBarMin, CBarMax, double(NCBarTicks), CBarTickFormat, LatexToggle, UseCBarTickFractions, UseCBarScientificNotation);
else
    [CBarTicks, ~, CBarExponentLabel] = createTicksAndLabels(CBarMin, CBarMax, length(CBarTickLabels), CBarTickFormat, LatexToggle, UseCBarTickFractions, UseCBarScientificNotation);
end

% Set figure properties
fig = figure;
set(fig, 'Units', 'points');
set(fig, 'Color', [1 1 1]);
set(fig, 'InnerPosition', double(FigInnerPosition));
set(fig, 'Position', double(FigPosition));
set(fig, 'Renderer', 'painter');

% Create axes
ax = gca;
axis on;
hold on;
ax.Units = 'points';
ax.PositionConstraint = 'innerposition';
if UseBorder == true
    ax.Box = 'on';
else
    ax.Box = 'off';
end
ax.BoxStyle = 'back';
ax.CLim = double([CBarMin CBarMax]);
ax.Color = [1 1 1];
if DataAspectRatioToggle == true
    ax.DataAspectRatio = double(DataAspectRatio);
else
end
ax.FontName = FontName;
ax.FontSize = double(FontSize);
ax.FontUnits = 'points';
ax.FontWeight = AxisFontWeight;
ax.GridColor = [0 0 0];
ax.LabelFontSizeMultiplier = 1;
ax.LineWidth = LineWidth;
ax.MinorGridColor = [0 0 0];
if DataAspectRatioToggle == false
    ax.PlotBoxAspectRatio = double(PlotAspectRatio);
else
end
ax.Position = double(AxisPosition);
ax.TickLabelInterpreter = Interpreter;
ax.TitleFontWeight = TitleFontWeight;
ax.View = [0 90];

% Create colorbar
if UseColorBar == true
    C = colorbar;
    C.Units = 'points';
    C.Color = [0 0 0];
    C.FontName = 'Times';
    C.FontSize = double(FontSize);
    C.Label.Units = 'points';
    C.Label.Color = [0 0 0];
    C.Label.FontName = FontName;
    C.Label.FontSize = double(FontSize);
    C.Label.FontUnits = 'points';
    C.Label.HorizontalAlignment = 'Center';
    C.Label.Interpreter = Interpreter;
    C.Label.Position = double(CBarLabelPosition);
    C.Label.String = CBarLabelString;
    C.Label.LineWidth = LineWidth;
    C.Label.VerticalAlignment = 'middle';
    C.Limits = double([CBarMin CBarMax]);
    C.LineWidth = LineWidth;
    C.Position = double(CBarPosition);
    C.TickLabelInterpreter = Interpreter;
    C.TickLabels = CBarTickLabels;
    C.Ticks = double(CBarTicks);
    C.Visible = 'on';
else
end

% Create title
ax.Title.Units = 'points';
ax.Title.Color = [0 0 0];
ax.Title.FontName = FontName;
ax.Title.FontSize = double(FontSize);
ax.Title.FontUnits = 'points';
ax.Title.FontWeight = TitleFontWeight;
ax.Title.HorizontalAlignment = 'center';
ax.Title.Interpreter = Interpreter;
ax.Title.LineWidth = LineWidth;
ax.Title.Position = double(TitlePosition);
ax.Title.String = TitleString;
ax.Title.VerticalAlignment = 'middle';
ax.Title.Visible = 'on';
ax.TitleFontSizeMultiplier = 1;

% Create x axis
ax.XAxis.Color = [0 0 0];
ax.XAxis.FontName = FontName;
ax.XAxis.FontSize = double(FontSize);
ax.XAxis.FontWeight = AxisFontWeight;
ax.XAxis.HandleVisibility = 'off';
ax.XAxis.Label.Color = [0 0 0];
ax.XAxis.Label.FontName = FontName;
ax.XAxis.Label.FontSize = double(FontSize);
ax.XAxis.Label.FontUnits = 'points';
ax.XAxis.Label.FontWeight = LabelFontWeight;
ax.XAxis.Label.HandleVisibility = 'off';
ax.XAxis.Label.HorizontalAlignment = 'center';
ax.XAxis.Label.Interpreter = Interpreter;
ax.XAxis.Label.LineWidth = LineWidth;
ax.XAxis.Label.Units = 'points';
ax.XAxis.Label.Position = double(XLabelPosition);
ax.XAxis.Label.String = XLabelString;
ax.XAxis.Label.VerticalAlignment = 'middle';
ax.XAxis.Label.Visible = 'on';
ax.XAxis.Limits = double([XMin XMax]);
ax.XAxis.LineWidth = LineWidth;
if UseMinorTick == true
    ax.XAxis.MinorTick = 'on';
else
    ax.XAxis.MinorTick = 'off';
end
ax.XAxis.TickLabelInterpreter = Interpreter;
ax.XAxis.TickLabels = XTickLabels;
ax.XAxis.TickValues = double(XTicks);
if UseXAxis == true
    ax.XAxis.Visible = 'on';
else
    ax.XAxis.Visible = 'off';
end
ax.XColor = [0 0 0];
if UseGrid == true
    ax.XGrid = 'on';
else
    ax.XGrid = 'off';
end
ax.XLabel.BackgroundColor = 'None';
ax.XLabel.Color = [0 0 0];
ax.XLabel.FontName = FontName;
ax.XLabel.FontSize = double(FontSize);
ax.XLabel.FontUnits = 'points';
ax.XLabel.FontWeight = LabelFontWeight;
ax.XLabel.HandleVisibility = 'off';
ax.XLabel.HorizontalAlignment = 'center';
ax.XLabel.Interpreter = Interpreter;
ax.XLabel.LineWidth = LineWidth;
ax.XLabel.Units = 'points';
ax.XLabel.Position = double(XLabelPosition);
ax.XLabel.String = XLabelString;
ax.XLabel.VerticalAlignment = 'middle';
ax.XLabel.Visible = 'on';
ax.XLim = double([XMin XMax]);
ax.XTick = double(XTicks);
ax.XTickLabel = XTickLabels;

% Create y axis
ax.YAxis.Color = [0 0 0];
ax.YAxis.FontName = FontName;
ax.YAxis.FontSize = double(FontSize);
ax.YAxis.FontWeight = AxisFontWeight;
ax.YAxis.HandleVisibility = 'off';
ax.YAxis.Label.Color = [0 0 0];
ax.YAxis.Label.FontName = FontName;
ax.YAxis.Label.FontSize = double(FontSize);
ax.YAxis.Label.FontUnits = 'points';
ax.YAxis.Label.FontWeight = LabelFontWeight;
ax.YAxis.Label.HandleVisibility = 'off';
ax.YAxis.Label.HorizontalAlignment = 'center';
ax.YAxis.Label.Interpreter = Interpreter;
ax.YAxis.Label.LineWidth = LineWidth;
ax.YAxis.Label.Units = 'points';
ax.YAxis.Label.Position = double(YLabelPosition);
ax.YAxis.Label.String = YLabelString;
ax.YAxis.Label.VerticalAlignment = 'middle';
ax.YAxis.Label.Visible = 'on';
ax.YAxis.Limits = double([YMin YMax]);
ax.YAxis.LineWidth = LineWidth;
if UseMinorTick == true
    ax.YAxis.MinorTick = 'on';
else
    ax.YAxis.MinorTick = 'off';
end
ax.YAxis.TickLabelInterpreter = Interpreter;
ax.YAxis.TickLabels = YTickLabels;
ax.YAxis.TickValues = double(YTicks);
if UseYAxis == true
    ax.YAxis.Visible = 'on';
else
    ax.YAxis.Visible = 'off';
end
ax.YColor = [0 0 0];
if UseGrid == true
    ax.YGrid = 'on';
else
    ax.YGrid = 'off';
end
ax.YLabel.BackgroundColor = 'None';
ax.YLabel.Color = [0 0 0];
ax.YLabel.FontName = FontName;
ax.YLabel.FontSize = double(FontSize);
ax.YLabel.FontUnits = 'points';
ax.YLabel.FontWeight = LabelFontWeight;
ax.YLabel.HandleVisibility = 'off';
ax.YLabel.HorizontalAlignment = 'center';
ax.YLabel.Interpreter = Interpreter;
ax.YLabel.LineWidth = LineWidth;
ax.YLabel.Units = 'points';
ax.YLabel.Position = double(YLabelPosition);
ax.YLabel.String = YLabelString;
ax.YLabel.VerticalAlignment = 'middle';
ax.YLabel.Visible = 'on';
ax.YLim = double([YMin YMax]);
ax.YTick = double(YTicks);
ax.YTickLabel = YTickLabels;

% Create z axis
ax.ZAxis.Color = [0 0 0];
ax.ZAxis.FontName = FontName;
ax.ZAxis.FontSize = double(FontSize);
ax.ZAxis.FontWeight = AxisFontWeight;
ax.ZAxis.HandleVisibility = 'off';
ax.ZAxis.Label.Color = [0 0 0];
ax.ZAxis.Label.FontName = FontName;
ax.ZAxis.Label.FontSize = double(FontSize);
ax.ZAxis.Label.FontUnits = 'points';
ax.ZAxis.Label.FontWeight = LabelFontWeight;
ax.ZAxis.Label.HandleVisibility = 'off';
ax.ZAxis.Label.HorizontalAlignment = 'center';
ax.ZAxis.Label.Interpreter = Interpreter;
ax.ZAxis.Label.LineWidth = LineWidth;
ax.ZAxis.Label.Units = 'points';
ax.ZAxis.Label.Position = [0 0 0];
ax.ZAxis.Label.String = '';
ax.ZAxis.Label.VerticalAlignment = 'middle';
ax.ZAxis.Label.Visible = 'off';
ax.ZAxis.Limits = [0 1];
ax.ZAxis.LineWidth = LineWidth;
if UseMinorTick == true
    ax.ZAxis.MinorTick = 'on';
else
    ax.ZAxis.MinorTick = 'off';
end
ax.ZAxis.TickLabelInterpreter = Interpreter;
ax.ZAxis.TickLabels = '';
ax.ZAxis.TickValues = [];
ax.ZAxis.Visible = 'off';
ax.ZColor = [0 0 0];
ax.ZGrid = 'off';
ax.ZLabel.BackgroundColor = 'None';
ax.ZLabel.Color = [0 0 0];
ax.ZLabel.FontName = FontName;
ax.ZLabel.FontSize = double(FontSize);
ax.ZLabel.FontUnits = 'points';
ax.ZLabel.FontWeight = LabelFontWeight;
ax.ZLabel.HandleVisibility = 'off';
ax.ZLabel.HorizontalAlignment = 'center';
ax.ZLabel.Interpreter = Interpreter;
ax.ZLabel.LineWidth = LineWidth;
ax.ZLabel.Units = 'points';
ax.ZLabel.Position = [0 0 0];
ax.ZLabel.String = '';
ax.ZLabel.VerticalAlignment = 'middle';
ax.ZLabel.Visible = 'off';
ax.ZLim = [0 1];
ax.ZTick = [];
ax.ZTickLabel = '';

% Create border
if UseBorder == true
    line([XMin XMax XMax XMin XMin], ...
        [YMin YMin YMax YMax YMin], ...
        [1 1 1 1 1], ...
        'Color', [0 0 0], ...
        'HandleVisibility', 'off', ...
        'LineStyle', '-', ...
        'LineWidth', LineWidth);
else
end

% Write x axis exponent label
XExponentText = text(0, 0, XExponentLabel);
XExponentText.Units = 'Points';
XExponentText.BackgroundColor = 'None';
XExponentText.Color = [0 0 0];
XExponentText.FontName = FontName;
XExponentText.FontSize = double(FontSize);
XExponentText.FontUnits = 'Points';
XExponentText.HandleVisibility = 'Off';
XExponentText.HorizontalAlignment = 'Right';
XExponentText.Interpreter = Interpreter;
XExponentText.LineStyle = '-';
XExponentText.LineWidth = LineWidth;
XExponentText.Position = double(XExponentPosition);
XExponentText.String = XExponentLabel;
XExponentText.VerticalAlignment = 'Middle';

% Write y axis exponent label
YExponentText = text(0, 0, YExponentLabel);
YExponentText.Units = 'Points';
YExponentText.BackgroundColor = 'None';
YExponentText.Color = [0 0 0];
YExponentText.FontName = FontName;
YExponentText.FontSize = double(FontSize);
YExponentText.FontUnits = 'Points';
YExponentText.HandleVisibility = 'Off';
YExponentText.HorizontalAlignment = 'Left';
YExponentText.Interpreter = Interpreter;
YExponentText.LineStyle = '-';
YExponentText.LineWidth = LineWidth;
YExponentText.Position = double(YExponentPosition);
YExponentText.String = YExponentLabel;
YExponentText.VerticalAlignment = 'Bottom';

% Write colorbar exponent label
CBarExponentText = text(0, 0, CBarExponentLabel);
CBarExponentText.Units = 'Points';
CBarExponentText.BackgroundColor = 'None';
CBarExponentText.Color = [0 0 0];
CBarExponentText.FontName = FontName;
CBarExponentText.FontSize = double(FontSize);
CBarExponentText.FontUnits = 'Points';
CBarExponentText.HandleVisibility = 'Off';
CBarExponentText.HorizontalAlignment = 'Center';
CBarExponentText.Interpreter = Interpreter;
CBarExponentText.LineStyle = '-';
CBarExponentText.LineWidth = LineWidth;
CBarExponentText.Position = double(CBarExponentPosition);
CBarExponentText.String = CBarExponentLabel;
CBarExponentText.VerticalAlignment = 'Bottom';

end
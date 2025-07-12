function [fig, ax] = prettyPlot(varargin)

% Check if symbolic toolbox is installed
% symtoggle = cast(license('test', 'symbolic_toolbox'), 'logical');

% Create parser
p = inputParser;

% Axis parameters
addParameter(p, 'xLim', [sym(0) sym(1)]);
addParameter(p, 'yLim', [sym(0) sym(1)]);
addParameter(p, 'cLim', [sym(0) sym(1)]);
addParameter(p, 'nxTicks', cast(11, 'uint64'));
addParameter(p, 'nyTicks', cast(11, 'uint64'));
addParameter(p, 'ncBarTicks', cast(11, 'uint64'));
addParameter(p, 'usexAxis', true);
addParameter(p, 'useyAxis', true);
addParameter(p, 'useColorBar', false);
addParameter(p, 'useMinorTick', false);
addParameter(p, 'useGrid', false);
addParameter(p, 'useBorder', true);
addParameter(p, 'dataAspectRatio', []);
addParameter(p, 'plotAspectRatio', [sym(cast(1, 'uint64')) sym(cast(1, 'uint64')) sym(cast(1, 'uint64'))]);

% Label parameters
addParameter(p, 'xLabel', "");
addParameter(p, 'yLabel', "");
addParameter(p, 'cBarLabel', "");
addParameter(p, 'title', "");
addParameter(p, 'boxMarginScale', sym(cast(9, 'uint64')) / sym(cast(100, 'uint64')));
addParameter(p, 'axLabelOffset', sym(cast(3, 'uint64')) / sym(cast(4, 'uint64')));
addParameter(p, 'cBarLabelOffset', sym(cast(3, 'uint64')) / sym(cast(4, 'uint64')));
addParameter(p, 'cBarWidthScale', sym(cast(1, 'uint64')) / sym(cast(100, 'uint64')));
addParameter(p, 'xTickFormat', cast(5, 'uint64'));
addParameter(p, 'yTickFormat', cast(5, 'uint64'));
addParameter(p, 'cBarTickFormat', cast(5, 'uint64'));
addParameter(p, 'xScientificNotation', false);
addParameter(p, 'yScientificNotation', false);
addParameter(p, 'cBarScientificNotation', false);
addParameter(p, 'xTickFractions', false);
addParameter(p, 'yTickFractions', false);
addParameter(p, 'cBarTickFractions', false);
addParameter(p, 'xTickLabels', []);
addParameter(p, 'yTickLabels', []);
addParameter(p, 'cBarTickLabels', []);

% Font parameters
addParameter(p, 'fontName', 'Times');
addParameter(p, 'fontUnits', 'points');
addParameter(p, 'fontSize', sym(cast(10, 'uint64')));
addParameter(p, 'labelInterpreter', "latex");

% Paper parameters
addParameter(p, 'textWidth', sym(cast(1, 'uint64')));
addParameter(p, 'paperPoints', sym(cast(595, 'uint64')));
addParameter(p, 'marginPoints', sym(cast(90, 'uint64')));

% Parse the input
parse(p, varargin{:});

% Some style variables
white = cast([cast(1, 'uint64') cast(1, 'uint64') cast(1, 'uint64')], 'double');
black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');
alphaMap = cast(linspace(sym(0), sym(1), 1001), 'double');
one = cast(1, 'uint64');
lineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');

% Parse the inputs
if isempty(p.Results.dataAspectRatio)
    dataAspectRatioToggle = false;
else
    dataAspectRatioToggle = true;
end
LaTeXToggle = strcmp(p.Results.labelInterpreter, 'latex');

if dataAspectRatioToggle == true
    boxAspectRatio = (p.Results.xLim(2) - p.Results.xLim(1)) / (p.Results.yLim(2) - p.Results.yLim(1));
else
    boxAspectRatio = p.Results.plotAspectRatio(1) / p.Results.plotAspectRatio(2);
end

% Set the width of the paper
xFigWidth = (p.Results.paperPoints - (sym(cast(2, 'uint64')) * p.Results.marginPoints)) * p.Results.textWidth;
boxMarginWidth = (p.Results.boxMarginScale * xFigWidth) / p.Results.textWidth;
xAxisWidth = xFigWidth - (sym(cast(2, 'uint64')) * boxMarginWidth);
yAxisWidth = xAxisWidth / boxAspectRatio;
yFigWidth = yAxisWidth + (sym(cast(2, 'uint64')) * boxMarginWidth);
x0 = sym(cast(0, 'uint64'));
y0 = x0;

% Set the position of the title and the axis labels
titlePosition = [xAxisWidth / sym(cast(2, 'uint64')) yAxisWidth + (boxMarginWidth / sym(cast(2, 'uint64'))) sym(cast(0, 'uint64'))];
xLabelPosition = [xAxisWidth / sym(cast(2, 'uint64')) -boxMarginWidth * p.Results.axLabelOffset sym(cast(0, 'uint64'))];
yLabelPosition = [-boxMarginWidth * p.Results.axLabelOffset yAxisWidth / sym(cast(2, 'uint64')) sym(cast(2, 'uint64'))];
cBarLabelPosition = [(p.Results.cBarLabelOffset * boxMarginWidth) yAxisWidth / sym(cast(2, 'uint64')) sym(cast(0, 'uint64'))];
cBarPosition = [boxMarginWidth + xAxisWidth + (0.0025 * p.Results.paperPoints) boxMarginWidth p.Results.cBarWidthScale * p.Results.paperPoints yAxisWidth];
xExponentPosition = [xAxisWidth -sym(cast(2, 'uint64')) * sym(p.Results.fontSize) sym(cast(0, 'uint64'))];
yExponentPosition = [sym(p.Results.fontSize) / sym(cast(2, 'uint64')) yAxisWidth + (sym(p.Results.fontSize) / sym(cast(1, 'uint64'))) sym(cast(0, 'uint64'))];
cBarExponentPosition = [xAxisWidth + (boxMarginWidth / sym(cast(4, 'uint64'))) yAxisWidth + (sym(p.Results.fontSize) / sym(cast(1, 'uint64'))) sym(cast(0, 'uint64'))];

% Create the figure and axis
fig = figure;
ax = gca;
axis on;
hold on;

% Set the figure position
fig.Units = 'Points';
fig.Position = cast([x0 y0 xFigWidth yFigWidth], 'double');
fig.InnerPosition = fig.Position;
fig.Renderer = 'painters';

% Set the figure style
fig.Alphamap = alphaMap;
fig.PaperUnits = 'points';
fig.Color = white;

% Set the axis style
ax.Units = 'points';
ax.PositionConstraint = 'innerposition';
if p.Results.useBorder == true
    ax.Box = 'on';
else
    ax.Box = 'off';
end
ax.BoxStyle = 'back';
ax.Color = white;
if dataAspectRatioToggle == true
    ax.DataAspectRatio = cast(p.Results.dataAspectRatio, 'double');
end
ax.FontName = p.Results.fontName;
ax.FontSize = cast(p.Results.fontSize, 'double');
ax.FontUnits = 'points';
ax.FontWeight = 'normal';
ax.GridColor = black;
ax.LabelFontSizeMultiplier = 1;
ax.LineWidth = lineWidth;
ax.MinorGridColor = black;
if dataAspectRatioToggle == false
    ax.PlotBoxAspectRatio = cast(p.Results.plotAspectRatio, 'double');
end
ax.Position = cast([boxMarginWidth boxMarginWidth xAxisWidth yAxisWidth], 'double');
ax.TickLabelInterpreter = p.Results.labelInterpreter;
ax.TitleFontWeight = 'normal';
ax.View = [0 90];

% Create ticks and labels
xTickLabels = p.Results.xTickLabels;
if isempty(xTickLabels)
    [xTicks, xTickLabels, xExponentLabel] = createTicksAndLabels( ...
        p.Results.xLim(1), ...
        p.Results.xLim(2), ...
        p.Results.nxTicks, ...
        p.Results.xTickFormat, ...
        LaTeXToggle, ...
        p.Results.xTickFractions, ...
        p.Results.xScientificNotation);
else
    [xTicks, ~, xExponentLabel] = createTicksAndLabels( ...
        p.Results.xLim(1), ...
        p.Results.xLim(2), ...
        length(p.Results.xTickLabels), ...
        p.Results.xTickFormat, ...
        LaTeXToggle, ...
        p.Results.xTickFractions, ...
        p.Results.xScientificNotation);
end
yTickLabels = p.Results.yTickLabels;
if isempty(yTickLabels)
    [yTicks, yTickLabels, yExponentLabel] = createTicksAndLabels( ...
        p.Results.yLim(1), ...
        p.Results.yLim(2), ...
        p.Results.nyTicks, ...
        p.Results.yTickFormat, ...
        LaTeXToggle, ...
        p.Results.yTickFractions, ...
        p.Results.yScientificNotation);
else
    [yTicks, ~, yExponentLabel] = createTicksAndLabels( ...
        p.Results.yLim(1), ...
        p.Results.yLim(2), ...
        length(p.Results.yTickLabels), ...
        p.Results.yTickFormat, ...
        LaTeXToggle, ...
        p.Results.yTickFractions, ...
        p.Results.yScientificNotation);
end
cBarTickLabels = p.Results.cBarTickLabels;
if isempty(p.Results.cBarTickLabels)
    [cBarTicks, cBarTickLabels, cBarExponentLabel] = createTicksAndLabels( ...
        p.Results.cLim(1), ...
        p.Results.cLim(2), ...
        p.Results.ncBarTicks, ...
        p.Results.cBarTickFormat, ...
        LaTeXToggle, ...
        p.Results.cBarTickFractions, ...
        p.Results.cBarScientificNotation);
else
    [cBarTicks, ~, cBarExponentLabel] = createTicksAndLabels( ...
        p.Results.cLim(1), ...
        p.Results.cLim(2), ...
        length(p.Results.cBarTickLabels), ...
        p.Results.cBarTickFormat, ...
        LaTeXToggle, ...
        p.Results.cBarTickFractions, ...
        p.Results.cBarScientificNotation);
end

% Create colorbar
if p.Results.useColorBar == true
    C = colorbar;
    C.AxisLocationMode = 'manual';
    C.Units = 'points';
    C.Color = black;
    C.FontName = p.Results.fontName;
    C.FontSize = cast(p.Results.fontSize, 'double');
    C.Label.Units = 'points';
    C.Label.Color = black;
    C.Label.FontName = p.Results.fontName;
    C.Label.FontSize = cast(p.Results.fontSize, 'double');
    C.Label.FontUnits = 'points';
    C.Label.HorizontalAlignment = 'Center';
    C.Label.Interpreter = p.Results.labelInterpreter;
    C.Label.Position = cast(cBarLabelPosition, 'double');
    C.Label.String = p.Results.cBarLabel;
    C.Label.LineWidth = lineWidth;
    C.Label.VerticalAlignment = 'middle';
    C.Limits = cast(p.Results.cLim, 'double');
    C.LineWidth = lineWidth;
    C.Position = cast(cBarPosition, 'double');
    C.TickLabelInterpreter = p.Results.labelInterpreter;
    C.TickLabels = cBarTickLabels;
    C.Ticks = cast(cBarTicks, 'double');
    C.Visible = 'on';
else
end

% Set the axis font
ax.FontUnits = 'points';
ax.FontName = p.Results.fontName;
ax.FontSize = cast(p.Results.fontSize, 'double');
ax.FontWeight = 'normal';

% Set the title and axis labels
ax.Title = setLabel(p.Results.title, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    titlePosition, ...
    p.Results.labelInterpreter, ...
    ax.Title);
ax.XLabel = setLabel(p.Results.xLabel, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    xLabelPosition, ...
    p.Results.labelInterpreter, ...
    ax.XLabel);
ax.YLabel = setLabel(p.Results.yLabel, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    yLabelPosition, ...
    p.Results.labelInterpreter, ...
    ax.YLabel);

% Set the axes
setAxis(p.Results.xLim, ...
    p.Results.xLabel, ...
    xTicks, ...
    xTickLabels, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    xLabelPosition, ...
    p.Results.labelInterpreter, ...
    p.Results.useMinorTick, ...
    ax.XAxis);
setAxis(p.Results.yLim, ...
    p.Results.yLabel, ...
    yTicks, ...
    yTickLabels, ...
    p.Results.fontName, ...
    p.Results.fontSize, ...
    yLabelPosition, ...
    p.Results.labelInterpreter, ...
    p.Results.useMinorTick, ...
    ax.YAxis);

% Set the rest of the parameters
if p.Results.useGrid == true
    ax.XGrid = 'on';
    ax.YGrid = 'on';
else
    ax.XGrid = 'off';
    ax.YGrid = 'off';
end
ax.XColor = black;
ax.YColor = black;
if p.Results.usexAxis == true
    ax.XAxis.Visible = 'on';
else
    ax.XAxis.Visible = 'off';
end
if p.Results.useyAxis == true
    ax.YAxis.Visible = 'on';
else
    ax.YAxis.Visible = 'off';
end

% Set the axis limits
ax.XLim = cast(p.Results.xLim, 'double');
ax.YLim = cast(p.Results.yLim, 'double');
ax.CLim = cast(p.Results.cLim, 'double');

% Create border
if p.Results.useBorder == true
    line([p.Results.xLim(1) p.Results.xLim(2) p.Results.xLim(2) p.Results.xLim(1) p.Results.xLim(1)], ...
        [p.Results.yLim(1) p.Results.yLim(1) p.Results.yLim(2) p.Results.yLim(2) p.Results.yLim(1)], ...
        [1 1 1 1 1], ...
        'Color', black, ...
        'HandleVisibility', 'off', ...
        'LineStyle', '-', ...
        'LineWidth', lineWidth);
end

% Write the exponent labels
if p.Results.xScientificNotation == true
    writeExponentLabel(xExponentLabel, ...
        p.Results.fontName, ...
        p.Results.fontSize, ...
        p.Results.labelInterpreter, ...
        lineWidth, ...
        xExponentPosition);
end
if p.Results.yScientificNotation == true
    writeExponentLabel(yExponentLabel, ...
        p.Results.fontName, ...
        p.Results.fontSize, ...
        p.Results.labelInterpreter, ...
        lineWidth, ...
        yExponentPosition);
end
if p.Results.cBarScientificNotation == true
    writeExponentLabel(cBarExponentLabel, ...
        p.Results.fontName, ...
        p.Results.fontSize, ...
        p.Results.labelInterpreter, ...
        lineWidth, ...
        cBarExponentPosition);
end

% Reset the color index to origin
ax.ColorOrderIndex = one;

function writeExponentLabel(exponentLabel, fontName, fontSize, labelInterpreter, lineWidth, exponentPosition)

black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');

exponentText = text(0, 0, exponentLabel);
exponentText.Units = 'points';
exponentText.BackgroundColor = 'none';
exponentText.Color = black;
exponentText.FontName = fontName;
exponentText.FontSize = cast(fontSize, 'double');
exponentText.FontUnits = 'points';
exponentText.HandleVisibility = 'off';
exponentText.HorizontalAlignment = 'center';
exponentText.Interpreter = labelInterpreter;
exponentText.LineStyle = '-';
exponentText.LineWidth = lineWidth;
exponentText.Position = cast(exponentPosition, 'double');
exponentText.String = exponentLabel;
exponentText.VerticalAlignment = 'middle';

end

function label = setLabel(labelString, fontName, fontSize, labelPosition, labelInterpreter, label)

black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');

label.Units = 'points';
label.FontUnits = 'points';

label.BackgroundColor = 'None';
label.Color = black;
label.FontName = fontName;
label.FontSize = cast(fontSize, 'double');
label.FontWeight = 'normal';
label.HandleVisibility = 'off';
label.HorizontalAlignment = 'center';
label.Interpreter = labelInterpreter;
label.LineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');
label.Position = cast(labelPosition, 'double');
label.String = labelString;
label.VerticalAlignment = 'middle';
label.Visible = 'on';

end

function setAxis(axisLimits, labelString, tickValues, tickLabels, fontName, fontSize, labelPosition, labelInterpreter, useMinorTick, axis)

black = cast([cast(0, 'uint64') cast(0, 'uint64') cast(0, 'uint64')], 'double');

% Set the x axis
axis.Color = black;
axis.FontName = fontName;
axis.FontSize = cast(fontSize, 'double');
axis.FontWeight = 'normal';
axis.HandleVisibility = 'off';
axis.Label.Color = black;
axis.Label.FontName = fontName;
axis.Label.FontSize = cast(fontSize, 'double');
axis.Label.FontUnits = 'points';
axis.Label.FontWeight = 'normal';
axis.Label.HandleVisibility = 'off';
axis.Label.HorizontalAlignment = 'center';
axis.Label.Interpreter = labelInterpreter;
axis.Label.LineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');
axis.Label.Units = 'points';
axis.Label.Position = cast(labelPosition, 'double');
axis.Label.String = labelString;
axis.Label.VerticalAlignment = 'middle';
axis.Label.Visible = 'on';
axis.Limits = cast(axisLimits, 'double');
axis.LineWidth = cast(sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')), 'double');
if useMinorTick == true
    axis.MinorTick = 'on';
else
    axis.MinorTick = 'off';
end
axis.TickLabelInterpreter = labelInterpreter;
axis.TickLabels = tickLabels;
axis.TickValues = cast(tickValues, 'double');

end

end
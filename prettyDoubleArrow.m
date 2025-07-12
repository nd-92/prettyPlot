function prettyDoubleArrow(x, y, varargin)

% Create parser
p = inputParser;

% Text annotation parameters
addParameter(p, "label", "");
addParameter(p, "labelAlignment", "midAbove");
addParameter(p, "fontSize", sym(cast(10, 'uint64')));
addParameter(p, "nCharsLabelOffset", sym(cast(1, 'uint64')) / sym(cast(2, 'uint64')));
addParameter(p, 'horizontalAlignment', 'center');
addParameter(p, 'verticalAlignment', 'middle');

% Label alignment must be:
% end, start, midAbove, midBelow

% Parse the input
parse(p, varargin{:});

pos = sym(gca().Position);
xLim = sym(gca().XLim);
yLim = sym(gca().YLim);

X = ((x - xLim(1)) / (xLim(2) - xLim(1)) * pos(3)) + pos(1);
Y = ((y - yLim(1)) / (yLim(2) - yLim(1)) * pos(4)) + pos(2);
annotation('doublearrow', 'Units', 'Points', 'X', X, 'Y', Y, 'Head1Length', 5, 'Head1Width', 5, 'Head2Length', 5, 'Head2Width', 5);

% Now do the label
pos = sym(gca().Position);
XLim = sym(gca().XLim);
YLim = sym(gca().YLim);

if not(strcmp(p.Results.label, ""))
    % Calculate gradient of the line and its normal
    % m = (y(2) - y(1)) / (x(2) - x(1));
    % disp(num2str(double(m)));
    % m_n = -symInt(1) / m;
    % disp(num2str(double(m_n)));

    % Handle case of mid above alignment
    if strcmpi(p.Results.labelAlignment, "midabove")

        [xOffset, yOffset] = arrLabelOffset(p.Results.fontSize, ...
            p.Results.nCharsLabelOffset, x, y, 1);

        xMid = (x(2) + x(1)) / symInt(2);
        yMid = (y(2) + y(1)) / symInt(2);
        X = ((xMid - XLim(1)) / (XLim(2) - XLim(1)) * pos(3));
        Y = ((yMid - YLim(1)) / (YLim(2) - YLim(1)) * pos(4));

        text(X + xOffset, ...
            Y + yOffset, ...
            0, ...
            p.Results.label, ...
            'Units', 'Points', ...
            'HorizontalAlignment', p.Results.horizontalAlignment, ...
            'VerticalAlignment', p.Results.verticalAlignment, ...
            'Interpreter', 'Latex');
    end

    % Handle case of mid below alignment
    if strcmpi(p.Results.labelAlignment, "midbelow")

        [xOffset, yOffset] = arrLabelOffset(p.Results.fontSize, ...
            p.Results.nCharsLabelOffset, x, y, 1);

        % if (m_n == symInt(0))

        % end

        xMid = (x(2) + x(1)) / symInt(2);
        yMid = (y(2) + y(1)) / symInt(2);
        X = ((xMid - XLim(1)) / (XLim(2) - XLim(1)) * pos(3));
        Y = ((yMid - YLim(1)) / (YLim(2) - YLim(1)) * pos(4));

        text(X + xOffset, ...
            Y - yOffset, ...
            0, ...
            p.Results.label, ...
            'Units', 'Points', ...
            'HorizontalAlignment', p.Results.horizontalAlignment, ...
            'VerticalAlignment', p.Results.verticalAlignment, ...
            'Interpreter', 'Latex');
    end

    % Handle case of start text alignment
    if strcmpi(p.Results.labelAlignment, "start")
        [xOffset, yOffset] = arrLabelOffset(p.Results.fontSize, ...
            p.Results.nCharsLabelOffset, x, y, 0);

        X = ((x(1) - XLim(1)) / (XLim(2) - XLim(1)) * pos(3));
        Y = ((y(1) - YLim(1)) / (YLim(2) - YLim(1)) * pos(4));

        text(X - xOffset, ...
            Y - yOffset, ...
            0, ...
            p.Results.label, ...
            'Units', 'Points', ...
            'HorizontalAlignment', p.Results.horizontalAlignment, ...
            'VerticalAlignment', p.Results.verticalAlignment, ...
            'Interpreter', 'Latex');
    end

    % Handle case of end text alignment
    if strcmpi(p.Results.labelAlignment, "end")
        [xOffset, yOffset] = arrLabelOffset(p.Results.fontSize, ...
            p.Results.nCharsLabelOffset, x, y, 0);

        X = ((x(2) - XLim(1)) / (XLim(2) - XLim(1)) * pos(3));
        Y = ((y(2) - YLim(1)) / (YLim(2) - YLim(1)) * pos(4));

        text(X + xOffset, ...
            Y + yOffset, ...
            0, ...
            p.Results.label, ...
            'Units', 'Points', ...
            'HorizontalAlignment', p.Results.horizontalAlignment, ...
            'VerticalAlignment', p.Results.verticalAlignment, ...
            'Interpreter', 'Latex');
    end
end

end
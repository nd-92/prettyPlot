function [tickVals, tickLabels, exponentLabel] = createTicksAndLabels(Min, Max, NTicks, TickFormat, LatexToggle, UseTickFractions, UseScientificNotation)

% Toggle scientific notation off if using fractions
if UseTickFractions == true
    UseScientificNotation = false;
end

% Check if symbolic toolbox is installed
symtoggle = license('test', 'symbolic_toolbox');
if symtoggle == 1
    tickVals = simplify(linspace(sym(Min), sym(Max), NTicks), 'Steps', 100);
    tickLabels = strings(1, NTicks);
    if UseTickFractions == false
        if UseScientificNotation == false
            for a = 1 : 1 : NTicks
                if LatexToggle == true
                    tickLabels(a) = strcat('$', num2str(double(simplify(tickVals(a), 'Steps', 100)), TickFormat), '$');
                else
                    tickLabels(a) = strcat(num2str(double(simplify(tickVals(a), 'Steps', 100)), TickFormat));
                end
            end
        end
        if UseScientificNotation == true
            exponent = double(floor(log10(tickVals(end))));
            if LatexToggle == true
                exponentLabel = strcat('$\times 10^{', num2str(exponent, '%0.0f'), '}$');
            else
                exponentLabel = strcat('\times {10^{', num2str(exponent, '%0.0f'), '}}');
            end
            for a = 1 : 1 : NTicks
                if LatexToggle == true
                    tickLabels(a) = strcat('$', num2str(double(simplify(tickVals(a) / (sym(10) ^ exponent), 'Steps', 100)), TickFormat), '$');
                else
                    tickLabels(a) = strcat(num2str(double(simplify(tickVals(a) / (sym(10) ^ exponent), 'Steps', 100)), TickFormat));
                end
            end
        end
    end
    if UseTickFractions == true
        if LatexToggle == true
            for a = 1 : NTicks
                tickLabels(a) = strcat('$', latex(simplify(tickVals(a), 'Steps', 100)), '$');
            end
        else
            for a = 1 : 1 : NTicks
                [Num, Den] = numden(tickVals(a));
                if Den == 1
                    tickLabels(a) = num2str(double(Num));
                else
                    tickLabels(a) = strcat('^{', num2str(double(Num)), '}/_{', num2str(double(Den)), '}');
                end
            end
        end
    end
else
    tickVals = linspace(Min, Max, NTicks);
    tickLabels = strings(1, NTicks);
    if UseScientificNotation == false
        for a = 1 : 1 : NTicks
            if LatexToggle == true
                tickLabels(a) = strcat('$', num2str(double(tickVals(a)), TickFormat), '$');
            else
                tickLabels(a) = num2str(double(tickVals(a)), TickFormat);
            end
        end
    end
	if UseScientificNotation == true
        exponent = double(floor(log10(tickVals(end))));
        if LatexToggle == true
            exponentLabel = strcat('$\times 10^{', num2str(exponent, '%0.0f'), '}$');
        else
            exponentLabel = strcat('\times 10^{', num2str(exponent, '%0.0f'), '}');
        end
        for a = 1:NTicks
            if LatexToggle == true
                tickLabels(a) = strcat('$', num2str(double(tickVals(a) / (sym(10) ^ exponent)), TickFormat), '$');
            else
                tickLabels(a) = strcat(num2str(double(tickVals(a) / (sym(10) ^ exponent)), TickFormat));
            end
        end
	end
end
if not(exist('exponentLabel', 'var'))
    exponentLabel = '';
end
end
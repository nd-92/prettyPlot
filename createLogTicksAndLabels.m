function [tickVals, tickLabels] = createLogTicksAndLabels(min, max, nTicks)

% Check if symbolic toolbox is installed
symToggle = license('test', 'symbolic_toolbox');

if symToggle == true
    min = sym(min);
    max = sym(max);
    nTicks = cast(nTicks, 'uint64');
    tickExponents = simplify(linspace(min, max, nTicks), 'Steps', 1000);
    tickVals = simplify(sym(10) .^ tickExponents, 'Steps', 1000);
    tickLabels = strings(1, nTicks);
    for a = 1 : 1 : nTicks
        tickLabels(a) = strcat("$10^{", string(tickExponents(a)), "}$");
    end
end

end
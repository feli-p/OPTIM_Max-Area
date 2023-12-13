function [alfa] = recorta(u,v)
% recorta la longitud del vector v tal que
% u + alfa*v >= 0
% donde u > 0.
% Rutina para puntos interiores.

n = length(v);
valfa = ones(n,1);
for k = 1:n
    if (v(k) <0)
        valfa(k) = min(1, -(u(k)/v(k)));
    end
end

alfa = (0.995)*min(valfa);

end
function [point] = pInicial(n_v)
% A partir de un número de vértices, regresa las coordenadas de un  polígono
% El punto inicial y final es el origen, por lo que se dan solo las
% coordenadas de los demás vértices.
% n_v debe ser mayor o igual a 2

point = [];
angle = pi/(n_v+1);

for i=1:n_v
    point(end+1) = 1/2;
    point(end+1) = i*angle;
end

point = point';

end
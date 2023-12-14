function [point] = polInicial(n_v)
% A partir de un número de vértices, regresa las coordenadas de un  polígono
% n_v debe ser mayor o igual a 3

point = [1/2 0];
angle = pi/(n_v-2);

for i=2:n_v-2
    point(end+1) = 1/2;
    point(end+1) = (i-1)*angle;
end

point(end+1) = 1/2;
point(end+1) = pi;
point(end+1) = 0;
point(end+1) = pi;

point = point';

end
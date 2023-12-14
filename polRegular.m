
function [point] = polRegular(n_v)
% A partir de un número de vértices, regresa las coordenadas del polígono regular
r = 1/2;
point = [];
angle = 2*pi/n_v;

for i=1:n_v-1
    theta = i*angle - pi/2;
    x = r*cos(theta);
    y = r*sin(theta) + 1/2;
    point(end+1) = sqrt(x^2 + y^2);
    point(end+1) = atan(y/x);
end

point(end+1) = 0;
point(end+1) = pi;


end
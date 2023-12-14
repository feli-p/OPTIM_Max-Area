function [gx] = funres(x)
%funres Función de restricciones para el problema del polígono de área
%máxima.
%   Detailed explanation goes here
nn = length(x);

gx = [];

for i = 1:2:nn-3
    for j = i+2:2:nn-1
        gx(end+1) = 1-x(i)^2-x(j)^2+(2*x(i)*x(j)*cos(x(j+1)-x(i+1)));
    end
end

for i = 1:2:nn-1
    gx(end+1) = 1-x(i);
    gx(end+1) = x(i);
    gx(end+1) = pi-x(i+1);
    gx(end+1) = x(i+1);
end

for i = 1:2:nn-3
    gx(end+1) = x(i+3)-x(i+1);
end
gx = gx';
end
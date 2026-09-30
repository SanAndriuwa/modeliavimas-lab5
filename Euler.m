function [t,y] = Euler(f,tspan,y0,N)
% Explicit Euler method, adapted from the provided Euler.m.
h = (tspan(2)-tspan(1))/N;
t = linspace(tspan(1),tspan(2),N+1)';
y = zeros(N+1,length(y0));
y(1,:) = y0(:)';
for i = 1:N
    y(i+1,:) = y(i,:)+h*f(t(i),y(i,:));
end
end

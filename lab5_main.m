% First-order RC/RL circuit driven by a rectangular input pulse.
clear; clc; close all;
variants = 1:4;
tau = 0.1;
N = 500; % Euler steps on each half of the interval
for variant = variants
fprintf('\nCIRCUIT VARIANT %d\n',variant);
if ~ismember(variant,1:4)
    error('variant must be from 1 to 4.');
end
% State q is the capacitor voltage (RC) or the resistor voltage (RL).
% For all four circuits: tau*q' + q = Uin, q(0) = 0.
% Outputs: variants 1,4 -> q; variants 2,3 -> Uin-q.
[t1,qE1] = Euler(@(t,q) (1-q)/tau,[0 0.5],0,N);
[t2,qE2] = Euler(@(t,q) -q/tau,[0.5 1],qE1(end),N);
options = odeset('RelTol',1e-10,'AbsTol',1e-12);
[~,qO1] = ode45(@(t,q) (1-q)/tau,t1,0,options);
[~,qO2] = ode45(@(t,q) -q/tau,t2,qO1(end),options);

% Solve each constant-input interval separately, maintaining state continuity.
hasSymbolic = exist('syms','file') == 2;
if hasSymbolic
    syms s q(s)
    tauSym = sym(tau,'r');
    qExact1 = dsolve(tauSym*diff(q,s)+q == 1,q(0) == 0);
    qHalf = subs(qExact1,s,sym(1)/2);
    qExact2 = dsolve(tauSym*diff(q,s)+q == 0,q(sym(1)/2) == qHalf);
    f1 = matlabFunction(qExact1,'Vars',s);
    f2 = matlabFunction(qExact2,'Vars',s);
    disp('Analytical state for 0 <= t <= 0.5:'); disp(qExact1);
    disp('Analytical state for 0.5 <= t <= 1:'); disp(qExact2);
else
    f1 = @(t) 1-exp(-t/tau);
    f2 = @(t) (1-exp(-0.5/tau))*exp(-(t-0.5)/tau);
    fprintf('Symbolic Math Toolbox is unavailable: dsolve() was not executed.\n');
    fprintf('Analytical state: 1-exp(-t/tau), then (1-exp(-0.5/tau))*exp(-(t-0.5)/tau).\n');
end
qA1 = f1(t1); qA2 = f2(t2);
t = [t1; t2]; % duplicate 0.5 displays both sides of an output jump
input = [ones(size(t1)); zeros(size(t2))];
qEuler = [qE1; qE2]; qOde = [qO1; qO2]; qAnalytic = [qA1; qA2];
if ismember(variant,[1 4])
    outEuler = qEuler; outOde = qOde; outAnalytic = qAnalytic;
else
    outEuler = input-qEuler;
    outOde = input-qOde;
    outAnalytic = input-qAnalytic;
end
errorEuler = outEuler-outAnalytic;
errorOde = outOde-outAnalytic;
Method = {'Euler'; 'ode45'};
disp(table(Method,[max(abs(errorEuler)); max(abs(errorOde))], ...
    'VariableNames',{'Method','MaximumAbsoluteError'}));
figure;
plot(t,input,'k:',t,outAnalytic,'k-',t,outEuler,'r--',t,outOde,'b-.', ...
    'LineWidth',1.2);
xlabel('t, s'); ylabel('Voltage, V'); grid on;
legend('Uin','Analytical','Euler','ode45','Location','best');
title(sprintf('Circuit %d, tau = %.1f s',variant,tau));
figure;
plot(t,errorEuler,'r-',t,errorOde,'b-','LineWidth',1.2);
xlabel('t, s'); ylabel('Numerical minus analytical, V'); grid on;
legend('Euler error','ode45 error','Location','best');
end

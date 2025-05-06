% constant definitions from .md
a = 2e-9; % half-width, 6nm
V0 = 1.6e-25; % -|V| = 0.01 ueV
m = 1.445e-25; % mass of Rb87
hbar = 1.055e-34;

rho = sqrt(2*m*a^2*abs(V0)) / hbar;

% define trans. eqns for parities (see .md for derivation)
even_eq = @(xi) xi .* tan(xi) - sqrt(rho^2 - xi.^2);
odd_eq = @(xi) xi .* cot(xi) + sqrt(rho^2 - xi.^2);

% xi & energy level parities for eigenstates
% eta = 1.26 (+), 2.48 (-), 3.62 (+)
xi_even = [1.26, 3.62];
xi_odd = 2.48;
energyLevel_even = zeros(1, 3);
energyLevel_odd = zeros(1, 3);
k_even = zeros(1, 3);
k_odd = zeros(1, 3);
kappa_even = zeros(1, 3);
kappa_odd = zeros(1, 3);

% iterate over 2 xi_even to solve for roots
for n = 1:2

    % energy levels calc
    energyLevel_even(n) = ((hbar^2*xi_even(n)^2) / (2*m*a^2)) - V0;
    % k calc
    k_even(n) = sqrt(2*m*(V0-abs(energyLevel_even(n)))/hbar^2);
    % kappa calc
    kappa_even(n) = sqrt(2*m*abs(energyLevel_even(n))/hbar^2);

end

    energyLevel_odd = ((hbar^2*xi_odd^2)/(2*m*a^2)) - V0;
    % k calc
    k_odd = sqrt(2*m*(V0-abs(energyLevel_odd))/hbar^2);
    % kappa calc
    kappa_odd = sqrt(2*m*abs(energyLevel_odd)/hbar^2);

disp('Even E-levels (J):');
disp(energyLevel_even);
disp('Even k-values:');
disp(k_even);
disp('Even kappa-values:');
disp(kappa_even);

disp('Odd E-levels (J):');
disp(energyLevel_odd);
disp('Odd k-values:');
disp(k_odd);
disp('Odd kappa-values:');
disp(kappa_odd);
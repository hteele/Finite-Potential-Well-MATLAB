% constant definitions from .md
a = 2e-9; % half-width, 6nm
V0 = 1.6e-25; % -|V| = 0.01 ueV
m = 1.445e-25; % mass of Rb87
hbar = 1.055e-34;

% computed e-levels, k, and kappa vectors from solve_energy_levels.m
energy_even = [-0.1447e-24, -0.0338e-24];
energy_odd = -1.0078e-25;
k_even = [0.6300e9, 1.8100e9];
k_odd = 1.2400e9;
kappa_even = [1.9384e9, 0.9372e9];
kappa_odd = 1.6177e9;

% array init.
results = struct('parity', {}, 'level', {}, 'A', {}, 'B', {}, 'C', {}, 'D', {});

% n = 2 for 2 even eigenstates
for n = 1:2

    sol_even = fsolve(@(x) [
    x(1)*exp(-kappa_even(n)*a) - x(2)*cos(k_even(n)*a);
    kappa_even(n)*x(1)*exp(-kappa_even(n)*a) + k_even(n)*x(2)*sin(k_even(n)*a);
    x(2)*cos(k_even(n)*a) - x(3)*exp(-kappa_even(n)*a);
    -k_even(n)*x(2)*sin(k_even(n)*a) + kappa_even(n)*x(3)*exp(-kappa_even(n)*a)
    ], [1, 1, 1]);

    results(end+1).parity = 'even';
    results(end).level = n;
    results(end).A = sol_even(1);
    results(end).B = sol_even(2);
    results(end).C = 0;
    results(end).D = sol_even(3);
end

% repeat for odd
sol_odd = fsolve(@(x) [
    x(1)*exp(-kappa_odd*a) - x(2)*sin(k_odd*a);
    kappa_odd*x(1)*exp(-kappa_odd*a) + k_odd*x(2)*cos(k_odd*a);
    x(2)*sin(k_odd*a) - x(3)*exp(-kappa_odd*a);
    k_odd*x(2)*cos(k_odd*a) + kappa_odd*x(3)*exp(-kappa_odd*a)
], [1, 1, 1]);

results(end+1).parity = 'odd';
results(end).level = 1;
results(end).A = sol_odd(1);
results(end).B = 0;
results(end).C = sol_odd(2);
results(end).D = sol_odd(3);

disp('A B C D coefs.:');
for i = 1:length(results)
    disp(['Level ', num2str(results(i).level), ' - ', results(i).parity, ' parity:']);
    disp([' A = ', num2str(results(i).A)]);
    disp([' B = ', num2str(results(i).B)]);
    disp([' C = ', num2str(results(i).C)]);
    disp([' D = ', num2str(results(i).D)]);
end
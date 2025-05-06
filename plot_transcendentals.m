% constant definitions from .md

a = 2e-9; % half-width, 6nm
V0 = 1.6e-25; % -|V| = 0.01 ueV
m = 1.445e-25; % mass of Rb87
hbar = 1.055e-34;
z0 = (a/hbar) * sqrt(2*m*V0);
num_states = round(z0/pi);

rho = sqrt((2*m*(a^2)*abs(V0))/(hbar^2));

xi = linspace(0, 5, 500);

rho_circle = sqrt(rho^2 - xi.^2);

% even eigenstate
even_eigen = xi .* tan(xi);

% odd eigenstate
odd_eigen = -xi .* cot(xi);

figure;
hold on;
plot(xi, even_eigen, 'b', 'LineWidth', 1, 'DisplayName', 'Even Parity \Psi');
plot(xi, odd_eigen, 'r', 'LineWidth', 1, 'DisplayName', 'Odd Parity \Psi');
plot(xi, rho_circle, 'k', 'LineWidth', 1, 'DisplayName', '\rho');

xlabel('\xi');
ylabel('\eta');
title('\xi vs. \eta');

legend('Location', 'northeastoutside');
axis([0, max(xi), 0, max(rho_circle)]);
grid on;
hold off;
% constant definitions from .md
a = 2e-9; % half-width, 6nm
V0 = 1.6e-25; % -|V| = 0.01 ueV
m = 1.445e-25; % mass of Rb87
hbar = 1.055e-34;

energy_even = [-0.1447e-24, -0.0338e-24];
energy_odd = -1.0078e-25;
k_even = [0.6300e9, 1.8100e9];
k_odd = 1.2400e9;
kappa_even = [1.9384e9, 0.9372e9];
kappa_odd = 1.6177e9;

% A B C D calculated from calculate_coefs.m
A_even = [-0.016677, 0.00031892];
B_even = [0.0011165, 5.5041e-05];
C_even = [0, 0];
D_even = [0.016677, -0.00031892];

A_odd = 1.0299;
B_odd = 0;
C_odd = 0.067;
D_odd = 1.0299;

x = linspace(-4*a, 4*a, 50000); % 500000 points for smoothness

% n = 2 for 2 even eigenstates
for n = 1:2

    % define psi for regions 1-3
    psi_1_even = @(x) A_even(n)*exp(kappa_even(n)*x); % region 1
    psi_2_even = @(x) B_even(n)*cos(k_even(n)*x); % region 2
    psi_3_even = @(x) D_even(n)*exp(-kappa_even(n)*x); % region 3
    % combine regions under 1 function for integral
    psi_even = @(x) (x < -a).*psi_1_even(x) + (x >= -a & x <= a).*psi_2_even(x) + (x > a).*psi_3
    % integrate psi_even and normalize
    psi_integ_even = integral(@(x) abs(psi_even(x)).^2, -4*a, 4*a, 'ArrayValued', true);
    norm_even = sqrt(psi_integ_even);
    psi_normalized_even = @(x) abs(sqrt(psi_even(x)/norm_even)).^2;
    % plotting
    figure;
    plot(x, psi_normalized_even(x), 'b', 'LineWidth', 1);
    title(['|\Psi(x)|^2 Even Parity n = ', num2str(n)]);
    xlabel('x (m)');
    ylabel('|\Psi(x)|^2');
    grid on;

end

% repeat process for odd parity
psi_1_odd = @(x) A_odd*exp(kappa_odd * x); % region 1
psi_2_odd = @(x) C_odd*sin(k_odd * x); % region 2
psi_3_odd = @(x) D_odd*exp(-kappa_odd * x); % region 3

psi_odd = @(x) (x < -a).*psi_1_odd(x) + (x >= -a & x <= a).*psi_2_odd(x) + (x > a).*psi_3_odd(x)

psi_integ_odd = integral(@(x) abs(psi_odd(x)).^2, -4*a, 4*a, 'ArrayValued', true);
norm_odd = sqrt(psi_integ_odd);

psi_normalized_odd = @(x) abs(sqrt(psi_odd(x)/norm_odd)).^2;

figure;
plot(x, psi_normalized_odd(x), 'r', 'LineWidth', 1);
title('|\Psi(x)|^2 Odd Parity, n = 1');
xlabel('x (m)');
ylabel('|\Psi(x)|^2');
grid on;
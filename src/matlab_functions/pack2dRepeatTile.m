function pack2dRepeatTile(N, K, P_target, W_factor, seed, x_mult, y_mult, calc_eig, in_path, save_path)
% pack2dRepeatTile(400, 100, .005, 20, 1, 2, 2, false, 'in/2d_tile_20by20/tiles/', 'in/2d_tile_20by20/40by40/')

packing_name = string(sprintf("2D_N%d_P%s_Width%d_Seed%d", N, num2str(P_target), W_factor, seed));

filename = in_path + packing_name + ".mat"  % Concatenate path and filename

load(filename);

N_new = N * x_mult * y_mult;
W_new = W_factor * y_mult;


N_repeated = x_mult;
x_repeated = [];
y_repeated = [];
Dn_repeated = [];
filename = [save_path, '2D_N' num2str(N_new) '_P' num2str(P_target) '_Width' num2str(W_new) '_Seed' num2str(seed) '.mat'];

for i = 0:N_repeated-1
    x_shifted = x + i * Lx;
    y_shifted = y + i * Ly;
    x_repeated = [x_repeated, x_shifted];
    y_repeated = [y_repeated, y];
    Dn_repeated = [Dn_repeated, Dn]; % Append Dn for each repetition
end

N = N * N_repeated;
x = x_repeated;
y = y_repeated;
Dn = Dn_repeated; % Set Dn to the repeated diameters

% Time for y
N_repeated = y_mult;
x_repeated = [];
y_repeated = [];
Dn_repeated = [];

for i = 0:N_repeated-1
    y_shifted = y + i * Ly;
    x_repeated = [x_repeated, x];
    y_repeated = [y_repeated, y_shifted];
    Dn_repeated = [Dn_repeated, Dn]; % Append Dn for each repetition
end

N = N * N_repeated;
x = x_repeated;
y = y_repeated;
Dn = Dn_repeated; % Set Dn to the repeated diameters
W_factor = W_factor * N_repeated;

Lx = Lx * x_mult; 
Ly = Ly * y_mult;
W_factor = W_factor * y_mult;
diameter_average = mean(Dn);

mass = 1;
if calc_eig == true
    positions = [x',y'];
    radii = Dn./2;
    [positions, radii] = cleanRats(positions, radii, K, Ly, Lx);
    Hessian = hess2d(positions, radii, K, Ly, Lx);
    [eigen_vectors, eigen_values ] =  eig(Hessian);
    save(filename, 'x', 'y', 'Dn', 'Lx', 'Ly', 'K', 'P_target', 'P', 'N', 'eigen_vectors', 'eigen_values');
else
    save(filename, 'x', 'y', 'Dn', 'Lx', 'Ly', 'K', 'P_target', 'P', 'N', 'W_factor', 'mass', "diameter_average");
end
%% ========================================================================
% COMPLETE FIGURE GENERATION SCRIPT FOR PROGRAMMING TECHNIQUES DOCUMENT
% Compatible with MATLAB R2023a
% Run each cell with Ctrl+Enter or run all with Ctrl+Shift+Enter
% =========================================================================

%% CONFIGURATION
% Set this to true to save figures, false to only display
DOWNLOAD = true;

% Set output directory (current directory by default)
output_dir = './';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end

% Set LaTeX as default interpreter globally
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');
set(groot, 'defaultColorbarTickLabelInterpreter','latex');

fprintf('=== Figure Generation Started ===\n');
fprintf('Download enabled: %s\n', mat2str(DOWNLOAD));

%% ========================================================================
%  FIGURE 6: JACOBI CONVERGENCE
% =========================================================================
fprintf('\nGenerating Figure 6: Jacobi Convergence...\n');

% Problem setup
n = 50;
x = linspace(0, 1, n);
y = linspace(0, 1, n);
[X, Y] = meshgrid(x, y);

% Initialize with boundary conditions (zero) and random interior
rng(42); % For reproducibility
u = zeros(n, n);
u(2:end-1, 2:end-1) = rand(n-2, n-2) * 0.5;

% Source term (example: f = -2*pi^2*sin(pi*x)*sin(pi*y))
f = -2*pi^2 * sin(pi*X) .* sin(pi*Y);
dx = x(2) - x(1);
dy = y(2) - y(1);

% Iterations to visualize
iterations = [0, 10, 50, 100, 200];
u_history = cell(length(iterations), 1);

% Store initial state
u_history{1} = u;

% Perform Jacobi iterations
iter_count = 1;
for idx = 2:length(iterations)
    for iter = 1:(iterations(idx) - iterations(idx-1))
        u_old = u;
        u(2:end-1, 2:end-1) = 0.25 * (u_old(1:end-2, 2:end-1) + ...
                                      u_old(3:end, 2:end-1) + ...
                                      u_old(2:end-1, 1:end-2) + ...
                                      u_old(2:end-1, 3:end) + ...
                                      dx^2 * f(2:end-1, 2:end-1));
    end
    u_history{idx} = u;
end

% Create figure
fig = figure('Position', [100, 100, 1400, 900]);
set(fig, 'Color', 'w');

for i = 1:length(iterations)
    subplot(2, 3, i);
    pcolor(X, Y, u_history{i});
    shading interp;
    colormap(viridis_colormap());
    c = colorbar;
    c.Label.String = '$u(x,y)$';
    c.Label.Interpreter = 'latex';
    c.Label.FontSize = 11;
    axis equal tight;
    xlabel('$x$', 'FontSize', 12);
    ylabel('$y$', 'FontSize', 12);
    title(sprintf('Iteration %d', iterations(i)), 'FontSize', 13);
    set(gca, 'FontSize', 10);
end

sgtitle('Jacobi Iteration Convergence', 'FontSize', 16, 'Interpreter', 'latex');

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_jacobi_convergence.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_jacobi_convergence.png\n');
end

%% ========================================================================
%  FIGURE 7: SIMPLE SINE PLOT
% =========================================================================
fprintf('\nGenerating Figure 7: Simple Sine Plot...\n');

theta = linspace(-1.5*pi, 1.5*pi, 100);
y_sin = sin(theta);

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2);
grid on;
xlabel('$\theta$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
set(gca, 'FontSize', 12);
xlim([min(theta), max(theta)]);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_sine_plot.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_sine_plot.png\n');
end

%% ========================================================================
%  FIGURE 8: SINE AND COSINE
% =========================================================================
fprintf('\nGenerating Figure 8: Sine and Cosine...\n');

y_cos = cos(theta);

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2); hold on;
plot(theta, y_cos, 'r-', 'LineWidth', 2);
grid on;
xlabel('$\theta$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
set(gca, 'FontSize', 12);
xlim([min(theta), max(theta)]);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_sine_cosine_plot.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_sine_cosine_plot.png\n');
end

%% ========================================================================
%  FIGURE 9: ALL THREE FUNCTIONS (NO LIMITS)
% =========================================================================
fprintf('\nGenerating Figure 9: Trigonometric Functions (no limits)...\n');

y_tan = tan(theta);

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2); hold on;
plot(theta, y_cos, 'r-', 'LineWidth', 2);
plot(theta, y_tan, 'g-', 'LineWidth', 2);
grid on;
xlabel('$\theta$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
set(gca, 'FontSize', 12);
xlim([min(theta), max(theta)]);
% Note: ylim not set, so tan dominates

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_trig_with_tan.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_trig_with_tan.png\n');
end

%% ========================================================================
%  FIGURE 10: WITH AXIS LIMITS
% =========================================================================
fprintf('\nGenerating Figure 10: Trigonometric Functions (with limits)...\n');

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2); hold on;
plot(theta, y_cos, 'r-', 'LineWidth', 2);
plot(theta, y_tan, 'g-', 'LineWidth', 2);
xlim([min(theta), max(theta)]);
ylim([-pi, pi]);
grid on;
xlabel('$\theta$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
set(gca, 'FontSize', 12);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_with_axis_limits.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_with_axis_limits.png\n');
end

%% ========================================================================
%  FIGURE 11: WITH LEGEND
% =========================================================================
fprintf('\nGenerating Figure 11: Trigonometric Functions (with legend)...\n');

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2); hold on;
plot(theta, y_cos, 'r-', 'LineWidth', 2);
plot(theta, y_tan, 'g-', 'LineWidth', 2);
xlim([min(theta), max(theta)]);
ylim([-pi, pi]);
legend('$\sin(\theta)$', '$\cos(\theta)$', '$\tan(\theta)$', ...
       'FontSize', 12, 'Location', 'northeast');
grid on;
xlabel('$\theta$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
set(gca, 'FontSize', 12);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_with_legend.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_with_legend.png\n');
end

%% ========================================================================
%  FIGURE 12: WITH AXIS LABELS (x, y)
% =========================================================================
fprintf('\nGenerating Figure 12: Trigonometric Functions (with labels)...\n');

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2); hold on;
plot(theta, y_cos, 'r-', 'LineWidth', 2);
plot(theta, y_tan, 'g-', 'LineWidth', 2);
xlim([min(theta), max(theta)]);
ylim([-pi, pi]);
legend('$\sin(\theta)$', '$\cos(\theta)$', '$\tan(\theta)$', ...
       'FontSize', 12, 'Location', 'northeast');
grid on;
xlabel('$x$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
set(gca, 'FontSize', 12);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_with_labels.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_with_labels.png\n');
end

%% ========================================================================
%  FIGURE 13: COMPLETE WITH TITLE
% =========================================================================
fprintf('\nGenerating Figure 13: Complete Trigonometric Plot...\n');

fig = figure('Position', [100, 100, 800, 600]);
set(fig, 'Color', 'w');
plot(theta, y_sin, 'b-', 'LineWidth', 2); hold on;
plot(theta, y_cos, 'r-', 'LineWidth', 2);
plot(theta, y_tan, 'g-', 'LineWidth', 2);
xlim([min(theta), max(theta)]);
ylim([-pi, pi]);
legend('$\sin(\theta)$', '$\cos(\theta)$', '$\tan(\theta)$', ...
       'FontSize', 12, 'Location', 'northeast');
grid on;
xlabel('$x$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
title('Trigonometric functions', 'FontSize', 16);
set(gca, 'FontSize', 12);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_complete.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_complete.png\n');
end

%% ========================================================================
%  FIGURE 14: PCOLORMESH (2D HEATMAP)
% =========================================================================
fprintf('\nGenerating Figure 14: Pcolormesh Plot...\n');

% Create data
n_mesh = 100;
x_mesh = linspace(0, 1, n_mesh);
y_mesh = linspace(0, 1, n_mesh);
[X_mesh, Y_mesh] = meshgrid(x_mesh, y_mesh);
Z_mesh = sin(pi*X_mesh) .* sin(pi*Y_mesh);

% Create figure
fig = figure('Position', [100, 100, 800, 700]);
set(fig, 'Color', 'w');
pcolor(X_mesh, Y_mesh, Z_mesh);
shading interp;
colormap(viridis_colormap());
c = colorbar;
c.Label.String = 'Solution';
c.Label.Interpreter = 'latex';
c.Label.FontSize = 12;

axis equal tight;
xlabel('$x$', 'FontSize', 14);
ylabel('$y$', 'FontSize', 14);
title('Solution', 'FontSize', 16);
set(gca, 'FontSize', 12);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_matplotlib_pcolormesh.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_matplotlib_pcolormesh.png\n');
end

%% ========================================================================
%  FIGURE 22: HDF5 DATASPACE FULL (4x6 GRID)
% =========================================================================
fprintf('\nGenerating Figure 22: HDF5 Dataspace Full...\n');

fig = figure('Position', [100, 100, 700, 500]);
set(fig, 'Color', 'w');
hold on;

% Draw grid
rows = 4;
cols = 6;

for i = 0:rows
    plot([0 cols], [i i], 'k-', 'LineWidth', 1.5);
end
for j = 0:cols
    plot([j j], [0 rows], 'k-', 'LineWidth', 1.5);
end

% Fill cells
for i = 0:(rows-1)
    for j = 0:(cols-1)
        fill([j j+1 j+1 j], [i i i+1 i+1], [0.8 0.9 1], 'EdgeColor', 'k', 'LineWidth', 1);
    end
end

% Add cell indices
for i = 0:(rows-1)
    for j = 0:(cols-1)
        text(j+0.5, i+0.5, sprintf('(%d,%d)', i, j), ...
             'HorizontalAlignment', 'center', 'FontSize', 9);
    end
end

% Labels
text(-0.8, rows/2, 'Rows (0-3)', 'Rotation', 90, ...
     'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');
text(cols/2, -0.5, 'Columns (0-5)', ...
     'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');

axis equal;
axis off;
xlim([-1.5 cols+0.5]);
ylim([-1 rows+0.5]);
title('HDF5 Dataspace: Rank=2, Dimensions=[4, 6]', 'FontSize', 14);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_hdf5_dataspace_full.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_hdf5_dataspace_full.png\n');
end

%% ========================================================================
%  FIGURE 23: HDF5 DATASPACE WITH SELECTION
% =========================================================================
fprintf('\nGenerating Figure 23: HDF5 Dataspace Selection...\n');

fig = figure('Position', [100, 100, 700, 500]);
set(fig, 'Color', 'w');
hold on;

% Draw grid
for i = 0:rows
    plot([0 cols], [i i], 'k-', 'LineWidth', 1.5);
end
for j = 0:cols
    plot([j j], [0 rows], 'k-', 'LineWidth', 1.5);
end

% Fill cells (selected vs non-selected)
for i = 0:(rows-1)
    for j = 0:(cols-1)
        if (i >= 1 && i <= 2 && j >= 2 && j <= 4)
            % Selected region - highlight in yellow
            fill([j j+1 j+1 j], [i i i+1 i+1], [1 1 0.6], ...
                 'EdgeColor', 'k', 'LineWidth', 2.5);
        else
            % Non-selected - gray
            fill([j j+1 j+1 j], [i i i+1 i+1], [0.85 0.85 0.85], ...
                 'EdgeColor', [0.6 0.6 0.6], 'LineWidth', 1);
        end
    end
end

% Add cell indices to selected region
for i = 1:2
    for j = 2:4
        text(j+0.5, i+0.5, sprintf('(%d,%d)', i, j), ...
             'HorizontalAlignment', 'center', 'FontSize', 9, 'FontWeight', 'bold');
    end
end

% Labels
text(-0.8, rows/2, 'Rows', 'Rotation', 90, ...
     'HorizontalAlignment', 'center', 'FontSize', 12);
text(cols/2, -0.5, 'Columns', ...
     'HorizontalAlignment', 'center', 'FontSize', 12);

axis equal;
axis off;
xlim([-1.5 cols+0.5]);
ylim([-1 rows+0.5]);
title('Hyperslab Selection: Rows 1-2, Columns 2-4', 'FontSize', 14);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_hdf5_dataspace_selection.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_hdf5_dataspace_selection.png\n');
end

%% ========================================================================
%  FIGURE 24: HDF5 DATA TRANSFER (FILE TO MEMORY)
% =========================================================================
fprintf('\nGenerating Figure 24: HDF5 Data Transfer...\n');

fig = figure('Position', [100, 100, 1100, 500]);
set(fig, 'Color', 'w');

% Left subplot: File dataspace
subplot(1, 2, 1);
hold on;

% Draw grid
for i = 0:rows
    plot([0 cols], [i i], 'k-', 'LineWidth', 1.5);
end
for j = 0:cols
    plot([j j], [0 rows], 'k-', 'LineWidth', 1.5);
end

% Fill cells
for i = 0:(rows-1)
    for j = 0:(cols-1)
        if (i >= 1 && i <= 2 && j >= 2 && j <= 4)
            fill([j j+1 j+1 j], [i i i+1 i+1], [1 1 0.6], ...
                 'EdgeColor', 'k', 'LineWidth', 2.5);
        else
            fill([j j+1 j+1 j], [i i i+1 i+1], [0.85 0.85 0.85], ...
                 'EdgeColor', [0.6 0.6 0.6], 'LineWidth', 1);
        end
    end
end

axis equal;
axis off;
xlim([-0.5 cols+0.5]);
ylim([-0.5 rows+0.5]);
title('File Dataspace (4$\times$6)', 'FontSize', 14);

% Right subplot: Memory buffer
subplot(1, 2, 2);
hold on;

% Draw smaller grid (2x3 for selected region)
buffer_rows = 2;
buffer_cols = 3;

for i = 0:buffer_rows
    plot([0 buffer_cols], [i i], 'k-', 'LineWidth', 1.5);
end
for j = 0:buffer_cols
    plot([j j], [0 buffer_rows], 'k-', 'LineWidth', 1.5);
end

% Fill buffer with highlight color
for i = 0:(buffer_rows-1)
    for j = 0:(buffer_cols-1)
        fill([j j+1 j+1 j], [i i i+1 i+1], [1 1 0.6], ...
             'EdgeColor', 'k', 'LineWidth', 2.5);
    end
end

axis equal;
axis off;
xlim([-0.5 buffer_cols+0.5]);
ylim([-0.5 buffer_rows+0.5]);
title('Memory Buffer (2$\times$3)', 'FontSize', 14);

% Add main title
sgtitle('Data Transfer: File $\rightarrow$ Memory', 'FontSize', 16);

if DOWNLOAD
    print(fig, fullfile(output_dir, 'placeholder_hdf5_dataspace_transfer.png'), '-dpng', '-r300');
    fprintf('  Saved: placeholder_hdf5_dataspace_transfer.png\n');
end

%% ========================================================================
%  HELPER FUNCTION: VIRIDIS COLORMAP
% =========================================================================
function cmap = viridis_colormap()
    % Viridis colormap approximation (256 colors)
    viridis_data = [
        0.267004, 0.004874, 0.329415;
        0.268510, 0.009605, 0.335427;
        0.269944, 0.014625, 0.341379;
        0.271305, 0.019942, 0.347269;
        0.272594, 0.025563, 0.353093;
        0.273809, 0.031497, 0.358853;
        0.274952, 0.037752, 0.364543;
        0.276022, 0.044167, 0.370164;
        0.277018, 0.050344, 0.375715;
        0.277941, 0.056324, 0.381191;
        0.278791, 0.062145, 0.386592;
        0.279566, 0.067836, 0.391917;
        0.280267, 0.073417, 0.397163;
        0.280894, 0.078907, 0.402329;
        0.281446, 0.084320, 0.407414;
        0.281924, 0.089666, 0.412415;
        0.282327, 0.094955, 0.417331;
        0.282656, 0.100196, 0.422160;
        0.282910, 0.105393, 0.426902;
        0.283091, 0.110553, 0.431554;
        0.283197, 0.115680, 0.436115;
        0.283229, 0.120777, 0.440584;
        0.283187, 0.125848, 0.444960;
        0.283072, 0.130895, 0.449241;
        0.282884, 0.135920, 0.453427;
        0.282623, 0.140926, 0.457517;
        0.282290, 0.145912, 0.461510;
        0.281887, 0.150881, 0.465405;
        0.281412, 0.155834, 0.469201;
        0.280868, 0.160771, 0.472899;
        0.280255, 0.165693, 0.476498;
        0.279574, 0.170599, 0.479997;
        0.278826, 0.175490, 0.483397;
        0.278012, 0.180367, 0.486697;
        0.277134, 0.185228, 0.489898;
        0.276194, 0.190074, 0.493001;
        0.275191, 0.194905, 0.496005;
        0.274128, 0.199721, 0.498911;
        0.273006, 0.204520, 0.501721;
        0.271828, 0.209303, 0.504434;
        0.270595, 0.214069, 0.507052;
        0.269308, 0.218818, 0.509577;
        0.267968, 0.223549, 0.512008;
        0.266580, 0.228262, 0.514349;
        0.265145, 0.232956, 0.516599;
        0.263663, 0.237631, 0.518762;
        0.262138, 0.242286, 0.520837;
        0.260571, 0.246922, 0.522828;
        0.258965, 0.251537, 0.524736;
        0.257322, 0.256130, 0.526563;
        0.255645, 0.260703, 0.528312;
        0.253935, 0.265254, 0.529983;
        0.252194, 0.269783, 0.531579;
        0.250425, 0.274290, 0.533103;
        0.248629, 0.278775, 0.534556;
        0.246811, 0.283237, 0.535941;
        0.244972, 0.287675, 0.537260;
        0.243113, 0.292092, 0.538516;
        0.241237, 0.296485, 0.539709;
        0.239346, 0.300855, 0.540844;
        0.237441, 0.305202, 0.541921;
        0.235526, 0.309527, 0.542944;
        0.233603, 0.313828, 0.543914;
        0.231674, 0.318106, 0.544834;
        0.229739, 0.322361, 0.545706;
        0.227802, 0.326594, 0.546532;
        0.225863, 0.330805, 0.547314;
        0.223925, 0.334994, 0.548053;
        0.221989, 0.339161, 0.548752;
        0.220057, 0.343307, 0.549413;
        0.218130, 0.347432, 0.550038;
        0.216210, 0.351535, 0.550627;
        0.214298, 0.355619, 0.551184;
        0.212395, 0.359683, 0.551710;
        0.210503, 0.363727, 0.552206;
        0.208623, 0.367752, 0.552675;
        0.206756, 0.371758, 0.553117;
        0.204903, 0.375746, 0.553533;
        0.203063, 0.379716, 0.553925;
        0.201239, 0.383670, 0.554294;
        0.199430, 0.387607, 0.554642;
        0.197636, 0.391528, 0.554969;
        0.195860, 0.395433, 0.555276;
        0.194100, 0.399323, 0.555565;
        0.192357, 0.403199, 0.555836;
        0.190631, 0.407061, 0.556089;
        0.188923, 0.410910, 0.556326;
        0.187231, 0.414746, 0.556547;
        0.185556, 0.418570, 0.556753;
        0.183898, 0.422383, 0.556944;
        0.182256, 0.426184, 0.557120;
        0.180629, 0.429975, 0.557282;
        0.179019, 0.433756, 0.557430;
        0.177423, 0.437527, 0.557565;
        0.175841, 0.441290, 0.557685;
        0.174274, 0.445044, 0.557792;
        0.172719, 0.448791, 0.557885;
        0.171176, 0.452530, 0.557965;
        0.169646, 0.456262, 0.558030;
        0.168126, 0.459988, 0.558082;
        0.166617, 0.463708, 0.558119;
        0.165117, 0.467423, 0.558141;
        0.163625, 0.471133, 0.558148;
        0.162142, 0.474838, 0.558140;
        0.160665, 0.478540, 0.558115;
        0.159194, 0.482237, 0.558073;
        0.157729, 0.485932, 0.558013;
        0.156270, 0.489624, 0.557936;
        0.154815, 0.493313, 0.557840;
        0.153364, 0.497000, 0.557724;
        0.151918, 0.500685, 0.557587;
        0.150476, 0.504369, 0.557430;
        0.149039, 0.508051, 0.557250;
        0.147607, 0.511733, 0.557049;
        0.146180, 0.515413, 0.556823;
        0.144759, 0.519093, 0.556572;
        0.143343, 0.522773, 0.556295;
        0.141935, 0.526453, 0.555991;
        0.140536, 0.530132, 0.555659;
        0.139147, 0.533812, 0.555298;
        0.137770, 0.537492, 0.554906;
        0.136408, 0.541173, 0.554483;
        0.135066, 0.544853, 0.554029;
        0.133743, 0.548535, 0.553541;
        0.132444, 0.552216, 0.553018;
        0.131172, 0.555899, 0.552459;
        0.129933, 0.559582, 0.551864;
        0.128729, 0.563265, 0.551229;
        0.127568, 0.566949, 0.550556;
        0.126453, 0.570633, 0.549841;
        0.125394, 0.574318, 0.549086;
        0.124395, 0.578002, 0.548287;
        0.123463, 0.581687, 0.547445;
        0.122606, 0.585371, 0.546557;
        0.121831, 0.589055, 0.545623;
        0.121148, 0.592739, 0.544641;
        0.120565, 0.596422, 0.543611;
        0.120092, 0.600104, 0.542530;
        0.119738, 0.603785, 0.541400;
        0.119512, 0.607464, 0.540218;
        0.119423, 0.611141, 0.538982;
        0.119483, 0.614817, 0.537692;
        0.119699, 0.618490, 0.536347;
        0.120081, 0.622161, 0.534946;
        0.120638, 0.625828, 0.533488;
        0.121380, 0.629492, 0.531973;
        0.122312, 0.633153, 0.530398;
        0.123444, 0.636809, 0.528763;
        0.124780, 0.640461, 0.527068;
        0.126326, 0.644107, 0.525311;
        0.128087, 0.647749, 0.523491;
        0.130067, 0.651384, 0.521608;
        0.132268, 0.655014, 0.519661;
        0.134692, 0.658636, 0.517649;
        0.137339, 0.662252, 0.515571;
        0.140210, 0.665859, 0.513427;
        0.143303, 0.669459, 0.511215;
        0.146616, 0.673050, 0.508936;
        0.150148, 0.676631, 0.506589;
        0.153894, 0.680203, 0.504172;
        0.157851, 0.683765, 0.501686;
        0.162016, 0.687316, 0.499129;
        0.166383, 0.690856, 0.496502;
        0.170948, 0.694384, 0.493803;
        0.175707, 0.697900, 0.491033;
        0.180653, 0.701402, 0.488189;
        0.185783, 0.704891, 0.485273;
        0.191090, 0.708366, 0.482284;
        0.196571, 0.711827, 0.479221;
        0.202219, 0.715272, 0.476084;
        0.208030, 0.718701, 0.472873;
        0.214000, 0.722114, 0.469588;
        0.220124, 0.725509, 0.466226;
        0.226397, 0.728888, 0.462789;
        0.232815, 0.732247, 0.459277;
        0.239374, 0.735588, 0.455688;
        0.246070, 0.738910, 0.452024;
        0.252899, 0.742211, 0.448284;
        0.259857, 0.745492, 0.444467;
        0.266941, 0.748751, 0.440573;
        0.274149, 0.751988, 0.436601;
        0.281477, 0.755203, 0.432552;
        0.288921, 0.758394, 0.428426;
        0.296479, 0.761561, 0.424223;
        0.304148, 0.764704, 0.419943;
        0.311925, 0.767822, 0.415586;
        0.319809, 0.770914, 0.411152;
        0.327796, 0.773980, 0.406640;
        0.335885, 0.777018, 0.402049;
        0.344074, 0.780029, 0.397381;
        0.352360, 0.783011, 0.392636;
        0.360741, 0.785964, 0.387814;
        0.369214, 0.788888, 0.382914;
        0.377779, 0.791781, 0.377939;
        0.386433, 0.794644, 0.372886;
        0.395174, 0.797475, 0.367757;
        0.404001, 0.800275, 0.362552;
        0.412913, 0.803041, 0.357269;
        0.421908, 0.805774, 0.351910;
        0.430983, 0.808473, 0.346476;
        0.440137, 0.811138, 0.340967;
        0.449368, 0.813768, 0.335384;
        0.458674, 0.816363, 0.329727;
        0.468053, 0.818921, 0.323998;
        0.477504, 0.821444, 0.318195;
        0.487026, 0.823929, 0.312321;
        0.496615, 0.826376, 0.306377;
        0.506271, 0.828786, 0.300362;
        0.515992, 0.831158, 0.294279;
        0.525776, 0.833491, 0.288127;
        0.535621, 0.835785, 0.281908;
        0.545524, 0.838039, 0.275626;
        0.555484, 0.840254, 0.269281;
        0.565498, 0.842430, 0.262877;
        0.575563, 0.844566, 0.256415;
        0.585678, 0.846661, 0.249897;
        0.595839, 0.848717, 0.243329;
        0.606045, 0.850733, 0.236712;
        0.616293, 0.852709, 0.230052;
        0.626579, 0.854645, 0.223353;
        0.636902, 0.856542, 0.216620;
        0.647257, 0.858400, 0.209861;
        0.657642, 0.860219, 0.203082;
        0.668054, 0.861999, 0.196293;
        0.678489, 0.863742, 0.189503;
        0.688944, 0.865448, 0.182725;
        0.699415, 0.867117, 0.175971;
        0.709898, 0.868751, 0.169257;
        0.720391, 0.870350, 0.162603;
        0.730889, 0.871916, 0.156029;
        0.741388, 0.873449, 0.149561;
        0.751884, 0.874951, 0.143228;
        0.762373, 0.876424, 0.137064;
        0.772852, 0.877868, 0.131109;
        0.783315, 0.879285, 0.125405;
        0.793760, 0.880678, 0.120005;
        0.804182, 0.882046, 0.114965;
        0.814576, 0.883393, 0.110347;
        0.824940, 0.884720, 0.106217;
        0.835270, 0.886029, 0.102646;
        0.845561, 0.887322, 0.099702;
        0.855810, 0.888601, 0.097452;
        0.866013, 0.889868, 0.095953;
        0.876168, 0.891125, 0.095250;
        0.886271, 0.892374, 0.095374;
        0.896320, 0.893616, 0.096335;
        0.906311, 0.894855, 0.098125;
        0.916242, 0.896091, 0.100717;
        0.926106, 0.897330, 0.104071;
        0.935904, 0.898570, 0.108131;
        0.945636, 0.899815, 0.112838;
        0.955300, 0.901065, 0.118128;
        0.964894, 0.902323, 0.123941;
        0.974417, 0.903590, 0.130215;
        0.983868, 0.904867, 0.136897;
        0.993248, 0.906157, 0.143936
    ];
    
    % Interpolate to 256 colors
    x_in = linspace(0, 1, size(viridis_data, 1));
    x_out = linspace(0, 1, 256);
    cmap = interp1(x_in, viridis_data, x_out);
end

%% ========================================================================
%  SUMMARY
% =========================================================================
% fprintf('\n=== Figure Generation Complete ===\n');
% fprintf('Total figures generated: 10\n');
% fprintf('Output directory: %s\n', output_dir);
% fprintf('\nFigures saved:\n');
% fprintf('  - placeholder_jacobi_convergence.png\n');
% fprintf('  - placeholder_matplotlib_sine_plot.png\n');
% fprintf('  - placeholder_matplotlib_sine_cosine_plot.png\n');
% fprintf('  - placeholder_matplotlib_trig_with_tan.png\n');
% fprintf('  - placeholder_matplotlib_with_axis_limits.png\n');
% fprintf('  - placeholder_matplotlib_with_legend.png\n');
% fprintf('  - placeholder_matplotlib_with_labels.png\n');
% fprintf('  - placeholder_matplotlib_complete.png\n');
% fprintf('  - placeholder_matplotlib_pcolormesh.png\n');
% fprintf('  - placeholder_hdf5_dataspace_full.png\n');
% fprintf('  - placeholder_hdf5_dataspace_selection.png\n');
% fprintf('  - placeholder_hdf5_dataspace_transfer.png\n');
% fprintf('\n=== Done! ===\n');
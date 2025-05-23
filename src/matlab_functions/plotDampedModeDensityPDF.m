function plotDampedModeDensityPDF(data, pressure_list, damping_list, options)
% Plots the PDF of Damped Eigen Modes. Input is a struct with fields :
% 
% pressure, damping, eigenValues, eigen_vectors
% 
% data = *.mat file processed by processEigenModesDamped("in/2d_damped_eigen_small", "out/junkyard", [1, 0.1, 0.01, 0.001]); 
% pressure_list = vector of pressures you want to be plotted
% damping_list = damping list you want to have plotted
% 
% Note: usually you want multiple presssures and a single damping constant
% More note: this assumes that the eigenValues = damping + i frequency
% plotDampedModeDensityPDF("out/2d_damped_eigenStuff/2D_damped_eigenstuff_N400_K100_M1.mat", [.2, .01, .001], [.1])
    arguments
        data % data structure containing eigenvalues and other properties
        pressure_list (1,:) double % list of pressures to plot
        damping_list (1,:) double % list of damping constants to plot
        options.scaling (1,1) logical = false;
    end


    figure
    for i = 1:length(pressure_list)
        pressure = pressure_list(i);

        for j = 1:length(damping_list)
            % positions = [x',y'];  % Assuming x, y are in the loaded .mat file
            % radii = Dn./2;  % Assuming Dn is in the loaded .mat file
            damping_constant = damping_list(j);
            dataPressureDamping = filterData(data, 'pressure', pressure,  'damping', damping_constant);
            eigenValues = dataPressureDamping.eigenValues{1};
            keepIdx = imag(eigenValues) > 0; % keep the positive eigenvalues
            eigenFreqs = abs(imag(eigenValues(keepIdx))); % imag part carries the frequency, abs() because QZ sovler does weird things
            Lx = dataPressureDamping.Lx(1);
            Ly = dataPressureDamping.Ly(1);

            [edges, normalized_counts] = modeDensity(eigenFreqs, "damped",true);

            % --- Verification Step ---
            bin_widths = diff(edges); % Calculate the width of each bin (Length N)
            num_bins = length(bin_widths);
            num_counts = length(normalized_counts);
            counts_for_bins = normalized_counts(1:num_bins); 
            integral_approx = sum(counts_for_bins .* bin_widths);
            fprintf('Area Under PDF = %.6f\n', integral_approx);
            % --- End Verification Step ---
            
            if length(pressure_list) == 1
                [~, marker_color] = normVarColor(damping_list, damping_constant, 1);
            else
                [~, marker_color] = normVarColor(pressure_list, pressure, 1);
            end
            if length(damping_list) == 1
                markerSize = 6;
            else
                markerSize = exp(dataPressureDamping.damping/max(damping_list))*3;
            end
            pressureValue = dataPressureDamping.pressure;
            binCenters = sqrt( edges(1:end-1) .* edges(2:end) ); 
            pressureLabel = sprintf('$ %.4f, %.4f $', dataPressureDamping.pressure, dataPressureDamping.damping); 
            gammaHalf = .5*damping_constant;
            omegaKnee = sqrt(pressureValue)*sqrt(1-gammaHalf^2);

            if options.scaling
                loglog(binCenters/omegaKnee^(1), normalized_counts/omegaKnee^0, '-o', 'MarkerSize', markerSize, 'MarkerFaceColor', marker_color, 'MarkerEdgeColor', marker_color, 'Color', marker_color, 'DisplayName', pressureLabel);
                xlabel('$\omega/\omega_\gamma$', 'Interpreter', 'latex', 'FontSize', 20)
                ylabel('$D(\omega)/\omega_\gamma^{1/4}$', 'Interpreter', 'latex', 'FontSize', 20)
            else
                plot(binCenters, normalized_counts, '-o', 'MarkerSize', markerSize, 'MarkerFaceColor', marker_color, 'MarkerEdgeColor', marker_color, 'Color', marker_color, 'DisplayName', pressureLabel);
                xlabel('$\omega_\gamma$', 'Interpreter', 'latex', 'FontSize', 20)
                ylabel('$D(\omega_\gamma)$', 'Interpreter', 'latex', 'FontSize', 20)
            end

            title(sprintf('$L_x$ by $L_y$: %.2f by %.2f', Lx, Ly), 'Interpreter', 'latex', 'FontSize', 16);
            set(gca, "XScale", "log")
            set(gca, "YScale", "log")
            grid on; 
            hold on;
        end
        legend('show', 'Interpreter', 'latex');
        leg = legend('show', 'Location', 'northeastoutside', 'Interpreter', 'latex', 'FontSize', 15);
        title(leg, "$  \hat{P}, \hat{\gamma} $")
        ax = gca;
        ax.FontSize = 20;
    end

end
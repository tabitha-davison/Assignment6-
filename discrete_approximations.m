function discrete_approximations(mode_shape, total_mass, string_length, tension_force, damping_coefficient)

    rho = total_mass / string_length;
    c = sqrt(tension_force / rho);
    wn_continuous = c * pi * mode_shape / string_length;
    discrete_range = 1:500;

    wn_discrete = zeros(1, length(discrete_range));
    relative_error = zeros(1, length(discrete_range));

    for i = discrete_range
        % Update system parameters for current number of masses
        dx = string_length / (i + 1);
        string_params = struct();
        string_params.n = i;
        string_params.M = total_mass;
        string_params.Tf = tension_force;
        string_params.L = string_length;
        string_params.c = damping_coefficient;
        string_params.dx = dx;

        % Compute discrete frequency
        [M_mat, K_mat] = construct_2nd_order_matrices(string_params);
        [~, lambda] = eig(K_mat, M_mat);

        % Check if mode_shape is valid and assign NaN value if not
        if mode_shape > size(lambda, 1)
            wn_discrete(i) = NaN;
            relative_error(i) = NaN; 
        else
            wn_discrete(i) = sqrt(lambda(mode_shape, mode_shape));
            relative_error(i) = abs(wn_discrete(i)-wn_continuous) / wn_continuous;
        end
    end

    figure(3);
    semilogy(discrete_range, relative_error, 'r-', 'LineWidth', 2);
    grid on;
    title('Approximation Error of Discrete Resonant Frequency');
    xlabel('Number of Masses');
    ylabel('Relative Error');
    ylim([1e-5, 1]);

end
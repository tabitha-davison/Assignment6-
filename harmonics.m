function harmonics(masses, max_harmonics, total_mass, tension_force, string_length, c, plot_title)
    
    wn_continuous = @(n) c * pi * n / string_length;
    
    % Parameters
    dx = string_length / (masses + 1);
    string_params = struct();
    string_params.n = masses;
    string_params.M = total_mass;
    string_params.Tf = tension_force;
    string_params.L = string_length;
    string_params.c = c;
    string_params.dx = dx;

    [M_mat, K_mat] = construct_2nd_order_matrices(string_params);
    [~, lambda_mat] = eig(K_mat, M_mat);

    discrete_frequencies = zeros(1, max_harmonics);
    continuous_frequencies = zeros(1, max_harmonics);

    for n = 1:max_harmonics
        continuous_frequencies(n) = wn_continuous(n); 
        if n <= size(lambda_mat, 1)
            discrete_frequencies(n) = sqrt(lambda_mat(n, n)); 
        else
            discrete_frequencies(n) = NaN; % Skip if mode is invalid
        end
    end

    figure (1); hold on;
    figure (2); hold on;
    plot(1:max_harmonics, continuous_frequencies, 'bo-', 'LineWidth', 1.5, 'DisplayName', 'Continuous');
    plot(1:max_harmonics, discrete_frequencies, 'ro--', 'LineWidth', 1.5, 'DisplayName', 'Discrete');
    hold off;

    grid on;
    title(plot_title);
    xlabel('Harmonic Index, n');
    ylabel('Temporal Frequency (rad/s)');
    legend('Location', 'best');
end


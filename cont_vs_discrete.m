function cont_vs_discrete(mode_shape, masses, total_mass, string_length, tension_force, c)
    
    x_values = linspace(0, string_length, masses + 2);

    % discrete_Xn_values = zeros(1, string_length);
    % continuous_Xn_values = zeros(size(x_values));

    Xn_continuous = sin((x_values * pi * mode_shape / string_length));

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
    [M_mode, ~] = eig(K_mat, M_mat);
  
    % for i = 1:length(x_values)
    %     continuous_Xn_values(i) = Xn_continuous(x_values(i));
    % end

    % Xn_continuous = Xn_continuous*(norm(M_mode)/norm(Xn_continuous))

    hold on
    discrete_mode = M_mode(:,mode_shape);
    discrete_mode = (discrete_mode*(norm(Xn_continuous)/norm(discrete_mode)))';
    plot(x_values,discrete_mode,'r','LineWidth',4);
    % plot(x_values(2:end-1),discrete_mode(2:end-1),'ko','MarkerFaceColor','k','MarkerSize',5);
    % plot([x_values(1),x_values(end)],[discrete_mode(1),discrete_mode(end)],'bo','MarkerFaceColor','b','MarkerSize',5);

    plot(x_values,Xn_continuous,'b','LineWidth',2);
    % plot(x_values(2:end-1),Xn_continuous(2:end-1),'ko','MarkerFaceColor','k','MarkerSize',5);
    % plot([x_values(1),x_values(end)],[Xn_continuous(1),Xn_continuous(end)],'bo','MarkerFaceColor','b','MarkerSize',5);

    legend('Discrete', 'Continuous')
    hold off

end
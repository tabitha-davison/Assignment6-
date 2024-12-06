function string_simulation_template01()
    
    mode_shape = 3;
    num_masses = 30;
    total_mass = 1;
    tension_force = 3000;
    string_length = 4;
    damping_coeff = 0.000001;
    dx = string_length/(num_masses+1);
    amplitude_Uf = 0.15;
    
    %generate the struct
    string_params = struct();
    string_params.n = num_masses;
    string_params.M = total_mass;
    string_params.Tf = tension_force;
    string_params.L = string_length;
    string_params.c = damping_coeff;
    string_params.dx = dx;
    %initial conditions
    U0 = zeros(1,num_masses)';
    dUdt0 = zeros(1,num_masses)';
    V0 = [U0;dUdt0];
    tspan = linspace(0,100,2000);

    [M_mat,K_mat] = construct_2nd_order_matrices(string_params);

    [Ur_mat,lambda_mat] = eig(K_mat,M_mat);

    omega_Uf = sqrt(-lambda_mat(mode_shape,mode_shape))
    % omega_Uf = 0.3;
    %list of x points (including the two endpoints)
    xlist = linspace(0,string_length,num_masses+2);
    
    Uf_func = @(t_in) amplitude_Uf*cos(omega_Uf*t_in);
    dUfdt_func = @(t_in) -omega_Uf*amplitude_Uf*sin(omega_Uf*t_in);

    string_params.Uf_func = Uf_func;
    string_params.dUfdt_func = dUfdt_func;

    subplot(2,1,1)
    hold on
    ydata = Ur_mat(:,mode_shape);
    plot(xlist,ydata,'r','LineWidth',2);
    plot(xlist(2:end-1),ydata(2:end-1),'ko','MarkerFaceColor','k','MarkerSize',5);
    plot([xlist(1),xlist(end)],[ydata(1),ydata(end)],'bo','MarkerFaceColor','b','MarkerSize',5);
    hold off

    %run the integration
    my_rate_func = @(t_in,V_in) string_rate_func01(t_in,V_in,string_params);
    [tlist,Vlist] = ode45(my_rate_func,tspan,V0);



    %your code to generate an animation of the system
    subplot(2,1,2)
    hold on
    axis([0, 4, -1.5, 1.5])

    plot1 = plot(0,0,'r','LineWidth',2);
    % plot2 = plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',5);
    plot2 = plot(0,0);
    plot3 = plot(0,0,'bo','MarkerFaceColor','b','MarkerSize',5);

    for i=1:length(tlist)

        Uplot = [0,Vlist(i,1:num_masses),Uf_func(tlist(i))];

        set(plot1,'xdata',xlist,'ydata',Uplot);
        set(plot2,'xdata',xlist(2:end-1),'ydata',Uplot(2:end-1));
        set(plot3,'xdata',[xlist(1),xlist(end)],'ydata',[Uplot(1),Uplot(end)]);
        
        drawnow;
    end
    hold off

end
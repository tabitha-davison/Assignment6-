function string_simulation_template01()

    num_masses = 3;
    total_mass = 1;
    tension_force = 30;
    string_length = 4;
    damping_coeff = 0.01;
    dx = string_length/(num_masses+1);
    amplitude_Uf = 0.15;
    omega_Uf = 0.03;
    %list of x points (including the two endpoints)
    xlist = linspace(0,string_length,num_masses+2);
    Uf_func = @(t_in) amplitude_Uf*cos(omega_Uf*t_in);
    dUfdt_func = @(t_in) -omega_Uf*amplitude_Uf*sin(omega_Uf*t_in);
    %generate the struct
    string_params = struct();
    string_params.n = num_masses;
    string_params.M = total_mass;
    string_params.Uf_func = Uf_func;
    string_params.dUfdt_func = dUfdt_func;
    string_params.Tf = tension_force;
    string_params.L = string_length;
    string_params.c = damping_coeff;
    string_params.dx = dx;
    %initial conditions
    U0 = 0*[0.1,0.1,0.1]';
    dUdt0 = 0*[0.02,0.02,0.02]';
    V0 = [U0;dUdt0];
    tspan = linspace(0,50,2000);
    %run the integration
    my_rate_func = @(t_in,V_in) string_rate_func01(t_in,V_in,string_params);
    [tlist,Vlist] = ode45(my_rate_func,tspan,V0);

    %your code to generate an animation of the system
    figure(1);
 
    hold on
    axis([0, 4, -1.5, 1.5])

    plot1 = plot(0,0,'r','LineWidth',2);
    plot2 = plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',5);
    plot3 = plot(0,0,'bo','MarkerFaceColor','b','MarkerSize',5);

    for i=1:length(tlist)
        
        Uplot = [0,Vlist(i,1:num_masses),Uf_func(tlist(i))];
       
        set(plot1,'xdata',xlist,'ydata',Uplot);
        set(plot2,'xdata',xlist(2:end-1),'ydata',Uplot(2:end-1));
        set(plot3,'xdata',[xlist(1),xlist(end)],'ydata',[Uplot(1),Uplot(end)]);


        % plot([xlist(1),xlist(2)], [0, Vlist(i,1)], 'b-', 'LineWidth', 1);
        % plot([xlist(2),xlist(3)], [Vlist(i,1), Vlist(i,2)], 'b-', 'LineWidth', 1);
        % plot([xlist(3),xlist(4)], [Vlist(i,2), Vlist(i,3)], 'b-', 'LineWidth', 1);
        % plot([xlist(4),xlist(5)], [Vlist(i,3), Uf_func(tlist(i))], 'b-', 'LineWidth', 1);
        % plot(xlist(1),0, "bo")
        % plot(xlist(2),Vlist(i,1), "r.", 'MarkerSize', 50)
        % plot(xlist(3),Vlist(i,2), "r.", 'MarkerSize', 50)
        % plot(xlist(4),Vlist(i,3), "r.", 'MarkerSize', 50)
        % plot(xlist(5),Uf_func(tlist(i)), "bo")
        drawnow;
    end


end
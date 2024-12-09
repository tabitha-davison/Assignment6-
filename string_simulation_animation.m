function string_simulation_animation()

    mode_shape = 1;
    num_masses = 3000;
    total_mass = 1;
    tension_force = 0.001;
    string_length = 6;
    damping_coeff = 0;
    dx = string_length/(num_masses+1);
    amplitude_Uf = 0.75;
    
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
    tspan = linspace(0,1000,2000);


    [M_mat,K_mat] = construct_2nd_order_matrices(string_params);

    [Ur_mat,lambda_mat] = eig(K_mat,M_mat);
    omega_Uf = sqrt(lambda_mat(mode_shape,mode_shape));

    %list of x points (including the two endpoints)
    xlist = linspace(0,string_length,num_masses+2);

    w = 1/omega_Uf;
    h =amplitude_Uf;
    c = sqrt(tension_force/(total_mass/string_length));

    Uf_func = @(t_in) b_spline_pulse(t_in,w,h);
    dUfdt_func = @(t_in) b_spline_pulse_derivative(t_in,w,h);

    string_params.Uf_func = Uf_func;
    string_params.dUfdt_func = dUfdt_func;

    %run the integration
    my_rate_func = @(t_in,V_in) string_rate_func01(t_in,V_in,string_params);
    [tlist,Vlist] = ode45(my_rate_func,tspan,V0);

    %your code to generate an animation of the system
    figure(1)
    hold on
    axis([0, string_length, -amplitude_Uf, amplitude_Uf])

    plot1 = plot(0,0,'r','LineWidth',2);
    % plot2 = plot(0,0,'ko','MarkerFaceColor','k','MarkerSize',5);
    plot2 = plot(0,0);
    plot3 = plot(0,0,'bo','MarkerFaceColor','b','MarkerSize',5);
    xlin = xline(0);

    x_list = [];

    for i=1:length(tlist)

        Uplot = [0,Vlist(i,1:num_masses),Uf_func(tlist(i))];

        set(plot1,'xdata',xlist,'ydata',Uplot);
        set(plot2,'xdata',xlist(2:end-1),'ydata',Uplot(2:end-1));
        set(plot3,'xdata',[xlist(1),xlist(end)],'ydata',[Uplot(1),Uplot(end)]);
            
        %short blurb showing how to find x-coord of tracking line
        %x = x-coord of tracking line, t = current time
        %c = wave speed, w = pulse width (in time), L = string length
        x = string_length-c*tlist(i)+.5*w*c;
        x = mod(x,2*string_length);

        if x > string_length
            x = 2*string_length - x;
        end

        x_list = [x_list, x];

        delete(xlin);
        xlin = xline(x);

        drawnow;

    end

end

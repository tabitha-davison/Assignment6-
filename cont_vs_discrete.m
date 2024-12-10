function cont_vs_discrete(cont_mode, discrete_mode, cont_lambda, discrete_lambda, fig_number)
    discrete_mode = discrete_mode * (norm(cont_mode)/norm(discrete_mode));
    
    figure(fig_number)
    hold on
    plot(cont_lambda, cont_mode)
    plot(discrete_lambda, discrete_mode)
    hold off

end
function [X_n, resonant_frequency] = mod_anal_wave_eq(n, X, Bn_value, L, c)
    Bn = zeros(1,length(X));
    Bn(n) = Bn_value;
    
    for i = 1:length(X)
        X_n(i) = Bn(i) * sin(((pi*n)/L)*X(i));
    end

    resonant_frequency = c * (pi*n/L);

end

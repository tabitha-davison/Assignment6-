%build the mass and stiffness matrices that describe the 2nd order system.
%INPUTS
%string_params: a struct containing the system parameters describing the string
% string_params.n: number of masses
% string_params.M: total mass attached to the string
% string_params.Uf_func: function describing motion of end point
% string_params.dUfdt_func: time derivative of Uf
% string_params.Tf: %tension in string
% string_params.L: %length of string
% string_params.c: %damping coefficient
% string_params.dx: %horizontal spacing between masses
%OUTPUTS
%M_mat: the n x n mass (inertia) matrix
%K_mat: the n x n stiffness matrix
function [M_mat,K_mat] = construct_2nd_order_matrices(string_params)
   
    % construct the nxn discrete laplacian matrix
    n = string_params.n+2;
    % Create the identity matrix
    I_n = eye(n);
    
    % Construct the tridiagonal matrix using circshift
    my_Laplacian = -2 * I_n + circshift(I_n, 1) + circshift(I_n, -1);
    
    my_Laplacian(1,end) = my_Laplacian(1,end)-1; %delete unwanted 1 in top right corner
    my_Laplacian(end,1) = my_Laplacian(end,1)-1; %delete unwanted 1 in bottom right corner

    M_mat = string_params.M/n*I_n;
    K_mat = -string_params.Tf/string_params.dx*my_Laplacian;

end
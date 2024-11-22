    n = 5+2;
    I_n = eye(n) % build the nxn identity matrix
    my_Laplacian = I_n*-2;

    circshift(my_Laplacian, [0,1])
    % doing this as subtracting deals with the weird edge cases
    % that occur when n=1 and n=2
    my_Laplacian(1,end) = my_Laplacian(1,end)-1; %delete unwanted 1 in top right corner
    my_Laplacian(end,1) = my_Laplacian(end,1)-1; %delete unwanted 1 in bottom right corner
    my_Laplacian
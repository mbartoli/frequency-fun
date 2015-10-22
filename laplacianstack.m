function [ X1, X2, X3, X4 ] = laplacianstack( I1, I2, I3, I4, I5 )
    
    I1 = I1 - I2;
    I2 = I2 - I3;
    I3 = I3 - I4;
    I4 = I4 - I5;
    
    X1 = normalize3(I1);
    X2 = normalize3(I2);
    X3 = normalize3(I3);
    X4 = normalize3(I4);


end


function [ X1, X2, X3, X4, X5 ] = gaussianstack( I )

    x = 201;
    y = 201;

    X1 = imfilter(I, fspecial('Gaussian', [x y], 2));
    X2 = imfilter(I, fspecial('Gaussian', [x y], 4));
    X3 = imfilter(I, fspecial('Gaussian', [x y], 8));
    X4 = imfilter(I, fspecial('Gaussian', [x y], 16));
    X5 = imfilter(I, fspecial('Gaussian', [x y], 32));


end


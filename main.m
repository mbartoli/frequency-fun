%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.
clear all
close all


%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
% input_dir = './pomona/';
% output_dir = './output/';
% file_ext = 'JPG';
% file_names = dir([input_dir '*.' file_ext]); 


%% Part 0

orig = rgb2gray(imread('Lenna.png'));

new = sharpen(orig);

figure
montage([orig, new], 'Size', [1 1]);

return;
%% Part 1
I1 = rgb2gray(imresize(im2double(imread('./Selection_003.png')),  [100 100]));
I2 = rgb2gray(imresize(im2double(imread('./Selection_004.png')),  [100 100]));

F1 = fftshift(fft2(I1));
F2 = fftshift(fft2(I2));

% Changes in angle/phase are more important than changes in magnitude
% Magnitude changes the the intensity/luminosity of the image
% Angle/phase warps the image

M1 = abs(F1);
M2 = abs(F2);

P1 = angle(F1);
P2 = angle(F2);

I1 = ifft2(ifftshift(M1 .* exp(1i * P1))); 
I2 = ifft2(ifftshift(M2 .* exp(1i * P2))); 

figure
subplot(1,2,1)
imshow(I1)
subplot(1,2,2)
imshow(I2)

%% Part 2


% I = im2double(imread('./Selection_003.png'));
% J = im2double(imread('./Selection_004.png'));
% 
% I = rgb2gray(imread('./Selection_003.png'));
% J = rgb2gray(im2double(imread('./Selection_004.png')));


I = im2double(imread('./Selection_003.png'));
J = rgb2gray(im2double(imread('./Selection_004.png')));
J = cat(3, J, J, J);


figure
title('Select the eyes');
imshow(I)
[x1, y1] = ginput(1);
close
 
figure
title('Select the left eye');
imshow(J)
[x2, y2] = ginput(1);
close
 
shiftx = floor(x1 - x2);
shifty = floor(y1 - y2);
 
J = circshift(J, [shiftx shifty]);
     
I = imfilter(I, fspecial('Gaussian',29, 7));
 
J = J - imfilter(J, fspecial('Gaussian', 9, 2));
 
K = I + J;

figure
imshow(I)
figure
imshow(J)
figure
imshow(K)

%% Part 3

I = rgb2gray(im2double(imread('./dali.jpg')));
J = im2double(imread('./dali.jpg'));

x = 201;
y = 201;

I1 = imfilter(I, fspecial('Gaussian', [x y], 2));
I2 = imfilter(I, fspecial('Gaussian', [x y], 4));
I3 = imfilter(I, fspecial('Gaussian', [x y], 8));
I4 = imfilter(I, fspecial('Gaussian', [x y], 16));
I5 = imfilter(I, fspecial('Gaussian', [x y], 32));
 
% Black and White 
figure
montage([I, I1, I2, I3, I4, I5], 'Size', [1 1]);


L1 = I1 - I2;
L2 = I2 - I3;
L3 = I3 - I4;
L4 = I4 - I5;

% Normalize the images
L1 = normalize(L1);
L2 = normalize(L2);
L3 = normalize(L3);
L4 = normalize(L4);



figure
M = montage([I, L1, L2, L3, L4], 'Size', [1 1]);

imwrite(get(M, 'CData'), 'montage.png', 'png');


J1 = imfilter(J, fspecial('Gaussian', [x y], 2));
J2 = imfilter(J, fspecial('Gaussian', [x y], 8));
J3 = imfilter(J, fspecial('Gaussian', [x y], 16));
J4 = imfilter(J, fspecial('Gaussian', [x y], 32));
J5 = imfilter(J, fspecial('Gaussian', [x y], 64));



% Color
figure
montage([J, J1, J2, J3, J4, J5], 'Size', [1 1]);




%% Part 4

I = im2double(imread('./hand.png'));

[ height, width, depth ] = size(I)

J = im2double(imread('./eye.png'));

[ h, w, d ] = size(J)

R = im2double(imread('./eyemask.png'));

[ h2, w2, d2 ] = size(R)

% I = rgb2gray(I);
% J = rgb2gray(J);

[ I1, I2, I3, I4, I5 ] = gaussianstack(I);
[ I1, I2, I3, I4 ] = laplacianstack(I1, I2, I3, I4, I5);

[ J1, J2, J3, J4, J5 ] = gaussianstack(J);
[ J1, J2, J3, J4] = laplacianstack(J1, J2, J3, J4, J5);

% Make image R with 1s on left half and 0s on right half

% a = zeros(height, width / 2);
% b = ones(height, width / 2);
% R = cat(2, b, a);
% R = cat(3, R, R, R);

[ R1, R2, R3, R4, R5 ] = gaussianstack(R);

LS1 = R1 .* I1 + (1 - R1) .* J1;
LS2 = R2 .* I2 + (1 - R2) .* J2;
LS3 = R3 .* I3 + (1 - R3) .* J3;
LS4 = R4 .* I4 + (1 - R4) .* J4;
LS5 = R5 .* I5 + (1 - R5) .* J5;


figure
montage([LS1, LS2, LS3, LS4, LS5], 'Size', [1 1]);

LST = LS1 + LS2 + LS3 + LS4 + LS5;

LSTAVG = LST / 5;
LSTNORM = normalize3(LST);

figure
montage([LSTAVG, LSTNORM], 'Size', [1 1]);




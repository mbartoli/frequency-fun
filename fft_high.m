%% Code implementing ideal high pass filter

%% Standard cleanup
clear all
close all

%% Grab an input file and convert to gray scale
input_dir = '../../data/pomona/small/'
input_ext = 'JPG';
files = dir([input_dir '*.' input_ext])';
I = sum(im2double(imread([input_dir files(4).name])), 3) / 3;

%% Compute Fourier transform of input image
J = fftshift(fft2(I));

%% Display the image and Fourier transform
figure
subplot(1,3,1)
imshow(I)
subplot(1,3,2)
imagesc(log(1 + abs(J)))
axis equal; axis tight; axis off;
subplot(1,3,3)
imshow(I)

%% Compute center pixel location
[ysz xsz] = size(I);
xcr = floor(xsz / 2);
ycr = floor(ysz / 2);

%% Get user input
% Warning you must click on the Fourier transform image
[x y] = ginput(1);
x = x - xcr;
y = y - ycr;
r = (x^2 + y^2)^0.5

%% Block out selected pixels in Fourier transform
% I am being lazy and using for-loops
JJ = J;
for xi = 1:xsz
    cxi = xi - xcr;
    for yi = 1:ysz
        cyi = yi - ycr;
        if (cxi^2 + cyi^2)^0.5 < r
            JJ(yi,xi) = 0;
        end
    end
end


%% Invert modified Fourier transform
II = ifft2(ifftshift(JJ));

%% Display results
subplot(1,3,2)
imagesc(log(1 + abs(JJ)))
axis equal; axis tight; axis off;
subplot(1,3,3)
imshow(real(II))

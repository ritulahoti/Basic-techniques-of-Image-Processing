clc
close all

%%%%%%% Read a coloured garden image %%%%%%%%
I=imread("scenary.jpg");

%%%%%%% Split RGB image into individual channels %%%%%%%%
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%%%%%%% Convert RGB to Grayscale %%%%%%%%%
gray=(R+G+B)/3;
% gray=(0.9*R+0.85*G+B)/3;

figure,
subplot(1,2,1), imshow(I), title('Original RGB Image');
subplot(1,2,2), imshow(gray), title('Grayscale Image');
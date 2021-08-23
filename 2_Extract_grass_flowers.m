clc
close all

%%%%%%% Read a coloured garden image %%%%%%%%
% I=imread("garden.jpg");
I=imread("garden4.jpg");

%%%%%%% Split RGB image into individual channels %%%%%%%%
R=I(:,:,1);
G=I(:,:,2);
B=I(:,:,3);

%%%%%%% Extract grass-flowers %%%%%%%%
grass=I-(0.97*R+0.57*B);
grassMask=im2bw(grass,0);

R1=immultiply(R,grassMask);
G1=immultiply(G,grassMask);
B1=immultiply(B,grassMask);
grass=cat(3,R1,G1,B1);

flowers=I-(0.98*G);
flowersMask=im2bw(flowers,0.1);
R2=immultiply(R,flowersMask);
G2=immultiply(G,flowersMask);
B2=immultiply(B,flowersMask);
flowers=cat(3,R2,G2,B2);

%%%%%%% Display %%%%%%
figure,
subplot(1,3,1), imshow(I), title('Original Image');
subplot(1,3,2), imshow(grass), title('Grass extracted');
subplot(1,3,3), imshow(flowers), title('Flowers extracted');
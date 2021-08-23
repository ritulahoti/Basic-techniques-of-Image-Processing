clc
clear all
close all

%%%%%%%%% Input from user %%%%%%%%%%%%%%%
disp('Enter the values:');
r=input('No. of rows on the chess board: ');
c=input('No. of columns on the chess board: ');
disp('Enter the pixel intensity values between 0 and 1');
b=input('Pixel intensity closer to 0: ');
w=input('Pixel intensity closer to 1: ');

%%%%%%%%% Draw the desired checkerboard %%%%%%%%%%%%%%%
A=zeros(r,c); %Initialize a matrix with zeros

for i=1:r
    for j=1:c
        if mod(j,2)==1 && mod(i,2)==1
            A(i,j) = b;
        elseif mod(j,2)==0 && mod(i,2)==0
            A(i,j) = b;
        else
            A(i,j) = w;
        end
    end
end
 
%%%%%%%%% Display the checkerboard %%%%%%%%%%%%%%%
figure, imshow(A,'InitialMagnification','fit'), xlabel(c), ylabel(r), title("Intensity values: " + b + " and " + w)
        
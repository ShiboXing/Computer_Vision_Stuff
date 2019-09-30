
function [energyImage, Ix, Iy] = energy_image(im)   
    im1=double(rgb2gray(im));
    f1=[1 0 -1;2 0 -2;1 0 -1];%sobel vertical 
    f2=[1 2 1;0 0 0;-1 -2 -1];%sobel horizontal
    Ix=imfilter(im1,f1);
    Iy=imfilter(im1,f2);
    energyImage=(Ix.^2+ Iy.^2).^0.5;
end
%load and show two images, extract pixel information
img1=imread('keble1.png');
img2=imread('keble2.png');
figure
subplot(1,2,1);
imshow(img1);
subplot(1,2,2);
imshow(img2);
impixelinfo

%extract 4 correspondences
PA=[253 102;184 155;230 224;338 15];
PB=[159 114;85 168;132 238;241 32];

%compute the homography
H=estimate_homography(PA,PB);
pt=[184,155];
apply_homography(pt,H)
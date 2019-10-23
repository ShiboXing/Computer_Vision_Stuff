%load and show two images, extract pixel information
img1=imread('keble1.png');
img2=imread('keble2.png');
figure;
imshow(img1);
impixelinfo;
figure;
imshow(img2);
impixelinfo;

%extract 4 correspondences
PA=[253 102;184 155;230 224;338 15];
PB=[159 114;85 168;132 238;241 32];

%compute the homography
H=estimate_homography(PA,PB);

%pick a new point and apply the homography
pt=[217; 181];  
matched_pt=apply_homography(pt,H);

figure
subplot(1,2,1);
imshow(img1);
hold on;
plot(pt(1), pt(2), 'g*', 'LineWidth', 5, 'MarkerSize',1);
subplot(1,2,2);
imshow(img2);
hold on;
plot(matched_pt(1), matched_pt(2), 'y*', 'LineWidth', 5, 'MarkerSize', 1);
hold off
saveas(gcf,'keble_onept.png');








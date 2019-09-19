"part 2 started"
%2
img_files=dir("woman*");
im1=imresize(rgb2gray(imread(img_files(1).name)),[512,512]);
im2=imresize(rgb2gray(imread(img_files(2).name)),[512,512]);

%3
im1_blur=imgaussfilt(im1,10,'FilterSize', 31);
im2_blur=imgaussfilt(im2,10,'FilterSize', 31);

%4
im2_detail=im2-im2_blur;
figure
imshow(im2_detail)
"part 2 finished"

%5
figure
imshow(im1_blur+im2_detail)
saveas(gcf, 'hybrid.png');


%Part III test
%{
figure;
[a b c]=(energy_image(imread("woman_happy.png")));
subplot(2,2,1)
imagesc(b)
subplot(2,2,2)
imagesc(c)
subplot(2,2,3) 
imagesc(a) 
%}

%{
im1=imread("prague.jpg");
im1_energy=energy_image(im1);
im1_energy_map=cumulative_minimum_energy_map(im1_energy,'HORIZONTAL');
displaySeam(im1,find_optimal_horizontal_seam(im1_energy_map),"HORIZONTAL");
im1_energy_map=cumulative_minimum_energy_map(im1_energy,'VERTICAL');
displaySeam(im1,find_optimal_vertical_seam(im1_energy_map),"VERTICAL");
%}

%im1=imread("prague.jpg");
%reduceWidth(im1,1);

generate_results('prague.jpg',70,'HORIZONTAL');
generate_results('prague.jpg',70,'VERTICAL');

%{
im1=imread("mall.jpg");
im1_energy=energy_image(im1);
im1_energy_map=cumulative_minimum_energy_map(im1_energy,'HORIZONTAL');
displaySeam(im1,find_optimal_horizontal_seam(im1_energy_map),'HORIZONTAL');
%}




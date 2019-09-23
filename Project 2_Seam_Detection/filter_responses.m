%3 and 4
"part 1 started..."
F=makeLMfilters;
img_files=["cardinal1.jpg","cardinal2.jpg","leopard1.jpg","leopard2.jpg","panda1.jpg","panda2.jpg"]
imgs={};
    
for i=1:size(img_files,2)
    %grayscale
    imgs{i}=rgb2gray(imresize(imread(img_files(1,i)),[300,300]));
    figure 
    imshow(imgs{i})
    img_files(1,i)
end

for i=1:size(F,3)  
    f=F(:,:,i);
    figure
    subplot(2,4,1);
    imagesc(imresize(f,[300,300]));
    for j=1:size(img_files,2)
        %cross-correlation
        tmp=imfilter(imgs{j},f);
        %4 
        subplot(2,4,j+2);
        imagesc(tmp);
        title(img_files(1,j));
        %5
        if i==35
            saveas(gcf,'different_animals_similar.png');
        elseif i==44
            saveas(gcf, 'same_animal_similar.png');
        end
    end
end
"part 1 finished"










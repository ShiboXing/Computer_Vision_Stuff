function [reducedColorImage] = reduceWidth(im, display_flag)
    im_energy=energy_image(im);
    M = cumulative_minimum_energy_map(im_energy, 'VERTICAL');
    seam=find_optimal_vertical_seam(M);

    rows=size(im,1);
    cols=size(im,2);
    channels=size(im,3);

    assert(size(seam,1) == rows);
    reducedColorImage=zeros([rows,cols-1,channels]);
    for i=1:rows
        for j=1:channels
            curr_row=im(i,:,j);
            curr_row(seam(i))=[];
            reducedColorImage(i,:,j)=curr_row;
        end
    end
    reducedColorImage=uint8(reducedColorImage);
    if(display_flag)
            figure;
            subplot(1, 3, 1); imagesc(im_energy);
            subplot(1, 3, 2); imagesc(M);
            subplot(1, 3, 3); imshow(im);
            displaySeam(im, seam, 'VERTICAL');
    end
    
end
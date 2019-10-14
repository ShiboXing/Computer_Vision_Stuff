 function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
    %initializing
    [rlen,clen,~]=size(origImg);
    num_of_pixels=rlen*clen;
    outputImg=double(origImg);
    
    %calculating the means
    [clusterIds,meanColors]=kmeans(reshape(outputImg,num_of_pixels,3),k);
    outputImg=reshape(outputImg,num_of_pixels,3);
    for i=1:num_of_pixels
        outputImg(i,:)=meanColors(clusterIds(i),:);
    end
    
    %convert to uint8 and display
    outputImg=uint8(reshape(outputImg,rlen,clen,3));
    figure 
    imshow(outputImg);
    
    
    
end
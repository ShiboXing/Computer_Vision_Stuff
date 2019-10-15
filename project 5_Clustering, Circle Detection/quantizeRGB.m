 function [outputImg, meanColors, clusterIds] = quantizeRGB(origImg, k)
    %initializing
    [rlen,clen,~]=size(origImg);
    num_of_pixels=rlen*clen;
    outputImg=double(origImg);
    
    %calculating the means
    [clusterIds,meanColors]=kmeans(reshape(outputImg,num_of_pixels,3),k);
    outputImg=reshape(outputImg,num_of_pixels,3);
    %convert all pixels to their cluster means
    for i=1:num_of_pixels
        outputImg(i,:)=meanColors(clusterIds(i),:);
    end
    
    %convert to uint8 and display
    outputImg=uint8(reshape(outputImg,rlen,clen,3));
    figure 
    subplot(1,2,1);
    imshow(origImg);
    title('original img');
    subplot(1,2,2);
    fname=strcat('kmeans img (k=',int2str(k),')');
    imshow(outputImg);
    title(fname);
  
end
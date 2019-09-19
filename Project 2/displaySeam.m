function displaySeam (im,seam,seamDirection)
    figure
    imshow(im);
    hold on
    if strcmp(seamDirection,"HORIZONTAL")
        plot(seam','vr');
        
    elseif strcmp(seamDirection,"VERTICAL")
       
        X=seam';
        Y=[1:1:size(seam,1)];
        plot(X,Y,'vr');
    end
    


end

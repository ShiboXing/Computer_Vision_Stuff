function [] = generate_results(filename, reduceAmt, reduceWhat)
    im=imread(filename);
    ans=im;
    agno=im;
    if strcmp(reduceWhat,"VERTICAL")
        %agno=imresize(agno, [size(im,1) size(im,2)-reduceAmt]);
        for i=1:reduceAmt
            ans=reduceWidth(ans,0);
        end
    elseif strcmp(reduceWhat,"HORIZONTAL")
        %agno=imresize(agno, [size(im,1)-reduceAmt size(im,2)]);
        for i=1:reduceAmt
            ans=reduceHeight(ans,0);
        end
    end

    figure 
    subplot(1,3,2)
    imshow(ans);
    subplot(1,3,1)
    imshow(im);
    %subplot(1,3,3);
    %imshow(agno);
end
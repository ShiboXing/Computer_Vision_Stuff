function [centers] = detectCircles(im, edges, radius, top_k)
    %initialization
    [rlen,clen]=size(im);
    quantization_value=3;
    H=zeros(rlen,clen);
    %collect the houghspace votes
    for i =1 :length(edges)
       x=edges(i,1);
       y=edges(i,2);
       mag=edges(i,3);
       dir=edges(i,4);
       a=x-radius*cosd(dir);
       b=y-radius*sind(dir);
       if a<1 || a >=clen || b<1 || b >=rlen
           continue;
       end
       tmpa=ceil(a/quantization_value);
       tmpb=ceil(b/quantization_value);
       H(tmpa,tmpb)=H(tmpa,tmpb)+1; 
    end

    %collect the top k votes
    topK_arr=zeros(1,top_k+1);
    for i=1:rlen*clen
        topK_arr(top_k+1)=H(i);
        topK_arr=sort(topK_arr,'descend');
    end
    topK_arr=unique(topK_arr(1:top_k));
    centers=[];
    for i=1:length(topK_arr)
        [x,y]= find(H==topK_arr(i));
        centers=[centers; [x y]];
    end
    centers=centers(1:top_k,:);
    
    %recover the top k circle centers
    centers=centers*quantization_value;
    figure;
    imshow(im);
    fname=strcat('radius: ',int2str(radius),' top\_K: ',int2str(top_k));
    viscircles(centers, radius * ones(size(centers, 1), 1));
    title(fname);
    saveas(gcf,'egg_circles.png');

end
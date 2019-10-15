function [centers] = detectCircles(im, edges, radius, top_k)
    center=zeros(top_k,1);
    [rlen,clen]=size(im);
    quantization_value=5;
    H=zeros(rlen,clen);
    
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

    
    topK_arr=zeros(1,top_k+1);
    for i=1:rlen*clen
        topK_arr(top_k+1)=H(i);
        topK_arr=sort(topK_arr,'descend');
    end
    topK_arr=unique(topK_arr(1:top_k));
    pos=[];
    for i=1:length(topK_arr)
        [x,y]= find(H==topK_arr(i));
        pos=[pos; [x y]];
    end
    pos=pos(1:top_k,:)
    pos=pos*quantization_value;
    figure;
    imshow(im);
    viscircles(pos, radius * ones(size(pos, 1), 1));
   
    
    
    max(max(H))
    


end
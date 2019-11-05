 function [pyramid, level_0, level_1, level_2] = computeSPMRepr(sift, means)
    f=sift.f;
    d=sift.d;
    %{
    size(means)
    size(f)
    size(d)
    %}
%1a: level 0 representation
    level_0=computeBOWRepr(double(d'),means);
    
%1b: level 1 representation
    xseg=size(d,2)/2;
    yseg=size(d,1)/2;
    spaces=cell(2);
    for i=1:size(f,2)
        curr=f(:,i);
        x=min(floor(round(curr(1))/xseg)+1,2);
        y=min(floor(round(curr(2))/yseg)+1,2);
        spaces{y,x}=[spaces{y,x};d(:,i)'];
    end
    %spaces
    %compute BOW for each quadrant
    level_1=[];
    for i=1:2
       for j=1:2 
            if (size(spaces{i,j},1)==0)
                    spaces{i,j}=zeros(1,128);
            end
            level_1=[level_1 computeBOWRepr(double(spaces{i,j}),means)];
            %size(spaces{i,j})
       end
    end
    
    
%1c: level 2 representation
    spaces=cell(4);
    xseg=size(d,2)/4;
    yseg=size(d,1)/4;
    for i=1:size(f,2)
        curr=f(:,i);
        x=min(floor(round(curr(1))/xseg)+1,4);
        y=min(floor(round(curr(2))/yseg)+1,4);
        spaces{y,x}=[spaces{y,x};d(:,i)'];
    end
    %compute BOW for each quadrant
    level_2=[];
    for i=1:4
       for j=1:4
            if (size(spaces{i,j},1)==0)
                spaces{i,j}=zeros(1,128);
            end
            
            level_2=[level_2 computeBOWRepr(double(spaces{i,j}),means)];
       end
    end
    
    pyramid=[level_0 level_1 level_2];
    
    
 end
 
 
 %bow from hw4
 function [bow_repr] = computeBOWRepr(features, means)
   %II1
   bow_repr=double(zeros(size(means,1)));
   
   %II2
   distances=pdist2(features,means);  
   
   %II3
   [~,I]=min(distances,[],2);
   for i=1:length(I)
      bow_repr(I(i))= bow_repr(I(i))+1;
   end
   
   %II4
   bow_repr=(bow_repr/sum(bow_repr))'; 
   
end
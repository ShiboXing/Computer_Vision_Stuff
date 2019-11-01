 function [pyramid, level_0, level_1, level_2] = computeSPMRepr(sift, means)
    f=sift.f;
    d=sift.d;
    %{
    size(means)
    size(f)
    size(d)
    %}
    xseg=size(d,2)/2;
    yseg=size(d,1)/2;
%1a: level 0 representation
    level_0=computeBOWRepr(double(d'),means);
    pyramid=cell(1,3);
    pyramid{1,1}=level_0;
    
%1b: level 1 representation
    spaces=cell(2);
    for i=1:size(f,2)
        curr=f(:,i);
        x=min(floor(round(curr(1))/xseg)+1,2);
        y=min(floor(round(curr(2))/yseg)+1,2);
        spaces{y,x}=[spaces{y,x};d(:,i)'];
    end
    %spaces
    %compute BOW for each quadrant
    for i=1:2
       for j=1:2 
            spaces{i,j}=computeBOWRepr(double(spaces{i,j}),means);
       end
    end
    level_1=spaces;
    pyramid{1,2}=level_1;
    %spaces
    
    
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
    for i=1:4
       for j=1:4
            spaces{i,j}=computeBOWRepr(double(spaces{i,j}),means);
       end
    end
    level_2=spaces;
    pyramid{1,3}=level_2;
    %spaces
 end
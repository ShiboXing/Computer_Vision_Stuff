

function [features] = compute_features(x, y, scores, Ix, Iy)
    n=5; %window size is 5
    i=1;
    rlen=size(Ix,1);
    clen=size(Ix,2);
    
    %I1 remove the keypoints that do not have n*n neighbors
    while i<=size(x,2)
       if x(i)<=n || x(i)>clen-n || y(i)<=n || y(i)>rlen-n
            x(i)=[];
            y(i)=[];
            scores(i)=[];
            i=i-1;
       end
       i=i+1;
    end
    
    %I2 I3 I4 I5
    i=1;
    while i<=size(x,2)
        hist=zeros(1,8);
        for a=y(i)-n:y(i)+n
           for b=x(i)-n:x(i)+n
               %calculate magnitude and theta
               m=(Ix(a,b)^2+Iy(a,b)^2)^0.5;
               theta=atand(Iy(a,b)/Ix(a,b));
               
               %populate the histogram
               index=min(int8((theta+90)/22.5)+1,8);%clip the result by 9, in case theta is 90 degree.
               hist(index)=hist(index)+m;
           end
        end
        hist=hist/sum(hist);
        hist=min(hist,0.2);
        hist=hist/sum(hist);
        i=i+1;
    end
    
    
    
end
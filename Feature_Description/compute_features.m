

function [features] = compute_features(x, y, scores, Ix, Iy)
    n=5; %window size is 5
    [rlen,clen]=size(Ix);
    i=1;
    
    %I1 remove the keypoints that do not have n*n neighbors
    while i<=length(x)
       if x(i)<=n || x(i)>clen-n || y(i)<=n || y(i)>rlen-n
            x(i)=[];
            y(i)=[];
            scores(i)=[];
            i=i-1;
       end
       i=i+1;
    end
    
    %I2 I3 I4 I5
    features=double(zeros(length(x),8));
    for i=1:length(x)
        hist=zeros(1,8);
        for a=y(i)-n:y(i)+n
           for b=x(i)-n:x(i)+n
               %calculate magnitude and theta
               m=sqrt(Ix(a,b)^2+Iy(a,b)^2);
               theta=atand(Iy(a,b)/Ix(a,b));
               
               if isnan(theta)
                  %add nothing if m==0
                  if Iy(a,b)>0
                     hist(8)=hist(8)+m;
                  elseif Iy(a,b)<0
                      hist(1)=hist(1)+m;
                  end
                  continue
                end
                
               %calculate the index, quantize the orientations
               index=min(uint8(floor((theta+90)/22.5))+1,8);%clip the result by 8, in case theta is 90 degree.
               %populate the SIFT histogram
               hist(index)=hist(index)+m;
           end
        end
        %normalize and clip the histogram
        hist=hist/sum(hist);
        hist(hist>0.2)=0.2;
        hist=hist/sum(hist);
        features(i,:)=hist;
        
    end
end


function [features] = compute_features(x, y, scores, Ix, Iy)
    n=5; %window size is 5
    i=1;
    rlen=size(Ix,1);
    clen=size(Ix,2);
    
    %I1
    while i<=size(x,2)
       if x(i)<n || x(i)>clen-n || y(i)<n || y(i)>rlen-n
            x(i)=[];
            y(i)=[];
            scores(i)=[];
            i=i-1;
       end
       i=i+1;
    end
    
    %I2 I3
    i=1;
    while i<=size(x,2)
        m=zeros(n,n);
        theta=zeros(n,n);
        hist=zeros(1,8);
        for a=x(i)-n:x(i)+n
           for b=y(i)-n:y(i)+n
               aa=a-x(i)+n;
               bb=b-y(i)+n;
               m(aa,bb)=(Ix(a,b)^2+Iy(a,b)^2)^0.5;
               theta(aa,bb)=atand(Iy(a,b)/Ix(a,b));
           end
        end
        theta
        i=i+1;
        
    end
    
end
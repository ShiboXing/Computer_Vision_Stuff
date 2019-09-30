function [x,y,scores,Ih,Iv]=extract_keypoints(image)
    %part a
    k=0.05;
    n=2;%window size=5
    
    rows=size(image,1);
    cols=size(image,2);
    im1=double(rgb2gray(image));
    f1=[-1 0 1;-2 0 2;-1 0 1];%sobel vertical 
    f2=f1';%sobel horizontal
    Iv=imfilter(im1,f1);
    Ih=imfilter(im1,f2);
   
    
    %part b
    %calculating M and R for each pixel
    R=double(zeros(rows,cols));
    for i=1:rows
       for j=1:cols
           M=double(zeros(2,2));
           for ii=i-n:i+n
              for jj=j-n:j+n
                  %skip if neighbors are out of bound
                  if ii<1 || ii>rows || jj<1 || jj>cols
                        continue
                  end
                  M=M+[Ih(ii,jj)^2 Ih(ii,jj)*Iv(ii,jj); Ih(ii,jj)*Iv(ii,jj) Iv(ii,jj)^2];
                  
              end 
           end
           
           detM=double(det(M));
           trM=double(trace(M));
           R(i,j)=detM - k*(trM^2);
       end
    end
    
  
   
    %part c, setting the threshold to values top 1 percent
    tmp=sort(R(:)');
    Threshold=tmp(1,uint16(rows)*uint16(cols)-uint16(double(rows)*double(cols)*0.01));
    
    x=[];
    y=[];
    scores=[];
     for i=1:rows
       for j=1:cols
           if R(i,j)>Threshold
                  skip=0;
                  for a=i-n:i+n
                     for b=j-n:j+n
                        if a>0 && a<rows && b>0 && b<cols && a~=i && b~=j && R(a,b) > R(i,j)
                            skip=1;
                        end
                     end
                  end
                  if skip==1
                     continue 
                  end
              
               x=[x i];
               y=[y j];
               scores=[scores R(i,j)];
           end
       end
     end
   
     
    %part d
    tmp_x=[];
    tmp_y=[];
    tmp_scores=[];
    
    for i=1:size(scores,2)
        %eliminating edge pixels
       if x(1,i)>1 && x(1,i)<cols && y(1,i)>1 && y(1,i)<rows
         
          tmp_x=[tmp_x x(1,i)];
          tmp_y=[tmp_y y(1,i)];
          tmp_scores=[tmp_scores scores(1,i)];
          
       end
    end
    
    x=tmp_x;
    y=tmp_y;
    scores=tmp_scores;
    
  
    %part e
    figure
    imagesc(image);
    hold on
    
    for i=1:size(scores,2)
        if scores(i)>0
            plot( y(i),x(i), 'bo', 'MarkerSize',scores(i) / (10^11));
        end
    end
    
    saveas(gcf, 'vis1.png');
end

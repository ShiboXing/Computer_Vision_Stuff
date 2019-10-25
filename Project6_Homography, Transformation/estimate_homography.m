function[H] = estimate_homography(PA, PB)
   A=[];
   
   %construct the A matrix
   for i=1:size(PA,1)
      tmp_1=[-PA(i,1) -PA(i,2) -1 0 0 0 PA(i,1)*PB(i,1) PA(i,2)*PB(i,1) PB(i,1)];
      tmp_2=[0 0 0 -PA(i,1) -PA(i,2) -1 PA(i,1)*PB(i,2) PA(i,2)*PB(i,2) PB(i,2)];
      A=[A;tmp_1;tmp_2];
   end
   
   %generate the H homography
   [~,~,V]=svd(A);
   h=V(:,end);
   H=reshape(h,3,3)';
   
end

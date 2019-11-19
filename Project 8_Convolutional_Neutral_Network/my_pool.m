function [Output] = my_pool(Input, Pool_Size)

   N=size(Input,1);
   out_size=floor(N/Pool_Size);
   Output=zeros(out_size,out_size);
   a=1;
   for i=1:Pool_Size:N
      b=1;
      for j=1:Pool_Size:N
         if (i+Pool_Size-1>N || j+Pool_Size-1>N)
             break;
         end
         Output(a,b)=max(max(Input(i:i+Pool_Size-1,j:j+Pool_Size-1)));
         b=b+1;
      end
      a=a+1;
   end
end
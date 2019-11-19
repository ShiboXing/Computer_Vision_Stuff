function [Output] = my_conv(Image, Filter, Padding, Stride)

   %add padding 
   Filter=Filter';
   N=size(Image,1);
   F=size(Filter,1);
   out_size=(Padding+N-F)/Stride+1;
   Output=zeros(out_size,out_size);
   
   a=1;
   for i=1:Stride:N
       b=1;
       for j=1:Stride:N
           if (i+F-1>N || j+F-1>N)
               break; 
           end 
           Output(a,b)=sum(sum(Image(i:i+F-1,j:j+F-1).*Filter));
           b=b+1;
       end
       a=a+1;
   end
end
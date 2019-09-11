%1
a=5.*randn(1,1000000);%===================================

%2
tic;
for i=1:size(a,2)
    a(1,i)=a(1,i)+1;
end
toc %in seconds

%3
tic;
a=a+1;
disp(toc)

%4
x=0:2:99;
y=2.^x;
xticks(x);
plot(x,y);

%5
A=reshape(1:1:100,[10,10]);
B=reshape(zeros(1,100),[10,10]);
C=A+B
%assert(all(C(:) == (1:100)') == 1)

%6
arr=1:1:10;
arr=arr(randperm(length(arr)));

for i=1:size(arr,2)
    arr(i)
    pause(1);
end

%7
A=rand(5,3)
B=rand(3,5)
C=zeros(5,5);
for i=1:size(A,1)
    for j=1:size(B,2)
        tmpsum=0;
        for k=1:size(A,2)
            tmpsum=tmpsum+A(i,k)*B(k,j);
        end
        C(i,j)=tmpsum;
    end
end
C
correct=A*B
compare=zeros(5,5);
for i=1:size(C,1)
    for j=1:size(C,2)
        compare(i,j)=C(i,j)==correct(i,j);
    end
end
compare

%12
ori_img=imread('pittsburgh.png');
size(ori_img)

%13
img=rgb2gray(ori_img);

%14
sum(img(:)==6)

%15 
[r,c]=find(img==min(min(img)))

%16
for i=r-15:r+15
   for j=c-15:c+15
       img(i,j)=255;
   end
end

%17
a=size(ori_img,1);
b=size(ori_img,2);
img(a/2-60:a/2+60,b/2-60:b/2+60)=repmat(150,121,121);

%18
figure
imshow(img);
saveas(gcf, 'new_image.png');

%19
rsum=0.0;
gsum=0.0;
bsum=0.0;
a=size(ori_img,1);
b=size(ori_img,2);

for i=1:a
    for j=1:b
        rsum=rsum+double(ori_img(i,j,1));
        gsum=gsum+double(ori_img(i,j,2));
        bsum=bsum+double(ori_img(i,j,3));
    end
end
ravg=rsum/(a*b);
gavg=gsum/(a*b);
bavg=bsum/(a*b);
for i=1:a
    for j=1:b
        ori_img(i,j,1)=ori_img(i,j,1)-ravg;
        ori_img(i,j,2)=ori_img(i,j,2)-gavg;
        ori_img(i,j,3)=ori_img(i,j,3)-bavg;
    end
end
figure
imshow(ori_img);
saveas(gcf, 'mean_sub.png');




%A=[4 4 4 4 4;1 1 1 1 1;2 2 2 2 2;4 4 4 4 4;1 1 1 1 1;3 3 3 3 3;1 1 1 1 1;2 2 2 2 2];
%normalize_rows(A)
%normalize_columns(A)
%fib(40)
%my_unique(A)













A = [1 ; 1];
B = [2 3;1 1];
X=A\B


v=1:.5:3 % a step from 1 to 3 stesize is 0.5
v= pi*[-4:4]/4 %[start:stpesize:end]
v=[]

m=zeros(2,3)   %2*3 matrix of zeros
v=ones(1,3)    %creates a 1*3 matrix (row vector)
m=eye(3)       % identity atrix
m=[1 2 3 4; 5 7 8 7; 9 10 11 12; 13 14 15 16]
m(1,3) 
m(2,:)
m(:,1)
m(1,1:3)
m(5)    %traverse the matrix column-major, return the 5th one
m(10)   

m=[1 2 3; 4 5 6]
size(m)
size(m,1)
size(m,2)
sum(m) %summations of each column
sum(m') %summations of each row
sum(m,2) %sum over the columns
%sum(sum(m)) %total sum


A={[1 4 3; 0 5 8; 7 2 9],'anne smith',0.0}
A{1}
A{1}(1,1) %return first elemnt of the first cell
B=[1 2 3; 4 5 6]
C=repmat(B,1,3)
C=repmat(B,2,3)
m
sum(m)
sum(m,1)
sum(m,2)

a=[1 2 3 4]
a*2
a+5
5+a
a/4  
4./a % 4/a gives an error
a./4    
%{
b=[5 6 7 8]
a+b
a+b'
power(a,3)
a=[1 4 6 3]
max(a)
std(a)  %std deviation
mean(a)
[vals,inds]=sort(a) %vals is the result and inds is the corresponding indices
b=[4;5;6]
a=[1;2;3]
a'*b
a==b %compare element by element
a=[1 2 3;4 5 6; 7 8 9]
b=[1 2 3;4 2 3;7 2 3]
a==b

all(ans)
b=7.5
format long
b
a(1,:)
a=logical([0 1 0 1 1])
b=find(a)
c=[51 6 7 8 9]
c(a)
class(a)
class(c)
eye(3)
rand(3)
a=[eye(3) rand(3)] %catenate eye(3) rand(3) to form a 3*6 matrix
%}

for i=1:2:7
    i
end


for i=[5 13 -1]
    if(i>10)
        disp('>10')
    elseif (i<0)
        disp('<0')
    else
        disp('>0<10')
    end
end
  
A=ones(3,2)
v=2*rand(1,2)
for i=1:3
    A(i,:)=A(i,:)-v
end
    
m=3
n=2
B=zeros(m,n)
for i=1:m
    for j=1:n
        if A(i,j)>0
            B(i,j)=A(i,j)
        end
    end
end

b=ones(2,3)
A=[1 2 0; 3 0 4]
B=A.*(A>0)         %===================

%{
x=[1 2 3 4]
%plot(x)
hold on
plot(x.^2)
legend('sin','cos')
hold off
%}

a=[1 2 3 4]
a./repmat(4,1,4) % same as a./4    =======================
sum(a)



    








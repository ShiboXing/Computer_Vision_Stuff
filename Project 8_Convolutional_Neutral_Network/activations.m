%I1:
weights1=[0.5 0.6 0.4 0.3;0.02 0.25 0.4 0.3;0.82 0.1 0.35 0.3];
weights2=[0.7 0.45 0.5;0.17 0.9 0.8];
X=[10;1;2;3];

%I2:
Z=weights1*X;
    %apply the tanh activation
Z=tanh(Z);
%I3:
Y=weights2*Z;
    %apply the Sigmoid activation on output layer
Y=sigmoid(Y);













function Y=sigmoid(arr)
    Y=zeros(length(arr),1);
    for i =1:length(arr)
       Y(i)=1/(1+exp(-arr(i)));
    end

end




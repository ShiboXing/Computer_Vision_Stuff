%II1:
load('weights_samples.mat');
weights={W1 W2 W3};
inputs={x1 x2 x3 x4};


for i =1:length(weights)
    L=0;
    for j=1:length(inputs)
        scores=weights{i}*inputs{j};
        L=L+hinge_loss(scores,j);
    end
    L=L/length(inputs);
end


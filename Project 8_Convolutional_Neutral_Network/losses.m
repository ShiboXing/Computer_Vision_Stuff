%II1:
load('weights_samples.mat');
weights={W1 W2 W3};
inputs={x1 x2 x3 x4};


for i =1:length(weights)
    L_h=0;%hinge loss
    L_e=0;%cross entropy loss
    for j=1:length(inputs)
        scores=weights{i}*inputs{j};
        L_h=L_h+hinge_loss(scores,j);
        L_e=L_e+cross_entropy_loss(scores,j);
    end
    L_h=L_h/length(inputs);
    
end


%II1:
load('weights_samples.mat');
weights={W1 W2 W3};
inputs={x1 x2 x3 x4};

%II2
for i =1:length(weights)
    strcat('hinge loss for matrix ',int2str(i))
    L_h=compute_loss(weights{i},inputs,'hinge')
    strcat('cross-entropy loss for matrix ',int2str(i))
    L_e=compute_loss(weights{i},inputs,'entropy')
end

function loss = compute_loss(weight,inputs,loss_type)
    L=0;
    for j=1:length(inputs)
        scores=weight*inputs{j};
        if(strcmp(loss_type,'hinge')==1)
            L=L+hinge_loss(scores,j);
        elseif(strcmp(loss_type,'entropy')==1)
            L=L+cross_entropy_loss(scores,j);
        end
    end
    loss=L/length(inputs);
end

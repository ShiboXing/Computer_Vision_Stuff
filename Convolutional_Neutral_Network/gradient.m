load('weights_samples.mat');
weights={W1 W2 W3};
inputs={x1 x2 x3 x4};

%III1:
gradients=compute_gradients(W1,inputs,0.0001);
updated_W1_1=W1-0.001*reshape(gradients,[4,25]);
%{
gradients=compute_gradients(W1,inputs,0.001);
updated_W1_2=W1-h*reshape(gradients,[4,25]);
%}


function gradients=compute_gradients(weight,inputs,h)
    loss=compute_loss(weight,inputs,'hinge');
    weight=weight(:);
    gradients=zeros(size(weight,1),1);
    for i=1:size(weight,1)
       weight_plus_h=weight;
       weight_plus_h(i)=weight_plus_h(i)+h;
       weight_plus_h=reshape(weight_plus_h,[4,25]);
       dh_loss=compute_loss(weight_plus_h,inputs,'hinge');
       gradients(i)=(dh_loss-loss)/h;
    end
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
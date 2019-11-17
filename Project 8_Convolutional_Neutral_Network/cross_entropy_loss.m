 function [loss] = cross_entropy_loss(scores, correct_class)
    loss=0;
    denom=0;
    for j=1:size(scores,1)
        denom=denom+exp(scores(j));
    end
    
    loss=-log(exp(scores(correct_class))/denom);
 
 end
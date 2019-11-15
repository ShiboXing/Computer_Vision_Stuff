function [loss] = hinge_loss(scores, correct_class)
    loss=0;
    for i=1:size(scores,1)
       if (i==correct_class)
           continue
       end
       loss=loss+max(0,scores(i)-scores(correct_class)+1);
    end
end
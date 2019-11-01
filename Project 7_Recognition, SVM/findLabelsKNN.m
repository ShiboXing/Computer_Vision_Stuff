function [predicted_labels_test] = findLabelsKNN(pyramids_train, labels_train, pyramids_test, k)
    dists=pdist2(pyramids_test,pyramids_train);
    
 


end
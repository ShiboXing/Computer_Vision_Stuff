function [predicted_labels_test] = findLabelsKNN(pyramids_train, labels_train, pyramids_test, k)
   
    %calculate pairwise distances between train BOWS and test BOWS
    trainp=cell2mat(pyramids_train);
    testp=cell2mat(pyramids_test);
    dists=pdist2(testp,trainp);
    sorted_dists=sortrows(dists)
    
    
    

end
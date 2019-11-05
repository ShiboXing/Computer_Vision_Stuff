function [predicted_labels_test] = findLabelsSVM(pyramids_train, labels_train, pyramids_test)
    trainp=cell2mat(pyramids_train);
    testp=cell2mat(pyramids_test);
    %build a model using training BOW
    model=fitcecoc(trainp,labels_train);
    predicted_labels_test=predict(model, testp);
    
end
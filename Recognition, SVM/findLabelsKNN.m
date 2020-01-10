function [predicted_labels_test] = findLabelsKNN(pyramids_train, labels_train, pyramids_test, k)
   
    %initialize predicted labels vector
    predicted_labels_test=zeros(size(pyramids_test,1),1);
    %calculate pairwise distances between train BOWS and test BOWS
    trainp=cell2mat(pyramids_train);
    testp=cell2mat(pyramids_test);
    dists=pdist2(testp,trainp);
    for i=1:size(dists,1)
        [~,I]=mink(dists(i,:),k);
        for j=1:size(I,2)
           I(j)=labels_train(I(j));
        end
        %assuming the # of classes is 8
        votes=zeros(1,8);
        for j=1:size(I,2)
           votes(I(j))=votes(I(j))+1;
        end
        [~,label]=max(votes);
        predicted_labels_test(i)=label;
    end
end
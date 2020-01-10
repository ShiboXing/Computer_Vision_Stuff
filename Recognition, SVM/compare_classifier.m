 
    labels=reshape(repmat([1 2 3 4 5 6 7 8],100,1),[800,1]);
%3.2.a b 
    %collect the accuracy values for plotting
    line_segments=zeros(5,4);
    
    %test comparison
    'svm --- test'
    predicted_labels=findLabelsSVM(pyramids_train,labels,pyramids_test);
    svm_accuracy=compute_accuracy(predicted_labels,size(predicted_labels,1))
    %build the plot data
    for k=1:size(line_segments,1)
        line_segments(k,1)=svm_accuracy;
    end
    
    'knn --- test'
    line_cnt=1;
    for k =1:2:9
        predicted_labels=findLabelsKNN(pyramids_train,labels,pyramids_test,k);
        pyramids_accuracy=compute_accuracy(predicted_labels,size(predicted_labels,1))
        %build the plot data
        line_segments(line_cnt,2)=pyramids_accuracy;
        line_cnt=line_cnt+1;
    end
    
    %train comparison
    'svm --- train'
    predicted_labels=findLabelsSVM(pyramids_train,labels,pyramids_train);
    svm_accuracy=compute_accuracy(predicted_labels,size(predicted_labels,1))
    %build the plot data
    for k=1:size(line_segments,1)
        line_segments(k,3)=svm_accuracy;
    end
    'knn --- train'
    line_cnt=1;
    for k =1:2:9
        predicted_labels=findLabelsKNN(pyramids_train,labels,pyramids_train,k);
        pyramids_accuracy=compute_accuracy(predicted_labels,size(predicted_labels,1))  
        %build the plot data
        line_segments(line_cnt,4)=pyramids_accuracy;
        line_cnt=line_cnt+1;
    end
    
%3.2.c
    figure 
    hold on
    x=linspace(1,9,5);
    plot(x,line_segments,'linewidth',2);
    title('comparison of svm and knn labeling with SPM pyramid');
    ylabel('accuracy');
    xlabel('k values');
    legend('svm test accuracy','knn test accuracy','svm train accuracy','knn train accuracy');
    saveas(gcf,'results.png');
    
    
    
function [ratio]=compute_accuracy(predicted_labels,NumOfLabels) 
    correct=0;
    incorrect=0;
    
     %calculate the fraction of correctly predicted labels
    for i=1:NumOfLabels
       if (predicted_labels(i)==floor(i/(NumOfLabels/8)+1)) %50 images in per test class
            correct=correct+1;
       else
            incorrect=incorrect+1;
       end
    end
    ratio=double(correct)/double(correct+incorrect);
end
    

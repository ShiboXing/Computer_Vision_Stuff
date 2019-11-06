%3.1.a
    %read 10 sift descriptors from each class
root='scenes_train/scenes_train/';
dirs={'coast','forest','highway','insidecity','mountain','opencountry','street','tallbuilding'};
data=[];
    %concatenate all the selected descriptors
for i=1:length(dirs)
    path=char(strcat(root,dirs(i)));
    S=dir(fullfile(path,'*.mat'));
    for k = randi([1,100],1,12)
        F = fullfile(path,S(k).name);
        sift= load(F);
        data=[data;sift.d'];
    end
end

%calculate clusters' means using kmeans

[~,means]=kmeans(double(data),50,'MaxIter',2147483647);
save('means.mat','means');

%means=load('means.mat'); 
%means=means.means;


%3.1.b

%build pyramids,level0-level2 for all train
[pyramids_train,l0_train,l1_train,l2_train]=build_pyramids(root,dirs,means);
save('pyramids_train.mat','pyramids_train');

%build pyramids,level0-level2 for all test
root='scenes_test/scenes_test/';
[pyramids_test,l0_test,l1_test,l2_test]=build_pyramids(root,dirs,means);
save('pyramids_test.mat','pyramids_test');


%3.1.c -- compute accuracy for svm pyramids,level0-level2
    labels=reshape(repmat([1 2 3 4 5 6 7 8],100,1),[800,1]);
    %pyramids
    predicted_labels=findLabelsSVM(pyramids_train,labels,pyramids_test);
    pyramids_ratio=compute_accuracy(predicted_labels,size(predicted_labels,1));
    %pyramids_ratio
   
    predicted_labels=findLabelsSVM(l0_train,labels,l0_test);
    pyramids_ratio=compute_accuracy(predicted_labels,size(predicted_labels,1));
    %pyramids_ratio
      
    predicted_labels=findLabelsSVM(l1_train,labels,l1_test);
    pyramids_ratio=compute_accuracy(predicted_labels,size(predicted_labels,1));
    %pyramids_ratio
    
    predicted_labels=findLabelsSVM(l2_train,labels,l2_test);
    pyramids_ratio=compute_accuracy(predicted_labels,size(predicted_labels,1));
    %pyramids_ratio
    
    
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
    title('comparison of svm an knn labeling with SPM pyramid');
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
    

function [pyramids,level0,level1,level2]=build_pyramids(root,dirs,means)

    pyramids=cell(1);
    level0=cell(1);
    level1=cell(1);
    level2=cell(1);
    
    %compute BOWs for all selected descriptors
    for i=1:length(dirs)
        path=char(strcat(root,dirs(i)));
        S=dir(fullfile(path,'*.mat'));
        for k = 1:min(numel(S))
            F = fullfile(path,S(k).name);
            sift= load(F);
            [P,L0,L1,L2]=computeSPMRepr(sift,means);
            pyramids{(i-1)*numel(S)+k,1}=P;
            level0{(i-1)*numel(S)+k,1}=L0;
            level1{(i-1)*numel(S)+k,1}=L1;
            level2{(i-1)*numel(S)+k,1}=L2;
        end
    end
end


   
    





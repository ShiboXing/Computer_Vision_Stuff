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

means=load('means.mat');
means=means.means;

%3.1.b

%build pyramids,level0-level2 for all train
root='scenes_train/scenes_train/';
dirs={'coast','forest','highway','insidecity','mountain','opencountry','street','tallbuilding'};
[pyramids_train,l0_train,l1_train,l2_train]=build_pyramids(root,dirs,means);
size(pyramids_train)
save('pyramids_train.mat','pyramids_train');

%build pyramids,level0-level2 for all test
root='scenes_test/scenes_test/';
[pyramids_test,l0_test,l1_test,l2_test]=build_pyramids(root,dirs,means);
size(pyramids_test)
save('pyramids_test.mat','pyramids_test');


%3.1.c -- compute accuracy for svm pyramids,level0-level2
    labels=reshape(repmat([1 2 3 4 5 6 7 8],100,1),[800,1]);
    %pyramids
    predicted_labels=findLabelsSVM(pyramids_train,labels,pyramids_test);
    pyramids_ratio=compute_accuracy(predicted_labels);
    pyramids_ratio
    
    %{
    labels=reshape(repmat([1 2 3 4 5 6 7 8],100,1),[800,1]);
    predicted_labels=findLabelsSVM(l0_test,labels,pyramids_test);
    pyramids_ratio=compute_accuracy(predicted_labels);
    pyramids_ratio
    
    predicted_labels=findLabelsSVM(l1_test,labels,pyramids_test);
    pyramids_ratio=compute_accuracy(predicted_labels);
    pyramids_ratio
    
    predicted_labels=findLabelsSVM(l2_test,labels,pyramids_test);
    pyramids_ratio=compute_accuracy(predicted_labels);
    pyramids_ratio
    %predicted_labels
    %}
%{  
sift=load('scenes_train\scenes_train\coast\image_0003.jpg.mat');
means=load('means.mat');
[P,A,B,C]=computeSPMRepr(sift,means.means);
P
%}
   

function [ratio]=compute_accuracy(predicted_labels) 
    correct=0;
    incorrect=0;
     %calculate the fraction of correctly predicted labels
    for i=1:400
       if (predicted_labels(i)==floor(i/50)+1) %50 images in per test class
            correct=correct+1;
       else
            incorrect=incorrect+1;
       end
    end
    %correct
    %incorrect
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


   
    





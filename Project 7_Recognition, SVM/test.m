%part 1 sketch
%{
sift=load('scenes_train\scenes_train\coast\image_0003.jpg.mat');
means=load('means.mat');
[P,A,B,C]=computeSPMRepr(sift,means.means);
%}

%build pyramids for all train
%{
root='scenes_train/scenes_train/';
dirs={'coast','forest','highway','insidecity','mountain','opencountry','street','tallbuilding'};
pyramids_train=build_pyramids(root,dirs,means);
size(pyramids_train)
save('pyramids_train.mat','pyramids_train');

%build pyramids for all test
root='scenes_test/scenes_test/';
dirs={'coast','forest','highway','insidecity','mountain','opencountry','street','tallbuilding'};
pyramids_test=build_pyramids(root,dirs,means);
size(pyramids_test)
save('pyramids_test.mat','pyramids_test');
%}

pyramids_train=load('pyramids_train');
pyramids_test=load('pyramids_test');
labels=reshape(repmat([1 2 3 4 5 6 7 8],100,1),[800,1]);
labels_knn=findLabelsKNN(pyramids_train.pyramids_train,labels,pyramids_test.pyramids_test,5);
labels_svm=findLabelsSVM(pyramids_train.pyramids_train,labels,pyramids_test.pyramids_test);




function [pyramids_train]=build_pyramids(root,dirs,means)
    %concatenate all the selected descriptors
    pyramids_train=cell(1);
    for i=1:length(dirs)
        path=char(strcat(root,dirs(i)));
        S=dir(fullfile(path,'*.mat'));
        for k = 1:min(numel(S))
            F = fullfile(path,S(k).name);
            sift= load(F);
            [P,~,~,~]=computeSPMRepr(sift,means.means);
            pyramids_train{(i-1)*numel(S)+k,1}=P;
        end
    end
end




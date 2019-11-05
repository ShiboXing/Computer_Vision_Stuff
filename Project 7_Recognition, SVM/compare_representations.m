%3a
    %read 10 sift descriptors from each class
root='scenes_train/scenes_train/';
dirs={'coast','forest','highway','insidecity','mountain','opencountry','street','tallbuilding'};
data=[];
    %concatenate all the selected descriptors
for i=1:length(dirs)
    path=char(strcat(root,dirs(i)));
    S=dir(fullfile(path,'*.mat'));
    for k = 1:numel(S)
        F = fullfile(path,S(k).name);
        sift= load(F);
        data=[data;sift.d'];
    end
end

%calculate clusters' means using kmeans
%{
[~,means]=kmeans(double(data),50,'MaxIter',2147483647);
save('means.mat','means');
%}
means=load('means.mat');
means=means.means;

%3b
   
    





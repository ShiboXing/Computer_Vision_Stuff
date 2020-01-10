%split the images 
f=fullfile('scenes_all','scenes_all');
imds=imageDatastore(f,'IncludeSubfolders',true,'LabelSource','foldernames')
NumOfImgs=100;
[imdsTrain,imdsTest] = splitEachLabel(imds,NumOfImgs,'randomize');

%transfer layers from alexnet
net=alexnet;
freezed_layers=net.Layers(1:22)
layers=[freezed_layers;fullyConnectedLayer(8);softmaxLayer;classificationLayer];

%training options with learning rate as 1e-4
options = trainingOptions('sgdm', ...
    'MaxEpochs',1,...
    'InitialLearnRate',1e-4, ...
    'Verbose',false, ...
    'Plots','training-progress');

NewNet = trainNetwork(imdsTrain,layers,options);
%save('alexnetTillFC6.mat');

YPred = classify(NewNet,imdsTest);
YTest = imdsTest.Labels;
    
%calculate performance
correct=0.0;
for i=1:size(YPred,1)
    if (YPred(i)==YTest(i))
        correct=correct+1;
    end
end
ratio=correct/size(YPred,1)


%training options with learning rate as 1e-2
options = trainingOptions('sgdm', ...
    'MaxEpochs',1,...
    'InitialLearnRate',1e-2, ...
    'Verbose',false, ...
    'Plots','training-progress');

NewNet = trainNetwork(imdsTrain,layers,options);
%save('alexnetTillFC6.mat');

YPred = classify(NewNet,imdsTest);
YTest = imdsTest.Labels;
    
%calculate performance
correct=0.0;
for i=1:size(YPred,1)
    if (YPred(i)==YTest(i))
        correct=correct+1;
    end
end
ratio=correct/size(YPred,1)


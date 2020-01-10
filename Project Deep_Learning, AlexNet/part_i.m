%I1
f=fullfile('scenes_all','scenes_all');
imds=imageDatastore(f,'IncludeSubfolders',true,'LabelSource','foldernames')
NumOfImgs=100;
[imdsTrain,imdsTest] = splitEachLabel(imds,NumOfImgs,'randomize');

%I2
layers =[%input layer
    imageInputLayer([227 227 3])
    %Group A layers
    convolution2dLayer(11,50)
    reluLayer
    maxPooling2dLayer(3,'Stride',1)
    %Group B layers
    convolution2dLayer(5,60)
    reluLayer
    maxPooling2dLayer(3,'Stride',2)
    fullyConnectedLayer(8)
    softmaxLayer
    classificationLayer];

%I3
options = trainingOptions('sgdm', ...
    'MaxEpochs',1,...
    'InitialLearnRate',1e-3, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(imdsTrain,layers,options);
%save('cnn.mat');

YPred = classify(net,imdsTest);
YTest = imdsTest.Labels;
    
%calculate performance
correct=0.0;
for i=1:size(YPred,1)
    if (YPred(i)==YTest(i))
        correct=correct+1;
    end
end
ratio=correct/size(YPred,1)




net=alexnet;
net.Layers
%analyzeNetwork(net);
class(net.Layers)
freezed=net.Layers(1:16);
added_layers=[fullyConnectedLayer(8) softmax classificationLayer];

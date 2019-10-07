img_file="cardinal1.jpg";
%size(imread(img_file))
[x,y,scores,Ih,Iv]=extract_keypoints(imread(img_file));
features=compute_features(x,y,scores,Ih,Iv);
means=load('means.mat');
computeBOWRepr(features,means.means);

img_file="cardinal1.jpg"
%size(imread(img_file))
[x,y,scores,Ih,Iv]=extract_keypoints(imread(img_file));
compute_features(x,y,scores,Ih,Iv);
%test=[3 12 2; 8 10 9; 6 15 9];
%extract_keypoints(test);
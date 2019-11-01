
sift=load('scenes_train\scenes_train\coast\image_0003.jpg.mat');
means=load('means.mat');
[P,A,B,C]=computeSPMRepr(sift,means.means);


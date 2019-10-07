function [bow_repr] = computeBOWRepr(features, means)
   %II1
   bow=zeros(1,10);
   rlen=size(features,1);
   %II2
   for i=1:rlen
      distances=pdist2(features(i),means,'euclidean');
      
   end
   
   
   
end
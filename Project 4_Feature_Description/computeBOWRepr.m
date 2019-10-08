function [bow_repr] = computeBOWRepr(features, means)
   %II1
   bow_repr=zeros(1,size(means,1));
   rlen=size(features,1);
   
   %II2
   distances=pdist2(features,means);
   
   %II3
   [V,I]=min(distances,[],2);
   for i=1:size(I,1)
      bow_repr(I(i))= bow_repr(I(i))+1;
   end
   
   %II4
   bow_repr=bow_repr/sum(bow_repr);
   
   
   
end
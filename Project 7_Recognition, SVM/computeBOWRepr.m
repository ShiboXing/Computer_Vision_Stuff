function [bow_repr] = computeBOWRepr(features, means)
   %II1
   bow_repr=double(zeros(size(means,1)));
   
   %II2
   distances=pdist2(features,means);
   
   %II3
   [~,I]=min(distances,[],2);
   for i=1:length(I)
      bow_repr(I(i))= bow_repr(I(i))+1;
   end
   
   
   %II4
   bow_repr=(bow_repr/sum(bow_repr))'; 
   
   'bow size'
   size(bow_repr)
   
   
   
end
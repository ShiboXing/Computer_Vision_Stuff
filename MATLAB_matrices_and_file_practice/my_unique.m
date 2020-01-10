%11
function [N] = my_unique(M)
    N=repmat(M,1,1);
    for i=1:size(N,1)-1
        j=i+1;
        while(j<=size(N,1))
            if(isequal(N(i,:),N(j,:)))
                N(j,:)=[];
                j=j-1;
            end
            j=j+1;
        end
    end
end
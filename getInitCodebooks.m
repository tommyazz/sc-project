function codebooks = getInitCodebooks(vectors, codebook_size, mode)
    
    if strcmp(mode, 'random')
        sizes = [size(vectors,1) size(vectors,2)];
        codebooks = zeros(codebook_size, min(sizes));
        random_int = randperm(max(sizes), codebook_size);
        for i=1:codebook_size
            codebooks(i,:) = vectors(random_int(i),:);
        end
    elseif strcmp(mode, 'splitting')
        codebooks = mean(vectors);
    else
        disp('Wrong or not supported codebook initialization');
    end
end
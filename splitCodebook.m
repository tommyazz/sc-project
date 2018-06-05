function splitted_codebook = splitCodebook(codebook, mode, value)

    code_size = size(codebook,1);
    splitted_codebook = zeros(2*code_size, size(codebook,2));
    
    if strcmp(mode, 'percen')
        for i=1:code_size
            splitted_codebook(i,:) = codebook(i,:).*(1-value);
            splitted_codebook(i+code_size,:) = codebook(i,:).*(1+value);
        end
    elseif strcmp(mode, 'sum')
        for i=1:code_size
            splitted_codebook(i,:) = codebook(i,:) + value;
            splitted_codebook(i+code_size,:) = codebook(i,:) - value;
        end
    end
end
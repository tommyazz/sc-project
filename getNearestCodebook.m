function index = getNearestCodebook(vector, codebooks, distance)

    if strcmp(distance,'euclidean')
        difference = bsxfun(@minus, codebooks, vector);
        difference = difference.^2;
        [~, index] = min(sum(difference,2));
    elseif strcmp(distance,'cosine')
        num = codebooks*vector';
        den = sqrt((sum(codebooks.*codebooks,2)).*(vector*vector'));
        [~, index] = min(1 - (num ./ den));
    else
        disp('Wrong or not supported type of distance');
    end
end
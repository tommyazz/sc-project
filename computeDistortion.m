function [new_codebook, distortion] = computeDistortion(block_images, vectors, codebook, distance, flag)

    tot = size(block_images, 1);
    distortions = zeros(size(codebook,1), 1);
    for i=1:tot
        idx = getNearestCodebook(block_images(i,:), codebook, distance);
        q = codebook(idx,:);
        distortions(idx) = distortions(idx) + sum((block_images(i,:)-q).^2);
        %sum = sum + (norm(vectors(i,:)-q))^2;
    end
    if flag
        empty = find(codebook(:,end) == 0);
        fprintf('Number of empty cells is %s\n', num2str(length(empty)));
        if ~isempty(empty)
            [~, idx_max] = max(distortions);
            max_vector = vectors(vectors(:,end) == idx_max,1:end-1);
            random_int = randperm(length(max_vector), length(empty));
            for i=1:length(empty)
                disp(codebook(empty(i),:));
                codebook(empty(i),:) = max_vector(random_int(i),:);
            end
        end
    end
    distortion = sum(distortions) / tot;
    new_codebook = codebook;
    fprintf('Distortion value is %s\n', distortion);
end
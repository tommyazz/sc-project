clc;

%% LBG evolution

code_size = 256;
block_size = 4;
levels = 6;
tree_features = getFeaturesFromPyramid(trainingSet, levels, block_size);
%tree_features = expand(tree_features);
codebook_1 = getInitCodebooks(tree_features, code_size, 'random');
n = 1;
epsilon = 0.1;
prev_D = realmax;
max_epochs = 25;
number_vectors = size(blocks_images,1);
%cells = zeros(code_size, size(blocks_images,2) + 1);
distance = 'euclidean';
flag = false;
terminate = 100*epsilon; % any high value

while terminate >= epsilon && n <= max_epochs
    fprintf('Iteration number is %s\n', num2str(n));
    if n > 1
        flag = true;
    end
    cells = zeros(code_size, size(blocks_images,2) + 1);
    vectors = zeros(number_vectors, size(blocks_images,2) + 1);
    for i=1:number_vectors
       idx = getNearestCodebook(blocks_images(i,:), codebook_1, distance);
       vectors(i,1:end-1) = blocks_images(i,:);
       vectors(i,end) = idx;
       cells(idx, 1:end-1) = cells(idx, 1:end-1) + blocks_images(i,:);
       cells(idx, end) = cells(idx, end) + 1;
    end
    temp_codebook = cells(:,1:end-1)./cells(:,end);
    temp_codebook(isnan(temp_codebook)) = 0;
    [codebook_1, new_D] = computeDistortion(blocks_images, vectors, temp_codebook, distance, flag);
    terminate = (prev_D - new_D) / new_D;
    fprintf('Terminate condition value is %s\n', terminate);
    
    n = n+1;
    prev_D = new_D;
    clearvars temp_codebook;
end
clearvars cells vectors;
save('codebook_tree_rand_1.mat', 'codebook_1');
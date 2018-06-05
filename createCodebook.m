function codebook = createCodebook(blocks_images, code_size, epsilon, init, split_mode, split_value)

if ~exist('split_mode','var')
    split_mode = 'None';
end
if ~exist('split_value','var')
    split_value = 0;
end
codebook = getInitCodebooks(blocks_images, code_size, init);
n = 1;
prev_D = realmax;
max_epochs = 25;
if strcmp(init, 'splitting')
    max_epochs = max_epochs + log2(code_size);
end   
number_vectors = size(blocks_images,1);
distance = 'euclidean';
flag = false;
terminate = realmax; % any high value

while terminate >= epsilon && n <= max_epochs
    fprintf('Iteration number is %s\n', num2str(n));
    if n > 1 
        flag = true;
    end
    if size(codebook,1) ~= code_size && strcmp(init, 'splitting')
        codebook = splitCodebook(codebook, split_mode, split_value);
    end
    new_code_size = size(codebook,1);
    cells = zeros(new_code_size, size(blocks_images,2) + 1);
    vectors = zeros(number_vectors, size(blocks_images,2) + 1);
    for i=1:number_vectors
       idx = getNearestCodebook(blocks_images(i,:), codebook, distance);
       vectors(i,1:end-1) = blocks_images(i,:);
       vectors(i,end) = idx;
       cells(idx, 1:end-1) = cells(idx, 1:end-1) + blocks_images(i,:);
       cells(idx, end) = cells(idx, end) + 1;
    end
    temp_codebook = cells(:,1:end-1)./cells(:,end);
    temp_codebook(isnan(temp_codebook)) = 0;
    [codebook, new_D] = computeDistortion(blocks_images, vectors, temp_codebook, distance, flag);
    terminate = (prev_D - new_D) / new_D;
    prev_D = new_D;
    if strcmp(init, 'splitting') && n <= log2(code_size)
        terminate = realmax;
        prev_D = realmax;
    end
    fprintf('Terminate condition value is %s\n', terminate);
    n = n+1;
    clearvars temp_codebook;
end
clearvars cells vectors;

end
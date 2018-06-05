clc; 
%% import images in a image datastore object
load win_path.mat;
imds = imageDatastore(path,'FileExtensions',{'.pgm'},'LabelSource','foldernames');
% test
img = readimage(imds,1);
% imshow(img);
% train and test sets splitting, 70% are training images
[trainingSet, testSet] = splitEachLabel(imds, 0.28); % 0.06 and 0.28 

%% create a matrix with all training images blocks

image_size = 512;
block_size = 4;
number_train = countEachLabel(trainingSet);
number_train = number_train.Count;
number_blocks = image_size*image_size/block_size;
blocks_images = zeros(number_train*number_blocks, block_size);
for i=1:number_train
    
    img = double(readimage(trainingSet, i));
    from = (i-1)*number_blocks + 1;
    to = from + number_blocks - 1;
    blocks_images(from:to,1:block_size) = image2vec(img, block_size);
    
end

%% LBG algorithm - random - epsilon=0.1

code_size = 256;
epsilon = 0.1;
codebook_1 = createCodebook(blocks_images, code_size, epsilon, 'random');
%save('codebook_16_rand_1.mat', 'codebook_1');

%% LBG algorithm - random - epsilon=0.01

code_size = 256;
epsilon = 0.01;
codebook_01 = createCodebook(blocks_images, code_size, epsilon, 'random');
%save('codebook_16_rand_01.mat', 'codebook_01');

%% LBG algorithm - random - epsilon=0.001

code_size = 256;
epsilon = 0.001;
codebook_001 = createCodebook(blocks_images, code_size, epsilon, 'random');
%save('codebook_16_rand_001.mat', 'codebook_001');

%% encode training set image 

distance = 'euclidean';
%load codebook_16_rand_001.mat;
train_image = double(readimage(trainingSet, 1));
% imshow(train_image);
block_size = 4;
encoded_train_image = encodeImage(train_image, tree_rand_codebook_001, block_size, distance);
decoded_train = decodeImage(encoded_train_image, tree_rand_codebook_001, block_size);
figure;
imshow(uint8(decoded_train));

psnr_train = psnr(decoded_train, train_image,255);

test_image = double(readimage(testSet, 3));
encoded_test_image = encodeImage(test_image,tree_rand_codebook_001,block_size, distance);
decoded_test = decodeImage(encoded_test_image, tree_rand_codebook_001, block_size);
figure;
imshow(uint8(decoded_test));
psnr_test = psnr(decoded_test, test_image,255);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% SPLITTING
%% LBG algorithm - splitting - epsilon=0.1

code_size = 256;
epsilon = 0.1;
codebook_1 = createCodebook(blocks_images, code_size, epsilon, 'splitting','sum', 1);
save('codebook_split_1.mat', 'codebook_1');

%% LBG algorithm - splitting - epsilon=0.01

code_size = 256;
epsilon = 0.01;
codebook_01 = createCodebook(blocks_images, code_size, epsilon, 'splitting','sum', 1);
save('codebook_split_01.mat', 'codebook_01');

%% LBG algorithm - splitting - epsilon=0.001

code_size = 256;
epsilon = 0.001;
codebook_001 = createCodebook(blocks_images, code_size, epsilon, 'splitting','sum', 1);
save('codebook_split_001.mat', 'codebook_001');

%%
distance = 'euclidean';
%load codebook_16_rand_001.mat;
test_image = double(readimage(testSet, 57));
% imshow(train_image);
block_size = 4;
encoded_train_image = encodeImage(test_image, codebook_001, block_size, distance);
decoded_train = decodeImage(encoded_train_image, codebook_001, block_size);
psnr_train = psnr(decoded_train, test_image,255);
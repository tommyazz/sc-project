clc;

%% import images in a image datastore object
load win_path.mat;
imds = imageDatastore(path,'FileExtensions',{'.pgm'},'LabelSource','foldernames');
% test
img = readimage(imds,1);
% imshow(img);
% train and test sets splitting, 70% are training images
[trainingSet, testSet] = splitEachLabel(imds, 0.28); % 0.06 and 0.28 

%%
load('codebook_16_rand_001.mat');
codebook = codebook_001;
block_size = 16;
%------------------------

% evaluation on training set
im = double(readimage(trainingSet,1));
coded = decodeImage(encodeImage(im, codebook, block_size,'euclidean'), codebook, block_size);
train_psnr = psnr(coded, im, 255);
imwrite(coded./255,'./report/img/train_16_split_001.png');
  
% evaluation on test set
im = double(readimage(testSet,57));
coded = decodeImage(encodeImage(im, codebook, block_size,'euclidean'), codebook, block_size);
test_psnr = psnr(coded, im, 255);
imwrite(coded./255,'./report/img/test_16_split_001.png');   

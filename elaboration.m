clc;
%% results elaboration

%% import images in a image datastore object
load mac_path.mat;
imds = imageDatastore(path,'FileExtensions',{'.pgm'},'LabelSource','foldernames');
% test
img = readimage(imds,1);
% imshow(img);
% train and test sets splitting, 70% are training images
[trainingSet, testSet] = splitEachLabel(imds, 0.29); % 0.06 and 0.28 

%filename = 'results.mat';

%% 

%------------------------
filename = 'results_tree_rand_1.mat';
imwrite_train_filename = './report/img/train_tree_rand_1';
imwrite_test_filename = './report/img/test_tree_rand_1';
load('codebook_tree_rand_1.mat');
codebook = codebook_1;
block_size = 4;
%------------------------

% evaluation on training set
number_train = countEachLabel(trainingSet);
number_train = number_train.Count;
train_psnr = zeros(number_train,1);
train_distortion = zeros(number_train,1);
for i=1:number_train
    im = double(readimage(trainingSet,i));
    coded = decodeImage(encodeImage(im, codebook, block_size,'euclidean'), codebook, block_size);
    
    train_psnr(i) = psnr(coded, im, 255);
    train_distortion(i) = immse(im, coded);
    
    if i == 1 
        train_prima_psnr = psnr(coded, im, 255);
        imwrite(coded./255,'./report/img/train_tree_rand_1.png');
    end
end

% evaluation on test set
% number_test = countEachLabel(testSet);
% number_test = number_test.Count;
% considering the same number of images as in training evaluation
test_psnr = zeros(number_train,1);
test_distortion = zeros(number_train,1);
j=1;
for i=27:52
    im = double(readimage(testSet,i));
    coded = decodeImage(encodeImage(im, codebook, block_size,'euclidean'), codebook, block_size);
    
    test_psnr(j) = psnr(coded, im, 255);
    test_distortion(j) = immse(im, coded);
    j=j+1;
end

im = double(readimage(testSet,52));
coded = decodeImage(encodeImage(im, codebook, block_size,'euclidean'), codebook, block_size);
lena_psnr = psnr(coded, im, 255);
imwrite(coded./255,'./report/img/test_tree_rand_1.png');   

%------------------------------------
train_rand_1_psnr = train_psnr;
train_rand_1_distortion = train_distortion;
test_rand_1_psnr = test_psnr;
test_rand_1_distortion = test_distortion;
save(filename,'train_rand_1_psnr','train_rand_1_distortion',...
            'test_rand_1_psnr','test_rand_1_distortion');
%------------------------------------
sorted_train=sort(train_psnr);
sorted_test=sort(test_psnr);
oldmean=mean(sorted_train);
newmean=mean(sorted_test);
oldstd=std(sorted_train);
newstd=std(sorted_test);
meanCIold=[oldmean-1.96*oldstd/sqrt(length(sorted_train)) oldmean+1.96*oldstd/sqrt(length(sorted_train))];
meanCInew=[newmean-1.96*newstd/sqrt(length(sorted_test)) newmean+1.96*newstd/sqrt(length(sorted_test))];
figure
hold on
boxplot([sorted_train,sorted_test],'Notch','on','Labels',{'train set','test set'},'Whisker',1.5)
plot([0,1.5],[oldmean,oldmean],'LineStyle','-','Color','r')
plot([0,1.5],[meanCIold(1),meanCIold(1)],'LineStyle','-.','Color','k')
plot([0,1.5],[meanCIold(2),meanCIold(2)],'LineStyle','-.','Color','k')

plot([1.5,3],[newmean,newmean],'LineStyle','-','Color','m')
plot([1.5,3],[meanCInew(1),meanCInew(1)],'LineStyle','-.','Color','k')
plot([1.5,3],[meanCInew(2),meanCInew(2)],'LineStyle','-.','Color','k')
title('mean, median, quartile and 95% CI for old and new data') 
legend('mean','mean 95% CI')

%saveas(gcf,'fig1_3','epsc')

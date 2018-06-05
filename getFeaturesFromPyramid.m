function features = getFeaturesFromPyramid(trainingSet, levels, block_size)
    
   number_train = countEachLabel(trainingSet);  
   number_train = number_train.Count;
   features = [];
   
   for i=1:number_train
       im = double(readimage(trainingSet,i));
       reduced = im;
       for j=1:levels
           reduced = impyramid(reduced, 'reduce');
       end
       to_vec = image2vec(reduced, block_size);
       features = [features; to_vec];
   end
 
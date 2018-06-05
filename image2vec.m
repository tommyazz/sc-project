function vectors_from_image = image2vec(image, block_size)

   p = sqrt(block_size);
   vectors_from_image = (im2col(image',[p p],'distinct'))';
   
end
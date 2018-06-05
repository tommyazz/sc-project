function im_from_vec = vec2image(vectorize_image, block_size, image_size)
    
    p = sqrt(block_size);
    im_from_vec = (col2im(vectorize_image',[p p],...
                        [image_size image_size], 'distinct'))';

end
function decoded_image = decodeImage(image, codebook, block_size)
    
    image_size = 512;
    enc_image = zeros(size(image,1),block_size);
    for i=1:size(image,1)
        enc_image(i,:) = codebook(image(i),:);
    end
    decoded_image = vec2image(enc_image, block_size, image_size);
end
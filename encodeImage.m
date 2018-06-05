function encoded_image = encodeImage(image, codebook, block_size, distance)

    image_vectors = image2vec(image, block_size);
    for i=1:size(image_vectors,1)
        encoded_image(i,:) = getNearestCodebook(image_vectors(i,:),...
                                    codebook, distance);
    end
end
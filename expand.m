function expanded = expand(features)

    expanded = zeros(3*size(features,1), size(features,2));
    p = [1 2 3];
    for i=1:size(features,1)
        expanded(p(1),:) = features(i,:);
        expanded(p(2),:) = features(i,:).*0.25;
        expanded(p(3),:) = features(i,:).*0.75;
        p=p+3;
    end
    
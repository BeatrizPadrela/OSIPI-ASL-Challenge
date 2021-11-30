function MaskedImage = OverlappingMask(ImageToFilter,Mask)

% Note: ImagetoFilter + Mask should have the same size

MaskedImage = zeros (size(ImageToFilter));
for x = 1:size(ImageToFilter,1)
    for y = 1:size(ImageToFilter,2)
        for z = 1:size(ImageToFilter,3)
            if Mask(x,y,z)>0
                MaskedImage(x,y,z) = ImageToFilter(x,y,z);
            else
                MaskedImage(x,y,z) = 0;
            end
        end
    end
end
end
function [filteredIMG] = convolution(image, mask)

	[maskM, maskN]=size(mask);
    [M,N] = size(image);
    
	if (mod(maskM,2) == 0) 
		sprintf('error, i only support odd dimension masks currently')
		%easiest way to do this is to just add another row to make it odd,
        %although this might not be the 'best' option.
		return
    elseif (mod(maskN,2) == 0)
        sprintf('error, i only support odd dimension masks currently,')
		return
	end
	maskCenterRow=ceil(maskM/2);
	maskCenterCol=ceil(maskN/2);

	%initialize filtered image
	filteredIMG = zeros(size(image));

	%convolve!
    for i=1:M;
		for j=1:N;
			for k=1:maskM;
				for l=1:maskN;
                    if ((i+(k-maskCenterRow) > 0) &&...
                            (j+(l-maskCenterCol) > 0)) &&...
                            ((i+(k-maskCenterRow) <= M) &&...
                            (j+(l-maskCenterCol) <= N))
                       filteredIMG(i,j) =...
                           filteredIMG(i,j) + ...
                           (image(i+(k-maskCenterRow),...
                           j+(l-maskCenterCol))*mask(k,l));
                    end
                end
            end
        end
    end
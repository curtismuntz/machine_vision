function [croppedIMG] = cropper(I, fraction, section)
	[M,N]=size(I);
    %currently only works for cropping images from the top left to a
    %certain percentage of the original size.
	croppedIMG=zeros(ceil((M*fraction)),ceil((N*fraction)));
	croppedIMG = im2double(croppedIMG);

	if (strcmp(section, 'normal') == 1)
		rowStart = 1;
		colStart = 1;
		rowEnd=ceil((M*fraction));
		colEnd=ceil((N*fraction));
% 	elseif(strcmp(section, 'bad') == 1 )
% 		rowStart=ceil((M*fraction));
% 		colStart=ceil((N*fraction));
% 		rowEnd=M;
% 		colEnd=N;
	end

	for i=rowStart:rowEnd
		for j=colStart:colEnd
			croppedIMG(i,j)=I(i,j);
		end
	end
end
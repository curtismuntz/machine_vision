function [h] = gaussfilter(dimensions,sigma)
	%center row, column is found by:
	%divide dimensions by 2, round up

	m=ceil(dimensions/2); %this gives center value

	%initialize 2D array
	h=zeros(dimensions,dimensions);
	%h(i,j) = e^(((i-m)^2+(j-m)^2)/(2sigma^2)))
	summed = 0;
	for (row=1:dimensions)
		for (col=1:dimensions)
			h(row,col) = exp(-(((col-m)^2+(row-m)^2)/(2*sigma^2)));
			summed = summed + h(row,col);
		end
    end
    %normalize!
	h = h/summed;
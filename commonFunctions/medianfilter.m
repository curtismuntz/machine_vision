function [MED] = medianfilter(image)
    [M,N] = size(image);
    center=2;
    z=1;
    values=zeros(1,9);
    tmp=zeros(size(image));
    MED=uint8(tmp);
    for i=1:M
    	for j=1:N
    		for k=1:3
    			for l=1:3
	    			if (((i+(k-center)) > 0) && ((j+(l-center)) > 0) && ...
                            (i+(k-center) < M) && (j+(l-center) < N))
			    		values(z) = image((i+(k-center)),(j+(l-center)));
			    		z = z + 1;
			    	end
			    end
	    	end
    	MED(i,j) = median(values);
    	clear values;
    	z = 1;
    	end
    end
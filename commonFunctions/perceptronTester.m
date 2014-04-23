function [result] = perceptronTester(testValue, weightVector, bias)
	for k=1:10
		testDataA = trainingSetA(k,:);
		gxA=dot(weightVectorA,testDataA)+biasA;
		testDataB = trainingSetA(k+10,:);
		gx=dot(weightVectorA,testDataB)+biasA;

		fprintf('\n');
		if  gxA > threshold
			fprintf(['Result is A. %s\n ' num2str(gxA)]); 
		else
			fprintf(2,['Result is not an A. %s\n ' num2str(gxA)]); %result is not expected
		end
		
		fprintf('\n');
		if gx > threshold
			fprintf(2,['Result is A. %s\n ' num2str(gx)]);% result is not expected
		else
			fprintf(['Result is not an A. %s\n ' num2str(gx)]); 
		end
		fprintf('\n-----');
	end
end
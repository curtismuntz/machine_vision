%%
%
% single neuron NAND implementation
% Ferhat Ozgur CATAK
% f.ozgur.catak@gmail.com
%
%%
clc
clear
trainingSet = [ 1 0 0 1
                1 0 1 1
                1 1 0 1
                1 1 1 0];

[m n] = size(trainingSet);

weightVector = zeros(1,n-1);

threshold = 0.5;
learningRate = 0.1;
result = 1;

iterationNo = 1;

%%
% training phase
while true
   error_count = 0;
   for i=1:m,
      if trainingSet(i,1:n-1)*weightVector' > threshold
         result = 1;
      else
         result = 0;
      end

      error = trainingSet(i,n) - result;
      if error ~= 0
         error_count = error_count + 1;
         for j=1:n-1,
            if trainingSet(i,j) == 1
               weightVector(1,j) = weightVector(1,j) + error*learningRate;
            end
         end
      end
   end
   
   iterationNo = iterationNo +1;
   if iterationNo >= 1000
      disp('Neuron input calculation couldn''t completed in timely fashion.');
      return
   end 
   if error_count == 0
		break
   end
end
%%
% coefficients calculated

% get Sample result
testData = [ 1 0 1 ];

if testData * weightVector' > threshold
   disp('Result is 1.');
else
   disp('Result is 0.');
end
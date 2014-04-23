function [weightVector, bias] = customPerceptron(trainingSet, resultSet)
    %build training set
    [m, n] = size(trainingSet);
    weightVector = ones(1,n);
    for i=1:n
        weightVector(i) = weightVector(i)./(5); %initialize to small numbers. 12 guaranteed to be random, it was chosen through a set of dice rolls.
    end

    %weightVector = zeros(1,n);
    threshold = 0;%threshold to decide if the output is good or bad. usually this is 0
    error_count = 1;
    bias = 0.1;
    result = 1;
    iterationNo = 1;
    learningRate = 0.001;
    % training phase
    while (error_count > 0)
        error_count = 0;
        for i=1:m
            gx=dot(weightVector,trainingSet(i,:))+bias;
                if (gx > threshold)
                    result = 1;
                else
                    result = 0;
                end

                error = resultSet(i)-result;
                if (error ~= 0)
                    error_count = error_count + 1;
                    weightVector = weightVector + (learningRate*(error))*trainingSet(i,1:n);
                    bias = bias + learningRate*error;
                end
        end

        if (iterationNo >= 1000)
            disp('Neuron input calculation couldn''t completed in timely fashion.');
            break
        end
        iterationNo = iterationNo +1;
    end
    disp(['answer converged in ' num2str(iterationNo) ' iterations']);
end

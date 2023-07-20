% Convert the x_test_new cell array into a numeric 3D array
numSequences = numel(X_test_new);
nTimeSteps = size(X_test_new{1}, 2);
nFeatures = size(X_test_new{1}, 1);

xTestNumeric = zeros(nFeatures, nTimeSteps, numSequences, 'single');

for i = 1:numSequences
    xTestNumeric(:, :, i) = single(X_test_new{i});
end


% Create an arrayDatastore for x_test_new
% Create an arrayDatastore for the transformed x_test_new
xTestDs = arrayDatastore(xTestNumeric, 'IterationDimension', 3);

% Create an arrayDatastore for yTest
yTestDs = arrayDatastore(y_test_categorical, 'OutputType', 'cell');

data=combine(xTestDs,yTestDs);
dq = dlquantizer(net, 'ExecutionEnvironment', 'CPU');

dq.calibrate(data);










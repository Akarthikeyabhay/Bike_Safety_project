%reading the csv files
test=readtable(testdataset);
train=readtable(traindataset);

%feature engineering-- removing the unwanted columns
train_data = train(:, {'Ax', 'Ay', 'Az', 'Gx', 'Gy', 'Gz', 'Speed', 'Label'});
test_data = test(:, {'Ax', 'Ay', 'Az', 'Gx', 'Gy', 'Gz', 'Speed', 'Label'});

%cleaning the data by removing the null values

train_data = rmmissing(train_data);
test_data = rmmissing(test_data);

%seperating the variables and labels for train data 
X_train=train_data(:, {'Ax', 'Ay', 'Az', 'Gx', 'Gy', 'Gz', 'Speed'});
y_train=train_data(:,{'Label'});


%Data Windowing, making the sequences of data with each sequence 80 time steps
nTimeSteps = 80;  % Number of time steps in each sequence
nFeatures = 7;    % Number of features in each time step

% Calculate the number of sequences based on the time series length and the  desired time steps

nSequences = 2228; %nsequences=number of rows in train/number of timesteps in each sequence

% Initialize cell arrays to store the sequences and labels (if available)

sequences = cell(nSequences, 1);
labels = cell(nSequences, 1);

% Generate the sequences

for i = 1:nSequences
    % Define the start and end indices for each sequence
    startIndex = (i - 1) * nTimeSteps + 1;
    endIndex = startIndex + nTimeSteps - 1;
    
    % Extract the time series data for the current sequence
    sequenceData = X_train(startIndex:endIndex, :);
    
    % Store the sequence in the cell array
    sequences{i} = sequenceData;
    labelData = y_train(startIndex:endIndex, :);
    
    % Store the labls in the cell array
    labels{i} = labelData;

    
end

%after this step we have data of form (sequences= nsequences*1 cell array,
%with each cell having an 80*7 table(ntimesteps*nfeatures).
%label have data of form labels=nsequences*1 cell array with each cell
%having 80*1 ie ntimesteps*labels format.
  

% finding the label for a sequences instead of each row by taking mode of  the labels
modeCellArray = cell(size(labels));

% Iterate over each cell in 'labels'
for i = 1:numel(labels)
    % Get the labels in the current cell
    labels_cell = labels{i};
    labelsArray = labels_cell.Label;

    % Create a new cell array to store the concatenated contents
    convertedCategories = {};
    
    % Convert non-character elements to character vectors
    for j = 1:numel(labelsArray)
        if ~ischar(labelsArray{j})
            convertedCategories = [convertedCategories; string(labelsArray{j})];
        else
            convertedCategories = [convertedCategories; labelsArray{j}];
        end
    end
    
    % Convert the cell array to a categorical array
    categoricalData = categorical(convertedCategories);
    
    % Calculate the mode of the categorical array
    modeValue = mode(categoricalData);

    modeCellArray{i} = modeValue;
end

% Create a new cell array to store the concatenated contents
    converted_Categories = {};
    
    % Convert non-character elements to character vectors
    for j = 1:numel(modeCellArray)
        if ~ischar(modeCellArray{j})
            converted_Categories = [converted_Categories; string(modeCellArray{j})];
        else
            converted_Categories = [converted_Categories; modeCellArray{j}];
        end
    end
    
% Convert the cell array to a categorical array
 categorical_Data = categorical(converted_Categories);
%splitting the sequences and categorical_data 
testProportion = 0.75;

% Get the number of sequences
numSequences = size(sequences, 1);

% Calculate the number of sequences for testing
numTestSequences = round(numSequences * testProportion);

% Randomly shuffle the indices of the sequences
shuffledIndices = randperm(numSequences);

% Split the sequences into training and testing sets
trainIndices = shuffledIndices(1:numTestSequences);
valIndices = shuffledIndices(numTestSequences+1:end);

% Extract the training and testing data
X_train = sequences(trainIndices, :, :);
X_val = sequences(valIndices, :, :);
y_train = categorical_Data(trainIndices, :);
y_val = categorical_Data(valIndices, :);

y_train_numeric = grp2idx(y_train); % Convert to numeric representation
y_test_numeric = grp2idx(y_val); % Convert to numeric representation
y_train_categorical = categorical(y_train_numeric);
y_test_categorical = categorical(y_test_numeric);

% Convert each table in predictors to a numeric array since each cell in
% x_train is a table but model takes numeric arrays.
for i = 1:numel(X_train)
    X_train{i} = table2array(X_train{i});
end
for i = 1:numel(X_val)
    X_val{i} = table2array(X_val{i});
end
X_train_array = cellfun(@(x) x.',X_train , 'UniformOutput', false);
X_test_new = cellfun(@(x) x.',X_test , 'UniformOutput', false);


%so our final training X_train_array is input and y_train_categorical is
%our model.


% buliding model,bidirectional lstm 
inputSize = 7;
numHiddenUnits = 200;
numClasses = 5;

layers = [ ...
    sequenceInputLayer(inputSize)
    bilstmLayer(numHiddenUnits,OutputMode="last")
    fullyConnectedLayer(100)
    fullyConnectedLayer(100)
    fullyConnectedLayer(5)
    softmaxLayer
    classificationLayer];
% we made a bilstm layer and 3 hidden layers and atlast a classification
% layer with appropriate dimension
  
options = trainingOptions("adam", ...
    ExecutionEnvironment="cpu", ...
    GradientThreshold=2.4, ...
    MaxEpochs=50, ...
    MiniBatchSize=32, ...
    SequenceLength="longest", ...
    Shuffle="never", ...
    Verbose=0, ...
    Plots="training-progress");

net = trainNetwork(X_train_array,y_train_categorical, layers, options);

YPred = classify(net,X_test_new, ...
    MiniBatchSize=32, ...
    SequenceLength="longest");

acc = sum(YPred == y_test_categorical)./numel(y_test_categorical);


%saved the model
save('model.mat', 'net');

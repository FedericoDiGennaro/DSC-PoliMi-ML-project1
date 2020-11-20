% Load Data
data = csvread('trainex.txt');
your_features = csvread ('features.txt');
l=size(data)
X = data(:, 1:l(2)-1);
y = data(:, l(2));
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

%prediction
your_difficult = your_features * theta;

fprintf('Predicted difficult of the exam :\n $%f', your_difficult);
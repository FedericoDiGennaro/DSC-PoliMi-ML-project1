%  Load data
load('courses.mat');
%  Y is a matrix, containing ratings (1-5)
%  R is a matrix, where R(i,j) = 1 if and only if
user j gave a rating to course i
%  Add our own ratings to the data matrix
Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];
 
%  Normalize Ratings
[Ynorm, Ymean] = normalizeRatings(Y, R);
 
%  Useful Values
num_users = size(Y, 2);
num_courses = size(Y, 1);
num_features = 10;
 
% Set Initial Parameters (Theta, X)
X = randn(num_courses, num_features);
Theta = randn(num_users, num_features);
initial_parameters = [X(:); Theta(:)];
 
 
% Set options for fmincg
options = optimset('GradObj','on','MaxIter',100);
 
% Set Regularization
lambda = 10;
theta = fmincg(@(t)(cofiCostFunc(t, Ynorm, R,
num_users, num_courses, num_features,lambda)), initial_parameters, options);
 
% Unfold the returned theta back into U and W
X = reshape(theta(1:num_courses*num_features),num_courses, num_features);
Theta = reshape(theta(num_courses*num_features+1:end),num_users, num_features);
p = X * Theta';
my_predictions = p(:,1) + Ymean;
 
CoursesList = loadCoursesList();
 
[r, ix] = sort(my_predictions,'descend');
for i=1:10
  	j = ix(i);
  	if i == 1
       fprintf('\nTop recommendations for you:\n');
  	end
  	fprintf('Predicting rating %.1f for course %s\n', my_predictions(j), CoursesList{j});
end
 
for i = 1:length(my_ratings)
  	if i == 1
       fprintf('\n\nOriginal ratings provided:\n');
 
  	end
  	if my_ratings(i)> 0
       fprintf('Rated %d for %s\n', my_ratings(i), CoursesList{i});
 
  	end
end

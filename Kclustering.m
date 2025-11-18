%% ==== K-Means Clustering ====
%
% Created: 18 Nov 2025, Olga Ioffe
% Based on hw7 in ML course by Andrew Ng
%
% Load dataset. It would contain a single matrix with rows of coordinates.
% 
% K - number of clusters to sort to [3]
% max_iter - number of iterations to run the script [10]
% Initial positions of the centroids are randomized based on data range

%% Initialize
clear; close all; clc

%% Load Dataset and visualize
load('ex_olga1.mat')

fid = figure;
scatter(X(:,1),X(:,2), 10)
title('Initial data')
hold on

%% Analize boundaries

xmin = min(X(:,1));
xmax = max(X(:,1));
ymin = min(X(:,2));
ymax = max(X(:,2));

xrange = xmax - xmin;
yrange = ymax - ymin;

%% Randomize initial centroids within data boundaries

% Choose number of centroids
K = 3;

% Randomize
init_cent = [];
for indc = 1:K
    xc = rand*xrange + xmin;
    yc = rand*yrange + ymin;
    init_cent(indc,:) = [xc, yc];
end

% Visualize
figure(fid)
plot(init_cent(:,1),init_cent(:,2),Marker='X',MarkerSize=10,Color='k',LineStyle='none');

%% ==== K-Means main ====

% pause to see progress - optinonal, useful for debug and evaluation
fprintf('Program paused. Press enter to continue')
pause;

fprintf('Running K-Means Algorithm\n\n')

% Settings
max_iter = 10;

plot_progress_flag = 0;

% Run the algorithm
[centroids, clustNum] = run_Kmeans(X, init_cent, max_iter,...
                                               plot_progress_flag, fid);

% pause to see progress - optinonal, useful for debug and evaluation
% fprintf('Program paused. Press enter to continue')
% pause;

cols = lines;
scatter(X(:,1),X(:,2), 10, cols(clustNum,:));
title('Clustered data')
for indc = 1:K
plot(centroids(clustNum==indc,1),centroids(clustNum==indc,2),Marker='X',MarkerSize=10,Color=cols(clustNum,:),LineStyle='none');
end

%% === functions ===

function [centroids, clustNum] = run_Kmeans(X, init_cent, max_iter,...
                                               plot_progress_flag, fid)
% Run K-Means algorithm on X data points
% X - list of data points, coordinates in rows, 2D
% init_cent - list of initial centroids
% max_iter - num of iterations to run. Currently will run all the
% iteratios. In the future convergence criterion will be applied
% plot_progress_flag - flag whether to plot the progress. Assign 0 for
% speed, 1 for debug and visualization
% fid - figure id to plot on

% Set default values for plot progress
if nargin < 4
    plot_progress_flag = 0;
end
if plot_progress_flag && nargin<5
    fid = figure;
end

% Plot data if requested
if plot_progress_flag
    figure(fid);
    hold on
end

% Init data and run the loops
centroids = init_cent;
K = size(centroids,1);

for indl = 1:max_iter

    fprintf('Iteration %d out of %d\n', indl, max_iter)

    % Find closest centroid for this iteration
    clustNum = AssignCentroids(X, centroids);

    % plot progress

    % compute new centroids
    centroids = calcCent(X, clustNum, K);

end

% assign cluster num for final centroids calculated
clustNum = AssignCentroids(X, centroids);

fprintf('All iterations run\n')

end

function centNum = AssignCentroids(X, centr)
% for each coordinate in X assingns the closest centroid
% X - list of data points
% centr - list of centroids
% centNum - list of closest centroids per datapoint

K = size(centr,1);
centNum = zeros(size(X,1),1);

for indx = 1:size(X,1)
    dist = zeros(K,1);
    for indc = 1:K
        dist(indc) = norm(X(indx,:)-centr(indc,:));
    end
    [~,centNum(indx)] = min(dist);
end
end

function centroids = calcCent(X, centNum, K)
% calculates centroids according to the afilliation
% X - list of data points
% centNum - list of centroid numbers per data point
% K - number of centroids
% centroids - the new centroids per cluster

dims = size(X, 2);
centroids = nan(K, dims);

for indc = 1:K
    clust = (centNum == indc);
    centroids(indc,:) = mean(X(clust,:),1);
end


end
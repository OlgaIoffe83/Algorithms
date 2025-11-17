%% K-means
% Simple clustering algorithm
% This code creates clusters of random data then uses the K-means 
% algorithm to find the clusters and centroids 

%% initialize
clear
close all
clc

%% Create Clusters

% rng(1) % use the same seed for uniformity and debug. coment out for actually random results

num_clust = 3; % Deside hom many clusters to make
clust_size = 10; % Deside how many points in each cluster

X = []; % Initialize the grid

for indc = 1:num_clust
    xrnd = 100*rand; % x position of the cluster
    yrnd = 100*rand; % y position of the cluster
    xsrnd = 10*rand; % x size of the cluster
    ysrnd = 10*rand; % y size of the cluster

    % Create the cluster
    X1 = [xrnd*ones(clust_size,1)+xsrnd*randn(clust_size,1),...
          yrnd*ones(clust_size,1)+ysrnd*randn(clust_size,1)];

    X = [X; X1]; % Add to the grid
end

figure
scatter(X(:,1),X(:,2))
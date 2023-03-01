function [ population ] = GeneratePopulation(indiv,Dimension,minim,maxim)
%% Generate the initial population -------------
population = minim + (maxim - minim).*rand(indiv,Dimension);
population = round(population);
%% ---------------------------------------------
end


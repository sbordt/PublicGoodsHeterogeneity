warning('off');  % matrices are rank deficient ...

% main regression
fg2010 = readtable('../data/FG2010.csv');

M = table2array( fg2010(:, {'playerID', 'period', 'cont', 'belief', 'predictedcontribution'}) );

% de-mean variables
for i = 3:5
	K = mean(reshape(M(:, i), [10,140]), 1);
    M(:, i) = M(:, i)-kron(K(:), ones(10,1));
end

PLS_Helper(M, '../data/FG2010_PLS.csv', 10, 0.4446);




warning('off');  % matrices are rank deficient ...

oliveira2015 = readtable('../data/deOliveira2015.csv');

M = table2array( oliveira2015(:, {'playerID', 'period', 'cont', 'belief'}) );

% de-mean variables
for i = 3:4
	K = mean(reshape(M(:, i), [15,102]), 1);
    M(:, i) = M(:, i)-kron(K(:), ones(15,1));
end

PLS_Helper_Singlevar(M, '../data/deOliveira2015_PLS.csv', 15, 0.4446);
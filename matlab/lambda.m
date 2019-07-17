% data-driven choice of lambda for Fischbacher & Gächter (2010) (adapted from SSP code)
warning('off');  % matrices are rank deficient ...

clear
fg2010 = readtable('../data/FG2010.csv');
M = table2array( fg2010(:, {'playerID', 'period', 'cont', 'belief', 'predictedcontribution'}) );

for i = 3:5 % de-mean variables
	G = mean(reshape(M(:, i), [10,140]), 1);
    M(:, i) = M(:, i)-kron(G(:), ones(10,1));
end

N = 140;
T = 10;
y = M(:,3);
X = M(:,4:5);

lamb.grid = 50;
lamb.min  = 0.2;
lamb.max  = 2.0;
lamb_const = lamb.min * (lamb.max / lamb.min ).^( ( (1:lamb.grid) - 1) /( lamb.grid -1 ) ); % the constant for lambda. very important!!
numlam = length(lamb_const);

IC = zeros(3, numlam);
for G=2:4
    for ll = 1:numlam
        disp(ll)

        % estimate
        lam = lamb_const(ll)*var(y) * T^(-1/3);
        [b_est, a_out, group_est] = SSP_PLS_est(N, T, y, X, G, lam, 200);

        % calculate the IC
        IC_total = hat_IC(y, X, b_est, a_out, G);
        pen = 2/3 * (N*T)^(-.5) * 2 * G;

        IC(G-1, ll) = log(IC_total) + pen;
        disp(IC(G-1, ll))
    end
end
save('../data/IC_fg2010.mat', 'IC')

% the same for deOliveira (2015)
warning('off');  % matrices are rank deficient ...

clear
oliveira2015 = readtable('../data/deOliveira2015.csv');
M = table2array( oliveira2015(:, {'playerID', 'period', 'cont', 'belief'}) );

% de-mean variables
for i = 3:4
	K = mean(reshape(M(:, i), [15,102]), 1);
    M(:, i) = M(:, i)-kron(K(:), ones(15,1));
end

N = 102;
T = 15;
y = M(:,3);
X = M(:,4);

lamb.grid = 50;
lamb.min  = 0.2;
lamb.max  = 3.0;
lamb_const = lamb.min * (lamb.max / lamb.min ).^( ( (1:lamb.grid) - 1) /( lamb.grid -1 ) ); % the constant for lambda. very important!!
numlam = length(lamb_const);

IC = zeros(3, numlam);
for G=2:4
    for ll = 1:numlam
        disp(ll)

        % estimate
        lam = lamb_const(ll)*var(y) * T^(-1/3);
        [b_est, a_out, group_est] = SSP_PLS_est(N, T, y, X, G, lam, 200);

        % calculate the IC
        IC_total = hat_IC(y, X, b_est, a_out, G);
        pen = 2/3 * (N*T)^(-.5) * G;   % different from above since only 1 covariable

        IC(G-1, ll) = log(IC_total) + pen;
        disp(IC(G-1, ll))
    end
end
save('../data/IC_deOliveira2015.mat', 'IC')
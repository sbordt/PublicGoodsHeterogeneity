function [coeff, b_est, a_out, group_est] = SSP_PLS_est_post(N, T, y, X, K, lambda, R)
%SSP_PLS_est_post
% call SSP_PLS_est by Su, Shi and Phillips and perform
% Post C-Lasso regressions

% only our scenario with two variables and two groups
assert(size(X,2) == 2);
assert(K == 2);

% estimate
[b_est, a_out, group_est] = SSP_PLS_est(N, T, y, X, K, lambda, R);

% Post C-Lasso regression coefficients in group 1
n_0 = sum(group_est(:,1));
y_0 = y(repelem(group_est(:,1), T) == 1);
x_0 = X(repelem(group_est(:,1), T) == 1,:);
fe_0 = repelem(eye(n_0), T, 1);

b_0 = regress(y_0, horzcat(x_0, fe_0));

% Post C-Lasso regression coefficients in group 2
n_1 = sum(group_est(:,2));
y_1 = y(repelem(group_est(:,2), T) == 1);
x_1 = X(repelem(group_est(:,2), T) == 1,:);
fe_1 = repelem(eye(n_1), T, 1);

b_1 = regress(y_1, horzcat(x_1, fe_1));

% store coefficients
coeff = [b_0(1), b_0(2); b_1(1), b_1(2)];
end



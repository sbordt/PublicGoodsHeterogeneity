function [coeff, b_est, a_out, group_est] = PLS_Helper( M, fout, T, c_lambda)
%PLS_Helper 
%   Takes a matrix input in format [playerID, period, y, x1, x2] 
%   Writes the PLS assignments to fout
    y = M(:,3);
    X = M(:,4:5);
    N = length(M)/T;
    G = 2;                 % 2 groups
    
    lambda = c_lambda * var(y) / T^(1/3); % set the tuning parameter
    
    % estimate
    [coeff, b_est, a_out, group_est] = SSP_PLS_est_post(N, T, y, X, G, lambda, 500);
	disp(coeff);
	disp(sum(group_est(:,1)));
        
    % save grouping to file
    if fout
        csvwrite_pls_groups(fout, N, T, G, M(:,1), group_est); 
    end
end


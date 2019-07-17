function PLS_Helper_Singlevar( M, fout, T, c_lambda )
%PLS_Helper 
%   Takes a matrix input in format [playerID, period, y, x1] 
%   Writes the PLS assignments to fout
    y = M(:,3);
    X = M(:,4);
    nN = length(M)/T;
    nG = 2;                 % 2 groups
    
    lambda = c_lambda * var(y) / T^(1/3); % set the tuning parameter
    
    % full model
	[~, a_iter, group_iter] = SSP_PLS_est(nN, T, y, X, nG, lambda, 200);
	disp(a_iter);
    disp(sum(group_iter(:,1)));
        
	A = M(:,1);
	for i=1:nN
        for j=1:nG
            if group_iter(i,j) == 1
                for k=1:T
                    A(T*(i-1)+k,2) = j;
                end
            end
        end
	end
        
	csvwrite(fout, unique(A,'rows'));
end

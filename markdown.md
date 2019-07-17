# Replication files for "Estimating Grouped Patterns of Heterogneity in Repeated Public Goods Experiments"

We used Python 2.7, Stata 14 and Matlab R2015b.

## Replication Guide
### Fischbacher and Gächter (2010) data setup
- Obtain the dataset from [Fischbacher and Gächter (2010)](https://www.aeaweb.org/articles?id=10.1257/aer.100.1.541) and unzip it into `data/new data zip file`.
- Set the variable `project_path` in `stata/paths.do` to the project root directory.
- Run `fg2010_data_setup.do`

### deOliveira et al. (2015) data setup
- Obtain the dataset from  [deOliveira et al. (2015)](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=1883766) and unzip it into `data/deOliveira2015`. 
- Set the variable `project_path` in `stata/paths.do` to the project root directory.
- Run `deOliveira_data_setup.do`

### Grouped-Fixed-Effects in Python
- Run  `FG2010.ipynb` and `deOliveira2015.ipynb`.
- The bootstrapped standard errors are computed in`Bootstrapped_Standard_Errors.ipynb`.
- Run `csv_to_dta.to` to convert the Python output to Stata `*.dta` files.

### C-Lasso in Matlab
- Setup the replication files by [Zhentao Shi](https://github.com/zhentaoshi/C-Lasso). Our code requires `generic_functions/SSP_PLS_est.m` and `app_saving_PLS/hat_IC.m`.
- Run `FG2010.m` and `Oliveira2015.m`.
- For the information criterion, see `lambda.m`.

### Tables/Figures in Stata
- Run `csv_to_dta.do` to convert the Python/Matlab output to Stata `*.dta` files.
- Run `regressions.do` to obtain Tables 1 and 2.
- Run `compare_classifications.do` to obtain Table 3 (Panel B requires data by [Fallucci et al. (2018) ](https://link.springer.com/article/10.1007/s40881-018-0060-7)).


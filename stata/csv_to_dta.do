********************************************************************************
* csv -> dta
********************************************************************************
insheet using "${project_path}/data/FG2010_GFE.csv", clear
rename v1 playerID
rename v2 GFE_group
save ${project_path}/data/FG2010_GFE, replace
	
insheet using "${project_path}/data/FG2010_PLS.csv", clear
rename v1 playerID
rename v2 PLS_group
save ${project_path}/data/FG2010_PLS, replace

insheet using "${project_path}/data/deOliveira2015_GFE.csv", clear
rename v1 playerID
rename v2 GFE_group
save ${project_path}/data/deOliveira2015_GFE, replace

insheet using "${project_path}/data/deOliveira2015_PLS.csv", clear
rename v1 playerID
rename v2 PLS_group
save ${project_path}/data/deOliveira2015_PLS, replace

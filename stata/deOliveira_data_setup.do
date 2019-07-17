/*******************************************************************************
* prepare data as received from the authors for analysis
*******************************************************************************/
use ${project_path}/data/deOliveira2015/OBA_Panel_toshare, clear

merge m:1 code using ${project_path}/data/deOliveira2015/OBA_Short_toshare
drop _merge

sort treatment groupid2 code round

gen playerID = int((_n-1)/15)+1	// new playerID from 1-102
drop code

order treatment groupid2 playerID round

rename treatment information
rename groupid2 group
rename send cont
rename round period

save ${project_path}/data/deOliveira2015, replace
outsheet * using "${project_path}/data/deOliveira2015.csv", comma replace

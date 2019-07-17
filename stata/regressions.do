********************************************************************************
* FG2010 Regressions (OLS, FE & Post C-Lasso)
********************************************************************************
use ${project_path}/data/FG2010, clear

xtset playerID period
eststo clear

merge n:1 playerID using ${project_path}/data/FG2010_PLS
	
eststo: reg cont belief predictedcontribution, robust cl(session) 
eststo: xtreg cont belief predictedcontribution, fe robust cluster(session)
eststo: xtreg cont belief predictedcontribution if PLS_group == 1 , fe robust cluster(session)
eststo: xtreg cont belief predictedcontribution if PLS_group == 2 , fe robust cluster(session)
esttab using ${project_path}/outreg/FG2010.tex, replace fragment b(3) se(3) r2(2) 
eststo clear

********************************************************************************
* FG2010 GFE
********************************************************************************
use ${project_path}/data/FG2010, clear

xtset playerID period
eststo clear

merge n:1 playerID using ${project_path}/data/FG2010_GFE

reg cont belief predictedcontribution i.period if GFE_group == 1 , robust cluster(session)
reg cont belief predictedcontribution i.period  if GFE_group == 2 , robust cluster(session)
esttab using ${project_path}/outreg/FG2010_GFE.tex, replace fragment b(3) se(3) r2(2)
eststo clear

********************************************************************************
* deOliveira2015 Regressions (OLS, FE & Post C-Lasso)
********************************************************************************
use ${project_path}/data/deOliveira2015, clear

xtset playerID period
eststo clear

merge n:1 playerID using ${project_path}/data/deOliveira2015_PLS
	
eststo: reg cont belief, robust 
eststo: xtreg cont belief, fe robust 
eststo: xtreg cont belief if PLS_group == 1 , fe robust
eststo: xtreg cont belief if PLS_group == 2 , fe robust 
esttab using ${project_path}/outreg/deOliveira2015.tex, replace fragment b(3) se(3) r2(2) 
eststo clear

********************************************************************************
* deOliveira2015 GFE
********************************************************************************
use ${project_path}/data/deOliveira2015, clear

xtset playerID period
eststo clear

merge n:1 playerID using ${project_path}/data/deOliveira2015_GFE

eststo: reg cont belief i.period if GFE_group == 1 , robust 
eststo: reg cont belief i.period if GFE_group == 2 , robust
esttab using ${project_path}/outreg/deOliveira2015_GFE.tex, replace fragment b(3) se(3) r2(2)
eststo clear



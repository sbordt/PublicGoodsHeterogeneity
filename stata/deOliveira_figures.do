*******************************************************************************
* Visualize the development of contributions, beliefs and predicted 
* contributions for all players in the deOliveira2015 data
*******************************************************************************
set scheme plotplainblind

use ${project_path}/data/deOliveira2015, clear
levelsof group, local(groups)

foreach group of local groups{
	use ${project_path}/data/deOliveira2015, clear
	merge n:1 playerID using ${project_path}/data/deOliveira2015_PLS
	drop _merge
	merge n:1 playerID using ${project_path}/data/deOliveira2015_GFE
	drop _merge
	
	recode GFE_group (2=1) (1=2)
	
	keep if group == `group'

	gen description = "C-Lasso: " + string(PLS_group) + ", GFE: " + string(GFE_group)
	local graphnames ""	  
				
	levelsof playerID, local(subjects)

	foreach subject of local subjects {
		preserve
		keep if playerID == `subject'
		local desc = description[1]
		local info = information[1]
		restore
				
		twoway (connected cont period if playerID == `subject', lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) /// 
			   (connected belief period if playerID == `subject', lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(Dh)) ///
				, xlabel(1(1)15) ylabel(0(5)20) xsize(8) ysize(5) title("Group `group', Subject Nr. `subject', Information: `info', `desc'") xtitle("")  ytitle("") legend(order(1 "Contribution" 2 "Belief") position(6) rows(1)) name("subject_`subject'") 
						
		local graphnames `graphnames' subject_`subject'
	}
	
	graph combine `graphnames', row(2) col(2) xsize(20) ysize(12) iscale(0.4)
					
	graph export "${project_path}/figures/deOliveira_G`group'.pdf", replace
	graph drop _all
}

* figures in presentation
use ${project_path}/data/deOliveira2015, clear
keep if playerID == 7 
twoway (connected belief period, lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(D)) ///
		(connected cont period, lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) ///  
	, xlabel(1(1)15) ylabel(0(5)20) xsize(6) ysize(5) title("Subject Nr. 7") xtitle("Period")  ytitle("Mean of variable") legend(order(2 "Contribution" 1 "Belief") position(6) rows(1))
graph export "${project_path}/tex/figures/deOliveira_S7.pdf", replace

use ${project_path}/data/deOliveira2015, clear
keep if playerID == 11 
twoway (connected belief period, lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(D)) ///
	   (connected cont period, lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) /// 
	, xlabel(1(1)15) ylabel(0(5)20) xsize(6) ysize(5) title("Subject Nr. 11") xtitle("Period")  ytitle("Mean of variable") legend(order(2 "Contribution" 1 "Belief") position(6) rows(1))
graph export "${project_path}/tex/figures/deOliveira_S11.pdf", replace		

					

*******************************************************************************
* Visualize the development of contributions, beliefs and predicted 
* contributions for all players in the Fischbaer & Gächter 2010 data
*******************************************************************************
set scheme plotplainblind
graph drop _all

foreach session of numlist 1/6 {
	use ${project_path}/data/FG2010, clear
	merge n:1 playerID using ${project_path}/data/FG2010_PLS
	drop _merge
	merge n:1 playerID using ${project_path}/data/FG2010_GFE
	drop _merge
	
	recode GFE_group (1=2) (2=1)
	keep if session == `session'
	
	gen description = "Grouped Fixed-Effects: " + string(GFE_group) + ", C-Lasso: " + string(PLS_group) 
			
	local graphnames ""	  
				
	levelsof player, local(subjects)
	local i = 1
	local j = 1

	foreach subject of local subjects {
		preserve
		keep if player == `subject'
		local desc = description[1]
		restore
				
		twoway (connected predictedcontribution period if player == `subject', lcolor(gs12) mcolor(gs12) lpattern(shortdash) msymbol(Sh) msize(4) ) ///
			   (connected belief period if player == `subject', lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(Dh)) ///
			   (connected cont period if player == `subject', lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) /// 
				, xlabel(1(1)10) ylabel(0(5)20) xsize(8) ysize(5) title("Session `session', Subject Nr. `subject', `desc'") xtitle("")  ytitle("") legend(order(3 "contribution" 2 "belief" 1 "predicted contribution") position(6) rows(1)) name("subject_`subject'") 
						
		local graphnames `graphnames' subject_`subject'
					
		if mod(`i',6) == 0 | (`session' == 3 & `i' == 20){
			if mod(`i',6) == 0 {
				graph combine `graphnames', row(2) col(3) xsize(20) ysize(12) iscale(0.4)
			}
			else {	// session 3 is special in that it has only 20 players
				graph combine `graphnames', row(1) col(2) xsize(13.33) ysize(6) iscale(0.8)
			}
			graph export "${project_path}/figures/FG2010_S`session'_`j'.pdf", replace
			
			graph drop _all
			local graphnames ""
			local j = `j'+1
		}
		
		local i = `i'+1
	}
}

* figures in the paper
use ${project_path}/data/FG2010, clear
keep if session == 1 & player == 11
twoway (connected predictedcontribution period, lcolor(gs12) mcolor(gs12) lpattern(shortdash) msymbol(S) msize(4) ) ///
	   (connected belief period, lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(D)) ///
	   (connected cont period, lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) /// 
		, xlabel(1(1)10) ylabel(0(5)20) xsize(6) ysize(5) title("Session 1, Subject 11") xtitle("Period")  ytitle("Mean of variable") legend(order(3 "contribution" 2 "belief" 1 "predicted contribution") position(6) rows(1))
graph export "${project_path}/tex/figures/FG2010_S1_P11.pdf", replace			

use ${project_path}/data/FG2010, clear
keep if session == 1 & player == 19
twoway (connected predictedcontribution period, lcolor(gs12) mcolor(gs12) lpattern(shortdash) msymbol(S) msize(4) ) ///
	   (connected belief period, lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(D)) ///
	   (connected cont period, lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) /// 
		, xlabel(1(1)10) ylabel(0(5)20) xsize(6) ysize(5) title("Session 1, Subject 19") xtitle("Period")  ytitle("Mean of variable") legend(order(3 "contribution" 2 "belief" 1 "predicted contribution") position(6) rows(1))
graph export "${project_path}/tex/figures/FG2010_S1_P19.pdf", replace		

use ${project_path}/data/FG2010, clear
keep if session == 1 & player == 16
twoway (connected predictedcontribution period, lcolor(gs12) mcolor(gs12) lpattern(shortdash) msymbol(S) msize(4) ) ///
	   (connected belief period, lcolor(eltblue) mcolor(eltblue) lpattern(shortdash) msize(4) msymbol(D)) ///
	   (connected cont period, lcolor(black) lpattern(solid) mcolor(black) msize(2) msymbol(circle)) /// 
		, xlabel(1(1)10) ylabel(0(5)20) xsize(6) ysize(5) title("Session 1, Subject 16") xtitle("Period")  ytitle("Mean of variable") legend(order(3 "contribution" 2 "belief" 1 "predicted contribution") position(6) rows(1))
graph export "${project_path}/tex/figures/FG2010_S1_P16.pdf", replace		





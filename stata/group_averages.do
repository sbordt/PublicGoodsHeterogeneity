
cd ${project_path}/data
set scheme plotplainblind

********************************************************************************
* PLS
********************************************************************************
use FG2010, clear
merge n:1 playerID using "FG2010_PLS"

format cont belief predictedcontribution %9.2f 

bys PLS_group: sum cont if period == 1, format 
bys PLS_group: sum belief if period == 1, format 
bys PLS_group: sum predictedcontribution if period == 1, format 

bys PLS_group: sum cont if period == 10, format 
bys PLS_group: sum belief if period == 10, format 
bys PLS_group: sum predictedcontribution if period == 10, format 

bys PLS_group: sum cont, format 
bys PLS_group: sum belief, format 
bys PLS_group: sum predictedcontribution, format 

********************************************************************************
* GFE
********************************************************************************
use FG2010, clear
merge n:1 playerID using "FG2010_GFE"

format cont belief predictedcontribution %9.2f 

bys GFE_group: sum cont if period == 1, format 
bys GFE_group: sum belief if period == 1, format 
bys GFE_group: sum predictedcontribution if period == 1, format 

bys GFE_group: sum cont if period == 10, format 
bys GFE_group: sum belief if period == 10, format 
bys GFE_group: sum predictedcontribution if period == 10, format 

bys GFE_group: sum cont, format 
bys GFE_group: sum belief, format 
bys GFE_group: sum predictedcontribution, format 

********************************************************************************
* PLS figures
********************************************************************************

* group 1
use FG2010, clear
merge n:1 playerID using "FG2010_PLS"

keep if PLS_group == 1

bys period: egen period_cont = mean(cont)
bys period: egen period_belief = mean(belief)
bys period: egen period_predictedcontribution = mean(predictedcontribution)
bys period: egen period_othercont = mean(othercont)

duplicates drop period, force

twoway 	(connected period_predictedcontribution period, lcolor(gs12) lwidth(thick) lpattern(solid) mcolor(gs12) msize(4) msymbol(circle) ) ///
		(connected period_belief period, lcolor(eltblue) lwidth(thick) lpattern(solid) mcolor(eltblue) msize(4) msymbol(circle)) ///
		(connected period_cont period, lcolor(black) lwidth(thick) lpattern(solid) mcolor(black) msize(4) msymbol(circle)) /// 
			, xlabel(1(1)10) ylabel(0(5)20) xsize(6) ysize(5) xtitle("Period") ytitle("Mean of variable") legend(order(3 "Contribution" 2 "Belief" 1 "Predicted contribution") position(6) rows(1))
						
graph export ${project_path}\tex\figures\PLS_group_1_averages.pdf, replace

* group 2
use FG2010, clear
merge n:1 playerID using "FG2010_PLS"

keep if PLS_group == 2

bys period: egen period_cont = mean(cont)
bys period: egen period_belief = mean(belief)
bys period: egen period_predictedcontribution = mean(predictedcontribution)
bys period: egen period_othercont = mean(othercont)

duplicates drop period, force

twoway  (connected period_predictedcontribution period, lcolor(gs12) lwidth(thick) lpattern(solid) mcolor(gs12) msize(4) msymbol(circle) ) ///
		(connected period_belief period, lcolor(eltblue) lwidth(thick) lpattern(solid) mcolor(eltblue) msize(4) msymbol(circle)) ///
		(connected period_cont period, lcolor(black) lwidth(thick) lpattern(solid) mcolor(black) msize(4) msymbol(circle)) /// 
			, xlabel(1(1)10) ylabel(0(5)20) xsize(6) ysize(5) xtitle("Period") ytitle("Mean of variable")  legend(order(3 "Contribution" 2 "Belief" 1 "Predicted contribution") position(6) rows(1))
						
graph export ${project_path}\tex\figures\PLS_group_2_averages.pdf, replace


********************************************************************************
* GFE figures
********************************************************************************

* average behavior in the experiment
use FG2010, clear

bys period: egen period_cont = mean(cont)
bys period: egen period_belief = mean(belief)
bys period: egen period_predictedcontribution = mean(predictedcontribution)

duplicates drop period, force

twoway  (connected period_predictedcontribution period, lcolor(gs12) lwidth(thick) lpattern(solid) mcolor(gs12) msize(4) msymbol(circle) ) ///
		(connected period_belief period, lcolor(eltblue) lwidth(thick) lpattern(solid) mcolor(eltblue) msize(4) msymbol(circle)) ///
		(connected period_cont period, lcolor(black) lwidth(thick) lpattern(solid) mcolor(black) msize(4) msymbol(circle)) /// 
			, xlabel(1(1)10) ylabel(0(5)15) xsize(6) ysize(5) xtitle("Period") ytitle("Mean of variable")  legend(order(3 "Contribution" 2 "Belief" 1 "Predicted contribution") position(6) rows(1))
						
graph export ${project_path}\tex\figures\fg2010.pdf, replace

* average behavior in group 2
use FG2010, clear
merge n:1 playerID using "FG2010_GFE"

keep if GFE_group == 1

bys period: egen period_cont = mean(cont)
bys period: egen period_belief = mean(belief)
bys period: egen period_predictedcontribution = mean(predictedcontribution)

duplicates drop period, force

twoway  (connected period_predictedcontribution period, lcolor(gs12) lwidth(thick) lpattern(solid) mcolor(gs12) msize(4) msymbol(circle) ) ///
		(connected period_belief period, lcolor(eltblue) lwidth(thick) lpattern(solid) mcolor(eltblue) msize(4) msymbol(circle)) ///
		(connected period_cont period, lcolor(black) lwidth(thick) lpattern(solid) mcolor(black) msize(4) msymbol(circle)) /// 
			, xlabel(1(1)10) ylabel(0(5)15) xsize(6) ysize(5) xtitle("Period") ytitle("Mean of variable")  legend(order(3 "Contribution" 2 "Belief" 1 "Predicted contribution") position(6) rows(1))
						
graph export ${project_path}\tex\figures\fg2010_gfe_group2.pdf, replace

* average behavior in group 1
use FG2010, clear
merge n:1 playerID using "FG2010_GFE"

keep if GFE_group == 2

bys period: egen period_cont = mean(cont)
bys period: egen period_belief = mean(belief)
bys period: egen period_predictedcontribution = mean(predictedcontribution)

duplicates drop period, force

twoway  (connected period_predictedcontribution period, lcolor(gs12) lwidth(thick) lpattern(solid) mcolor(gs12) msize(4) msymbol(circle) ) ///
		(connected period_belief period, lcolor(eltblue) lwidth(thick) lpattern(solid) mcolor(eltblue) msize(4) msymbol(circle)) ///
		(connected period_cont period, lcolor(black) lwidth(thick) lpattern(solid) mcolor(black) msize(4) msymbol(circle)) /// 
			, xlabel(1(1)10) ylabel(0(5)15) xsize(6) ysize(5) xtitle("Period") ytitle("Mean of variable")  legend(order(3 "Contribution" 2 "Belief" 1 "Predicted contribution") position(6) rows(1))
						
graph export ${project_path}\tex\figures\fg2010_gfe_group1.pdf, replace




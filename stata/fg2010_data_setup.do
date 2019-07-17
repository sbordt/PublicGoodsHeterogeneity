use "${project_path}/data/new data zip file/figae_beliefs&contributions.dta", clear

* rename variables 
rename idsess session
rename subject player
rename contribution cont
rename idtyp preftype

order session player period
sort session player period
 
gen random = 1

bys session group period: egen totcont = total(cont)
gen profit = 20-cont + 0.4*totcont

rename otherscontrib othercont

keep session group period player idsubj cont othercont profit preftype belief b* u predictedcontribution sequencePC
gen experiment = "Fischbaer & Gächter 2010"

order experiment session group period player idsubj cont othercont profit

label var preftype "Preference type: 1= conditional cooperator; 2= selfish ; 3= triangle; 4 = other"	// misslabeled in the original dataset

gen oldid = 200000*session+player
egen playerID = group(oldid)
drop oldid

sort playerID period
xtset playerID period
tsset playerID period

bys playerID: gen firstcont = cont[1]
bys playerID: gen initialbelief = belief[1]

gen Lcont = L.cont
gen L2cont = L.Lcont
gen L3cont = L.L2cont

gen Lothercont = L.othercont
gen L2othercont = L.Lothercont
gen L3othercont = L.L2othercont

label var session 	"Session No. within the original experiment"
label var group  	"Group No. (within session)"
label var player  	"Subject No. (within session)"
label var playerID  "Unique subject No. within the dataset"

order experiment playerID idsubj period

save ${project_path}/data/FG2010, replace
outsheet * using "${project_path}/data/FG2010.csv", comma replace


# Metadata for the leaf ergosterl data from the priming-decomp experiment

## File

`leaf_ergosterol.csv`

## Metadata

* Collected by: KF and JH

* Collected on: 20 June 2016

* Affiliation: Longwood University

* Location: Longwood University

### Description

These data are for the leaf ergosterol measurements of the leaves in the sediment priming experiment. Details of the the experiment can be found in: 

[

The ergosterol on the leaves were measured on 19 Spet 2017 after being stored in MeOH at -20 d C.

The ergosterol was measured via:

Samples were saponified at 80 degrees Celsius for 30 minutes in 10 mL of 8 g/L potassium hydroxide in methanol. Afterward, samples were allowed to cool and received 3 mL DI water. We then conducted 3 pentane rinses in which 10 mL pentane were added to each vial, and vials were vortexed for 30 seconds. After separation of the pentane layer from the aqueous layer, the top pentane layer was pulled off into a separate vial and evaporated under constant stream of nitrogen gas. After 3 repeated pentane rinses, pentane was completely evaporated to dryness and the resultant pellet was re-suspended in 1 mL methanol, vortexed (15 seconds), and sonicated for 5 minutes. Samples were then transfered to HPLC vials and run on a Shimadzu 10VP HPLC equipped with a Whatman Partisphere C18 reverse-phase column set at 40 degrees C. The UV detector was set to 282 nm and a 100% methanol flow at 1 mL/min. 

* file created on 3 Oct 2017 - KF

* Modified

## R Code

### Import Data 

    erg <- read.table("./data/leaf_ergosterol_raw.csv", header = T, sep = ",")
 
## Variable Descriptions

* Bottle = the identifying number of the experimental bottle

* Postion = the position of the leaves in the bottle
  * Top = on the shelf above the sediments
  * Sed = resting on the sediment surface

* LeafNum = the number of leaf discs in the sample

* CrucNum = the ID of the crucible
 
* CrucMass = the mass of the empty crucuble (g)
 
* CrucLeafDM = the mass of the crucible plus the mass of all of the dried leaf discs (g) 

* CrucAM = the mass of the crucuble plus the ash following 4 h at 550 dC (g)
 
* LeafMass =  the mass of all the leaf discs in the crucible (g)
 
* AshMass = the mass of the ash in crucible (g)
 
* AFDM = the ash-free-dry-mass of a single leaf disc (g) - determined as AFDM_Total / LeafNum
 
* PropOM = the proportion of OM in the leaf discs
 
* PercOM = the percentage of OM in the leaf discs
 
* AFDM_Total = the ash-free-dry-mass of all the leaf discs in the crucible (g)
 
* Total_Ergosterol_ug = the mass of ergosterol measured on 2 leaf discs from the microcosm (ug)
 
## Calculations
 
The ergosterol mass was measured on 2 leaf discs so the ergosterol mass per leaf disc is half what is measured.
 
     Erg_per_leaf <- erg$Total_Ergosterol_ug / 2
 
To get the ergosterol per AFDM of leaf (ug ergosterol / g AFDM):
  
     Erg_mass_norm <- Erg_per_leaf / erg$AFDM

To get the ergosterol per leaf surface area I calculated the surface area of a leaf as:
  
     leaf_R <- (13.5 / 100)/2 # diameter = 13.5mm -> cm 
     leaf_SA <- pi * (leaf_R^2)

~~~~

Leaf Surface Area (cm^2)
> leaf_SA 
[1] 0.01431388

~~~~
  
To normalize the ergosterol by leaf surface area (ug Ergosterol / cm^2 SA):
  
    Erg_area_norm <- Erg_per_leaf / (leaf_SA * 2) # multiplied by 2 because each leaf has 2 sides.

### Create a Data Frame

    erg_calc <- data.frame(erg, Erg_per_leaf, Erg_mass_norm, leaf_R, leaf_SA, Erg_area_norm)

### Calculated Variable Descriptions
 
* Erg_per_leaf = the mass of ergosterol on a single leaf disc (ug)
 
* Erg_mass_norm = the mass of ergosterol normalized to the mass of the leaf disc (ug Ergosterol / g AFDM leaf)
 
* leaf_R = the radius of the leaf discs (cm)
 
* leaf_SA = the surface area of a leaf disc (cm^2)

* Erg_area_norm = the mass of ergosterol normalized to both leaf disc surfaces (ug Ergosterol / cm^2) 
 
 
## Write Data File
 
    write.table(erg_calc, "./data/leaf_ergosterol.csv", quote = F, row.names = F, sep = ",")

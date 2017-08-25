# Metadata for the Ash Mass from the priming-decomp experiment

## File

`final_AFDM.csv`

## Metadata

* Collected by: KF and JH

* Collected on: 20 June 2016

* Affiliation: Longwood University

* Location: Longwood University

### Modified 

* 21 March 2017 - KF - added calculated variables
* 25 Aug 2017 - KF - clarified AFDM for single leaf disc or group

### Description

These data are for the preparation of the leaves for ash mass in the sediment priming experiment. Details of the the experiment can be found in the lab notes.


* file created on 24 june 2016 - KF

* Modified

  * 29 June 2016 - KF - changed the CrucLeafDM mass from 29.2417 to 28.2417 since the larger number was likely a data entry mistake

## Variable Descriptions

* Bottle = the identifying number of the experimental bottle

* Postion = the position of the leaves in the bottle
  * Top = on the shelf above the sediments
  * Sed = resting on the sediment surface

* LeafNum = the number of leaf discs in the crucible

* CrucNum = the number that was labeled on the crucible prior to the experiment

* CrucMass = the weight of the crucible (g)

* CrucLeafDM = the weight of the crucible and leaf dry mass (g)

* CrucAM = the weight of the crucible and ash mass (g)

# Calculated Variables

## Calculated Variable Descriptions

* LeafMass = the total dry mass of the leaf discs in the crucible (g)

* AshMass = the total mass of the ash remaining in the crucible after approximatey 4 h at 550 dC (g)

* AFDM_Total = the total ash free dry mass of all the leaf discs in the crucible, which is the mass of the sample minus the mass of the ash (g).

* PropOM = the proportion of the sample mass that is organic matter (i.e., combustable at 550 dC)

* PercOM = the percent of the sample mass that is organic matter (i.e., combustable at 550 dC)

* AFDM = the ash free dry mass of a single leaf disc (g)

### Import Data

    leaf <- read.table("./data/final_AFDM.csv", header = T, sep = ",") 

### Variable Calculations

    leaf$LeafMass <- leaf$CrucLeafDM - leaf$CrucMass
    leaf$AshMass <- leaf$CrucAM - leaf$CrucMass
    leaf$AFDM_Total <- LeafMass - AshMass
    leaf$PropOM <- AFDM_Total / LeafMass
    leaf$PercOM <- PropOM * 100
    leaf$AFDM <- AFDM_Total/leaf$LeafNum

# Write to table

    write.table(leaf, "./data/final_AFDM.csv", row.names = F, quote = F, sep = ",")

# Analysis of the mass loss of the leaves in the sediment priming experiment.

## Metadata

* file created 8 April 2019

* Modified:

### Description

These analyses are to evaluate the OM mass and percent in the sediments used in the microcosms.

Details on the experimental set-up and execution can be found: [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md) & [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md)

## Analysis

### Import data

    sed <- read.table("./data/inital_om.csv", header = T, sep = ",")
   
### Determine mass in microcosm
    
The dry mass, AFDM, and perc OM, was determined from a 10 ml sample of the slurry. Each microcosm contained 100 ml of slurry.  

Thus, the dry mass and om mass of the microcosm was 10X what was measured in the sample.

    sed.dry.mass.micro <- sed$dry.mass[sed$sample == "sed"] * 10
    sed.om.mass.micro <- sed$om.mass[sed$sample == "sed"] * 10
    
#### Results Summary
    
    summary(sed.dry.mass.micro)
    sd(sed.dry.mass.micro)
    # Mean Dry Mass of Sediment in the Microcosms (g)
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
    8.148   8.240   8.332   8.279   8.345   8.357  0.1141359
    
    summary(sed.om.mass.micro)
    sd(sed.om.mass.micro)
    # Mean AFDM of the Sediment in the Microcosms (g)
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
    1.359   1.378   1.397   1.389   1.405   1.412  0.0273191
    
    summary(sed$prop.om[sed$sample == "sed"])
    sd(sed$prop.om[sed$sample == "sed"])
    # Mean proportion of OM of the Sediments in the Microcosms
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    SD
    0.1668  0.1672  0.1677  0.1678  0.1683  0.1690  0.001091998
    
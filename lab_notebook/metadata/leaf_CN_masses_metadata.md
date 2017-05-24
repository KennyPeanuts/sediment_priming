# Metadata for the CN data from the priming-decomp experiment

## File

`leaf_CN_masses.csv`

## Metadata

* Collected by: KF and JH

* Collected on: 20 June 2016

* Affiliation: Longwood University

* Location: Longwood University

### Description

These data are for the preparation of the leaves for CN analysis in the sediment priming experiment. Details of the the experiment can be found in the lab notes.


* file created on 22 june 2016 - KF

* Modified

## R Code

     bottle <- c(rep(1:10, 2))
     position <- c(rep("top", 10), rep("sed", 10))
     leaf.num <- rep(3, 20)
     vial.mass <- c(13.5956, 13.5049, 13.5824, 13.6471, 13.5664, 13.6252, 13.5751, 13.6427, 13.5335, 13.7178, 13.5389, 13.6254, 13.5619, 13.6141, 13.5842, 13.5507, 13.4698, 13.6824, 13.6403, 13.5518)
     vial.leaf <- c(13.6043, 13.5146, 13.5932, 13.6566, 13.5762, 13.6355, 13.5846, 13.6527, 13.5422, 13.7272, 13.5467, 13.6376, 13.5710, 13.6227, 13.5946, 13.5589, 13.4805, 13.6924, 13.6474, 13.5586)
     leaf.mass <- vial.leaf - vial.mass  
  
     leafCN <- data.frame(bottle, position, leaf.num, vial.mass, vial.leaf, leaf.mass)  

     write.table(leafCN, "./data/leaf_CN.csv", quote = F, row.names = F, sep = ",")

## Variable Descriptions

* bottle = the identifying number of the experimental bottle

* postion = the position of the leaves in the bottle
  * top = on the shelf above the sediments
  * sed = resting on the sediment surface

* leaf.num = number of leaves in the bottle

* vial.mass = the mass of the empty scintillation vial (g)

* vial.leaf = the mass of the vial plus the dried leaves (g)

* leaf.mass = the mass of the drie leaves (g)

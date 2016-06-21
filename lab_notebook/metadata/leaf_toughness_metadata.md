# Metadata for the leaf toughness data from the priming-decomp experiment

## File

`leaf_toughness.csv`

## Metadata

* Collected by: KF and JH

* Collected on: 20 June 2016

* Affiliation: Longwood University

* Location: Longwood University

### Description

These data are for the leaf tougness measurements of the leaves in the sediment priming experiment. Details of the the experiment can be found in: 

[


* file created on 22 june 2016 - KF

* Modified

## R Code

    bottle <- c(1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10)
    position <- c(rep("top", 30), rep("sed", 30))
    leaf <- c(rep(1:3, 20))
    cup.mass <- c(rep(6.0538, 4), rep(12.2012, 60-4))
    vol <- c(24.5, 23.0, 24.75, 40, 16, 10, 60.7620, 43.75, 23.75, 58.2844, 13, 26, 7.3, 42.5, 4, 34, 56.7844, 7.2, 9.6, 38, 3.8, 34.5, 52.5, 11.5, 38, 14, 18.5, 48, 5.4, 13.5, 15, 18, 38, 4.6, 4.4, 21.0, 3., 14, 15, 8.6, 5.8, 5.6, 16.5, 5.2, 4, 13.5, 2.2, 2.0, 34.5, 10.5, 10.0, 6.2, 11, 0, 1, 0, 2.8, 0, 5.4, 9.7)
    mass <- cup.mass + vol

    tough <- data.frame(bottle, position, leaf, cup.mass, vol, mass)

    write.table(tough, "./data/leaf_toughness.csv", quote = F, row.names = F, sep = ",")

## Variable Descriptions

* bottle = the identifying number of the experimental bottle

* postion = the position of the leaves in the bottle
  * top = on the shelf above the sediments
  * sed = resting on the sediment surface

* leaf = the replicate number of the leaf measured

* cup.mass = the mass of the empty water cup on the penetrometer. Two cups were used. The first 4 samples were run with a smaller cup that did not have enough volume, so a large cup was used for the remaining samples

* vol = the volume of water added to the cup when the leaf was punctured

* mass = the total mass of the water and cup, needed to penetrate the leaf


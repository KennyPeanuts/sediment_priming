# Initial Organic Matter Content of Sediment and Leaf Discs

## Metadata

File created 8 June 2016 - KF

### Description 

These data are the inital organic matter calculations for the sediment priming experiment

A description of the sediment collection and leaf processing in found in [Notes_on_set_up.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md)

Organic matter was determined by LOI at 550 dC

### R Code

    sample <- c(rep("sed", 3), rep("leaf", 9))
    cruc.num <- c(18, 6, 16, 15, 9, 13, 2, 24, 20, 1, 7, 4)
    cruc.mass <- c(29.4371, 31.5170, 28.8739, 26.9927, 27.0812, 29.7280, 26.6541, 29.3995, 29.1398, 29.7392, 28.1992, 27.4885)
    cruc.samp <- c(30.2519, 32.3527, 29.7071, 27.0267, 27.1137, 29.7571, 26.6856, 29.4370, 29.1725, 29.7712, 28.2330, 27.5245)
    cruc.ash <- c(30.1160, 32.2115, 29.5674, 26.9934, 27.0733, 29.7286, 26.6537, 29.3948, 29.1357, 29.7350, 28.1991, 27.4890)
    leaf.num <- c(NA, NA, NA, 10, 10, 10, 10, 10, 10, 10, 10, 10)

#### Calculated Parameters

    dry.mass <- cruc.samp - cruc.mass
    ash.mass <- cruc.ash - cruc.mass
    om.mass <- dry.mass - ash.mass
    prop.om <- (om.mass / dry.mass) 

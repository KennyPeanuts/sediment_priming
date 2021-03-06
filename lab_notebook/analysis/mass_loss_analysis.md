# Analysis of the mass loss of the leaves in the sediment priming experiment.

## Metadata

* file created 29 June 2016 - KF

* Modified:
    * 30 Jan 2018 - KF - summarized the leaf disc mass
    * 2 Feb 2018 - KF - consolodated all of the mass loss analysis here - including AFDM, C and N
    * 20 Feb 2018 - KF - NOTE I recalculated the mass loss for C and N using the masses from the data but then realized that these were just molar masses calculated with a constant rather than from the sample masses so they provided no information beyond that of the percents.  I reverted those calculations back to this version which has the C and N mass calculated as the propC or N multipled by the AFDM.
    * 8 March 2019 - KF - re-analyzed the significance of AFDM loss the location using the difference between the top and the sediment leaves and then tested if mean == 0 with a t-test.
    * 15 April - KF - re-analyzed the significance of C and N mass loss the location using the difference between the top and the sediment leaves and then tested if mean == 0 with a t-test. Made plots of the AFDM loss, C mass loss, and N mass loss difference.


### Description

These analyses are to evaluate the change in mass of the leaves in the sediment priming experiment. Including the changes in AFDM, C mass, and N mass.

Details on the experimental set-up and execution can be found: [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md) & [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md)

## Analysis

### Import data

    leaf.initial <- read.table("./data/inital_om.csv", header = T, sep = ",")
    leaf.final <- read.table("./data/final_AFDM.csv", header = T, sep = ",")
    cn <- read.table("data/leaf_disc_CN.csv", header = T, sep = ",")
    init_om <- read.table("data/inital_om.csv", header = T, sep = ",")

### Determine Average inital leaf AFDM mass

The initial leaf mass samples consisted of 10 leaves

    init.leaf.mass <- leaf.initial$om.mass[leaf.initial$sample == "leaf"]
    sing.init.leaf.mass <- init.leaf.mass / leaf.initial$leaf.num[leaf.initial$sample == "leaf"]
    mean.init.mass <- mean(sing.init.leaf.mass)

~~~~
# mean AFDM mass of a single leaf prior to the beginning the exp (g)
  
> mean.init.mass
[1] 0.003541111

~~~~

### Determine the Average Initial percent C and percent N

These data come from the samples collected during the leached litter experiment.  Details about the sample collection can be found at [https://github.com/KennyPeanuts/CPOM_Flux/blob/master/lab_notebook/lab_notes/leached_litter_CN_notes.md](https://github.com/KennyPeanuts/CPOM_Flux/blob/master/lab_notebook/lab_notes/leached_litter_CN_notes.md).  

Briefly, each of the initial samples contained 20, 10 mm leaf discs that were cut from tulip poplar litter that had been leached in DI water for 72 h. These leaves were then processed and run for CN by the Waters lab in the same way as the experimental leaves were.

#### Create data.frame from the leached litter CN 

    rep <- c("A", "B") 
    percC <- c(45.8, 44.47)
    percN <- c(0.94, 1.03)
    CN <- c(56.47032605, 50.39153614)

    initial_cn <- data.frame(rep, percC, percN, CN)

##### Summary of Initial CN data

    summary(initial_cn)
    sd(initial_cn$percC)
    sd(initial_cn$percN)
    sd(initial_cn$CN)
    length(initial_cn$CN) #just chose a variable but all the lengths are the same

### Determine Average Final AFDM
  
    final.DM <- leaf.final$CrucLeafDM - leaf.final$CrucMass
    final.AM <- leaf.final$CrucAM - leaf.final$CrucMass
    final.AFDM <- final.DM - final.AM

Since there were different numbers of leaves in the crucibles `final.AFDM` is the mass of the total leaves in the crucible

    final.leaf.AFDM <- final.AFDM / leaf.final$LeafNum

### Summarize final leaf mass

    tapply(final.leaf.AFDM * 1000, leaf.final$Position, summary)
    tapply(final.leaf.AFDM * 1000, leaf.final$Position, sd)
    tapply(final.leaf.AFDM * 1000, leaf.final$Position, length)

#===============================================
    
    # Summary of the average mass of a single leaf disc at the end of the exp, by position (mg)
 
    $Sed
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD         N
    1.940   2.155   2.490   2.440   2.515   3.480  0.4320494  10

    $Top
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD         N
    1.920   2.315   2.580   2.677   3.125   3.540  0.5362904  10
    
#==================================================

###  Determine Mass Lost

    AFDM.loss <- mean.init.mass - final.leaf.AFDM

    tapply(AFDM.loss * 1000, leaf.final$Position, summary) 
    tapply(AFDM.loss * 1000, leaf.final$Position, sd)
    tapply(AFDM.loss * 1000, leaf.final$Position, length)
 
#=======================================
    
    AFDM Loss from each postion (mg)

    $Sed
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD        N
    0.06111 1.02600 1.05100 1.10100 1.38600 1.60100  0.4320494 10

    $Top
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.  SD        N
    0.001111 0.416100 0.961100 0.864400 1.226000 1.621000  0.5362904 10

#=======================================
 
## Statistical Analysis

##### Calculate the difference in AFDM loss

    diff.AFDM.loss <- AFDM.loss[leaf.final$Position == "Top"] - AFDM.loss[leaf.final$Position == "Sed"]
    
    t.test(diff.AFDM.loss, mu = 0)
    
Using a t-test of the difference between the leaves on the top and sed is the best approach since it does not treat the leaves in the different positions to be independent but tests if their difference is not equal to 0, which would indicate that one position is consistently greater or lesser.
    
#============================== 
    
    One Sample t-test
    
    data:  diff.AFDM.loss
    t = -0.85718, df = 9, p-value = 0.4136
    alternative hypothesis: true mean is not equal to 0
    95 percent confidence interval:
      -0.0008612448  0.0003879115
    sample estimates:
      mean of x 
    -0.0002366667 
    
#============================== 

#### Plot of the difference in AFDM loss between the top and sed leaves
    
    par(las = 1)
    plot((diff.AFDM.loss * 1000), xlim = c(0, 11))
    abline(h = 0)
    
### Determine the C mass of the leaves
 

The C mass of the leaf discs at the end of the experiment is estimated by the % C of the leaves after to incubation and the mass of the leaves after incubation

To complete this calculation, I need a treatment level variable for the cn data.frame

     cn.position <- c(rep("top", 10), rep("sed", 10))

I now calculate mass of C for each treatment level:

    disc_C_mass_final_TOP <- leaf.final$AFDM[leaf.final$Position == "Top"] * ((cn$percC[cn.position == "top"]) / 100) # convert to proportion
    disc_C_mass_final_SED <- leaf.final$AFDM[leaf.final$Position == "Sed"] * ((cn$percC[cn.position == "sed"]) / 100)
    disc_C_mass_final <- c(disc_C_mass_final_TOP, disc_C_mass_final_SED) * 1000 # convert to mg

    tapply(disc_C_mass_final, leaf.final$Position, summary) 
    tapply(disc_C_mass_final, leaf.final$Position, sd)
    tapply(disc_C_mass_final, leaf.final$Position, length)

~~~~
# Mass of C in each leaf disc after incubation (mg)
 
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. SD         N
 0.6588  0.7806  0.9189  0.8985  0.9689  1.2340 0.1598875  10

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. SD         N
 0.8886  1.0500  1.1470  1.2030  1.3910  1.5570 0.2301806  10

~~~~
 
#### Leaf Disc C Mass Initial
 
The C mass of the leaf discs prior to the incbation is estimated by the % C of the leaves before the incubation and the masses of the leaf discs before the incubation.

The initial leaf disc masses are calculated by dividing the total sample AFDM mass by the number of leaf discs in the sample and then converting to mg

##### Initial C mass of a single leaf 

    disc_mass_init <- (init_om$om.mass[init_om$sample == "leaf"] / init_om$leaf.num[init_om$sample == "leaf"]) * 1000 # converted to mg 

    disc_C_mass_init <- disc_mass_init * 0.45 # the % C of the leaves prior to incubation rounded up from the mean % C of the intial leaf % C in the leached litter exp. 

    summary(disc_C_mass_init)
    sd(disc_C_mass_init)
    length(disc_C_mass_init)

##############
# Estimated carbon mass of a single leaf disc prior to incubation (mg)
 
Min. 1st Qu.  Median    Mean 3rd Qu.    Max.     SD         N
  1.283   1.499   1.597   1.594   1.656   1.899  0.1884964  9
##############
    
    disc_mass_init <- (init_om$om.mass[init_om$sample == "leaf"] / init_om$leaf.num[init_om$sample == "leaf"]) * 1000 # converted to mg 

    init_propC <- mean(initial_cn$percC) / 100 # calculates the mean initial proportion of C by converting the mean percent C into a proportion

    disc_C_mass_init <- disc_mass_init * init_propC

    summary(disc_C_mass_init)
    sd(disc_C_mass_init)
    length(disc_C_mass_init)
    
####################
# Estimated carbon mass of a single leaf disc prior to incubation (mg)

 Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    SD        N
  1.286   1.503   1.602   1.598   1.661   1.905  0.1890618 9
 
####################
 
#### Change in C Mass During Incubation
 
    delta_C_mass <- mean(disc_C_mass_init) - disc_C_mass_final

    tapply(delta_C_mass, leaf.final$Position, summary)
    tapply(delta_C_mass, leaf.final$Position, sd)
    tapply(delta_C_mass, leaf.final$Position, length)

################
# Change in the mass of C in a leaf disc (mg)
 
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD         N
 0.3643  0.6294  0.6794  0.6998  0.8176  0.9395  0.1598875  10

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD         N
0.04139 0.20780 0.45140 0.39530 0.54850 0.70970  0.2301806  10

################
 
## Statistical Analysis

##### Calculate the difference in delta C mass loss betweeen top and sed

    diff.C.mass.loss <- delta_C_mass[leaf.final$Position == "Top"] - delta_C_mass[leaf.final$Position == "Sed"]
    
    t.test(diff.C.mass.loss, mu = 0)
    
Using a t-test of the difference between the leaves on the top and sed is the best approach since it does not treat the leaves in the different positions to be independent but tests if their difference is not equal to 0, which would indicate that one position is consistently greater or lesser.
    
#============================== 
   
    One Sample t-test

    data:  diff.C.mass.loss
    t = -2.7984, df = 9, p-value = 0.02077
    alternative hypothesis: true mean is not equal to 0
    95 percent confidence interval:
     -0.55054121 -0.05834079
    sample estimates:
    mean of x 
   -0.304441 
    
#============================== 

#### Plot of the difference in C mass loss between the top and sed leaves
    
    par(las = 1)
    plot((diff.C.mass.loss), xlim = c(0, 11), ylim = c(-1.5, 1.5))
    abline(h = 0)
    
### Determination of the change in N mass in the leaves 

This is done the same way as was done with C above.

    disc_N_mass_final_TOP <- leaf.final$AFDM[leaf.final$Position == "Top"] * ((cn$percN[cn.position == "top"]) / 100) # convert to proportion
    disc_N_mass_final_SED <- leaf.final$AFDM[leaf.final$Position == "Sed"] * ((cn$percN[cn.position == "sed"]) / 100)
    disc_N_mass_final <- c(disc_N_mass_final_TOP, disc_N_mass_final_SED) * 1000 # convert to mg

    tapply(disc_N_mass_final, leaf.final$Position, summary) 
    tapply(disc_N_mass_final, leaf.final$Position, sd)
    tapply(disc_N_mass_final, leaf.final$Position, length)

##################
# Estimated N mass of a single leaf disc (mg)
 
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. SD            N
0.02813 0.03315 0.04009 0.03848 0.04168 0.05150 0.006818064   10

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. SD           N
0.02496 0.03467 0.03793 0.04256 0.05270 0.06726 0.013079830  10

###############
 
##### Initial N mass of a single leaf 

    disc_N_mass_init <- disc_mass_init * mean(initial_cn$percN / 100)

    summary(disc_N_mass_init)
    sd(disc_N_mass_init)
    length(disc_N_mass_init)

####################
# Initial N mass of a single leaf disc prior to incubation (mg)
 
 Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD           N
0.02807 0.03280 0.03497 0.03488 0.03625 0.04157 0.004125976  9

####################
 
#### Change in N mass following incuabation 
 
    delta_N_mass <- mean(disc_N_mass_init) - disc_N_mass_final

    tapply(delta_N_mass, leaf.final$Position, summary)
    tapply(delta_N_mass, leaf.final$Position, sd)
    tapply(delta_N_mass, leaf.final$Position, length)

#==========================
# Loss of N mass from a single leaf disc during the incubation (mg)

$Sed
     Min.   1st Qu.    Median      Mean   3rd Qu.      Max. SD           N
-0.016620 -0.006802 -0.005206 -0.003605  0.001731  0.006750 0.006818064  10

$Top
      Min.    1st Qu.     Median       Mean    3rd Qu.       Max. SD           N
-0.0323800 -0.0178200 -0.0030520 -0.0076760  0.0002059  0.0099200 0.013079830  10

#================================
        
##### Calculate the difference in delta N mass loss betweeen top and sed

    diff.N.mass.loss <- delta_N_mass[leaf.final$Position == "Top"] - delta_N_mass[leaf.final$Position == "Sed"]
    
    t.test(diff.N.mass.loss, mu = 0)
    
Using a t-test of the difference between the leaves on the top and sed is the best approach since it does not treat the leaves in the different positions to be independent but tests if their difference is not equal to 0, which would indicate that one position is consistently greater or lesser.
    
#============================== 

     One Sample t-test

     data:  diff.N.mass.loss
     t = -0.72533, df = 9, p-value = 0.4867
     alternative hypothesis: true mean is not equal to 0
     95 percent confidence interval:
     -0.016770136  0.008626936
     sample estimates:
     mean of x 
     -0.0040716
     
#============================== 

## Main Plot of AFDM, C mass, and N mass Loss
     
     par(las = 1)
     plot(diff.AFDM.loss * 1000, diff.C.mass.loss, xlab = "Difference in AFDM Loss Between WATER and SEDIMENT Leaf Discs", ylab = "Difference in C or N Mass Loss Between WATER and SEDIMENT Leaf Discs")
     points(diff.AFDM.loss * 1000, diff.N.mass.loss, pch = 19)
     abline(v = 0)
     abline(h = 0)

     par(las = 1)
     plot(diff.AFDM.loss * 1000, xlim = c(0, 11), xlab = "Bottle", ylab = "Mass Loss Difference", axes = F)
     points(diff.C.mass.loss, pch = 19)
     points(diff.N.mass.loss, pch = 2)
     axis(2)
     axis(1, 1:10, at = 1:10)
     abline(h = 0)
     text(4, 1, "Greater mass lost from No-Sediment Disc")
     text(4, -1, "Greater mass lost from Sediment Disc")
     box()
     dev.copy(jpeg, "./output/plots/mass_loss_diff.jpg")
     dev.off()

[Diff in mass lost from leaves in the sediments or water column](../output/plots/mass_loss_diff.jpg)

## Mass Balance of C and N 
    
This estimates the mass of C and N that passes from a single leaf disc to the the fungi and also size of missing compartments that were not measured (e.g., CO2)

To simplify the legibility of the code, I create new objects that represent the pools and fluxes of the model in each treatment level.

### Pools

NOTE: You have to run the Ergosterol_analysis.md code [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/analysis/Ergosterol_analysis.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/analysis/Ergosterol_analysis.md) prior to createing these objects.

* leaf_initial_C_mass = the average mass of C in a single leaf disc prior to the incubation (mg)

    leaf_initial_C_mass <- mean(disc_C_mass_init)

* leaf_final_C_mass_TOP = the average mass of C in a single leaf disc not in contact with the sediments after the incubation (mg)

    leaf_final_C_mass_TOP <- mean(disc_C_mass_final_TOP) * 1000

* leaf_final_C_mass_SED = the average mass of C in a single leaf disc in contact with the sediments after the incubation (mg)

    leaf_final_C_mass_SED <- mean(disc_C_mass_final_SED) * 1000

* mineralized_C_mass_TOP = the mass of C mineralized from a single leaf disc not in contact with the sediments (mg)
    
    mineralized_C_mass_TOP <- leaf_initial_C_mass - leaf_final_C_mass_TOP

* mineralized_C_mass_SED = the mass of C mineralized from a single leaf disc in contact with the sediments (mg)
    
    mineralized_C_mass_SED <- leaf_initial_C_mass - leaf_final_C_mass_SED
    
* fungi_C_mass_TOP = the average mass of C in the fungi on a single leaf disc not in contact witht the sediments after the incubation (mg)

    fungi_C_mass_TOP <- mean(fungal_C_mass[erg$Position == "Top"])

* fungi_C_mass_SED = the average mass of C in the fungi on a single leaf disc in contact with the sediments after the incubation (mg)

    fungi_C_mass_SED <- mean(fungal_C_mass[erg$Position == "Sed"])
    
* leaf_initial_N_mass = the average mass of N in a single leaf disc prior to the incubation (mg)

    leaf_initial_N_mass <- mean(disc_N_mass_init)

* leaf_final_N_mass_TOP = the average mass of N in a single leaf disc not in contact with the sediments after the incubation (mg)

    leaf_final_N_mass_TOP <- mean(disc_N_mass_final_TOP)

* leaf_final_N_mass_SED = the average mass of N in a single leaf disc in contact with the sediments after the incubation (mg)

    leaf_final_N_mass_SED <- mean(disc_N_mass_final_SED)
    
* mineralized_N_mass_TOP = the average mass of N estimated to have been mineralized from a single leaf disc not in contact with the sediments (mg)
    
    mineralized_N_mass_TOP <- expected_delta_N_mass_TOP

* mineralized_N_mass_SED = the average mass of N estimated to have been mineralized from a single leaf disc in contact with the sediments (mg)
    
    mineralized_N_mass_SED <- expected_delta_N_mass_SED

* fungi_N_mass_TOP = the average mass of N in the fungi on a single leaf disc not in contact witht the sediments after the incubation (mg)

    fungi_N_mass_TOP <- mean(fungal_N_mass[erg$Position == "Top"])

* fungi_N_mass_SED = the average mass of N in the fungi on a single leaf disc in contact with the sediments after the incubation (mg)

    fungi_N_mass_SED <- mean(fungal_N_mass[erg$Position == "Sed"])
    
## Statistical Results based on Position (NO NOT USE)
    
The results below based on position are not appropriate because the treat the leaves on the sed and top as independent samples. I am keeping the code just in case I want to refer to it.
    
### Compare mass loss by position

    par(las = 1, mar = c(4, 5, 4, 5), cex = 1.2)
    plot(AFDM.loss * 1000 ~ Position, data = leaf.final, ylim = c(0, 2), xlim = c(.50, 2.5), axes = F, xlab = " ", ylab = "Mass Loss (mg AFDM)", col = "gray")
    text(1, mean(AFDM.loss[leaf.final$Position == "Sed"] * 1000), "*", cex = 2)
    text(2, mean(AFDM.loss[leaf.final$Position == "Top"] * 1000), "*", cex = 2)
    axis(2)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2))
    box()
    #dev.copy(jpeg, "./output/plots/mass_loss.jpg")
    dev.copy(jpeg, "./output/plots/manuscript_figures/mass_loss_manuscript.jpg")
    dev.off()

[Mass lost from leaves in the sediments or water column](../output/plots/mass_loss.jpg)

Mass lost from leaves in the sediments or water column

##### t-test

     t.test(AFDM.loss ~ Position, data = leaf.final)
     
~~~~

 Welch Two Sample t-test

data:  AFDM.loss by Position
t = 1.0867, df = 17.22, p-value = 0.2921
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.0002223588  0.0006956921
sample estimates:
mean in group Sed mean in group Top 
     0.0011011111      0.0008644444 

~~~~

Two-way ANOVA including the effect of the bottles

    anova(lm(AFDM.loss ~ Position * Bottle, data = leaf.final))

~~~~

  Analysis of Variance Table

Response: AFDM.loss
Df     Sum Sq    Mean Sq F value Pr(>F)
Position         1 2.8010e-07 2.8006e-07  1.0915 0.3117
Bottle           1 4.3200e-08 4.3205e-08  0.1684 0.6870
Position:Bottle  1 1.2000e-07 1.2002e-07  0.4678 0.5038
Residuals       16 4.1052e-06 2.5658e-07 

~~~~
  

##### Test of Change in C mass of a leaf Disc during incbation by position

    t.test(delta_C_mass ~ leaf.final$Position)
 
~~~~
Welch Two Sample t-test

data:  delta_C_mass by leaf.final$Position
t = 3.4351, df = 16.045, p-value = 0.003387
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 0.1166032 0.4922788
sample estimates:
mean in group Sed mean in group Top 
        0.6997685         0.3953275 
~~~~

 
    par(las = 1)
    plot(delta_C_mass ~ leaf.final$Position, ylim = c(0, 1), ylab = "C Mass Loss (mg)", xlab = "Position", col = "grey")
    text(1, mean(delta_C_mass[leaf.final$Position == "Sed"]), "*", cex = 2)
    text(2, mean(delta_C_mass[leaf.final$Position == "Top"]), "*", cex = 2)
    dev.copy(jpeg, "./output/plots/delta_c_mass.jpg")
    dev.off()


![Delta C mass ](../output/plots/delta_c_mass.jpg)

Figure: Change in final leaf C mass

    par(las = 1)
    plot((leaf.final$AFDM[leaf.final$Position == "Sed"] * 1000), (disc_C_mass_final_SED * 1000) , ylim = c(0, 2), xlim = c(0, 4), ylab = "C Mass (mg)", xlab = "AFDM (mg)", pch = 1)
    points((leaf.final$AFDM[leaf.final$Position == "Top"] * 1000), (disc_C_mass_final_TOP * 1000), pch = 19)
    legend(0, 2, c("Sediment Contact", "No Sediment Contact"), pch = c(1, 19))
    dev.copy(jpeg, "./output/plots/C_mass_by_AFDM.jpg")
    dev.off()


![C Mass plotted against AFDM](../output/plots/C_mass_by_AFDM.jpg)

Figure: C mass plotted against AFDM for the leaf discs


##### Test of N Mass Loss
 
     t.test(delta_N_mass ~ leaf.final$Position)

~~~~
 
Welch Two Sample t-test

data:  delta_N_mass by leaf.final$Position
t = 0.8729, df = 13.555, p-value = 0.3979
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -0.005963507  0.014106707
sample estimates:
mean in group Sed mean in group Top 
     -0.003604656      -0.007676256 

~~~~
 
##### Plot of N Mass Loss 
 
    par(las = 1)
    plot(delta_N_mass ~ leaf.final$Position, ylim = c(-0.04, 0.01), ylab = "N Mass Loss (mg)", xlab = "Position", col = "grey")
    text(1, mean(delta_N_mass[leaf.final$Position == "Sed"]), "*", cex = 2)
    text(2, mean(delta_N_mass[leaf.final$Position == "Top"]), "*", cex = 2)
    dev.copy(jpeg, "./output/plots/delta_n_mass.jpg")
    dev.off()


![Delta N mass ](../output/plots/delta_n_mass.jpg)


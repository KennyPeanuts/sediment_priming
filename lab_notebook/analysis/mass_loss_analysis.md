# Analysis of the mass loss of the leaves in the sediment priming experiment.

## Metadata

* file created 29 June 2016 - KF

* Modified: 

### Description

These analyses are to evaluate the change in mass of the leaves in the sediment priming experiment. Details on the experimental set-up and execution can be found: [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md) & [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md)

## Analysis

### Import data

    leaf.initial <- read.table("./data/inital_om.csv", header = T, sep = ",")
    leaf.final <- read.table("./data/final_AFDM.csv", header = T, sep = ",")

### Determine Average inital leaf mass

The initial leaf mass samples consisted of 10 leaves

    init.leaf.mass <- leaf.initial$om.mass[leaf.initial$sample == "leaf"]
    sing.init.leaf.mass <- init.leaf.mass / leaf.initial$leaf.num[leaf.initial$sample == "leaf"]
    mean.init.mass <- mean(sing.init.leaf.mass)

~~~~
# mean mass of a single leaf prior to the beginning the exp
  
> mean.init.mass
[1] 0.003541111

~~~~
  
### Determine Average Final AFDM
  
    final.DM <- leaf.final$CrucLeafDM - leaf.final$CrucMass
    final.AM <- leaf.final$CrucAM - leaf.final$CrucMass
    final.AFDM <- final.DM - final.AM

Since there were different numbers of leaves in the crucibles `final.AFDM` is the mass of the total leaves in the crucible

    final.leaf.AFDM <- final.AFDM / leaf.final$LeafNum

###  Determine Mass Lost

    AFDM.loss <- mean.init.mass - final.leaf.AFDM

    tapply(AFDM.loss * 1000, leaf.final$Position, summary) 
    tapply(AFDM.loss * 1000, leaf.final$Position, sd)
 
~~~~
AFDM Loss from each postion (mg)

$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
0.06111 1.02600 1.05100 1.10100 1.38600 1.60100  0.4320494

$Top
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.  SD
0.001111 0.416100 0.961100 0.864400 1.226000 1.621000  0.5362904
~~~~
 
### Compare mass loss by position

    par(las = 1)
    plot(AFDM.loss * 1000 ~ Position, data = leaf.final, ylim = c(0, 2), xlim = c(.50, 2.5), axes = F, xlab = " ", ylab = "Mass Loss (mg AFDM)", col = "gray")
    text(1, mean(AFDM.loss[leaf.final$Position == "Sed"] * 1000), "*", cex = 2)
    text(2, mean(AFDM.loss[leaf.final$Position == "Top"] * 1000), "*", cex = 2)
    axis(2)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2))
    box()
    dev.copy(jpeg, "./output/plots/mass_loss.jpg")
    dev.off()

![Mass lost from leaves in the sediments or water column](../output/plots/mass_loss.jpg)

Mass lost from leaves in the sediments or water column

#### Statistical Analysis
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

##### One-way ANOVA of Position

     anova(lm(AFDM.loss ~ Position, data = leaf.final))

~~~~

> anova(lm(AFDM.loss ~ Position, data = leaf.final))
Analysis of Variance Table

Response: AFDM.loss
Df     Sum Sq    Mean Sq F value Pr(>F)
Position   1 2.8010e-07 2.8006e-07   1.181 0.2915
Residuals 18 4.2685e-06 2.3714e-07       

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
  
##### Determine the difference between the loss in the water and sed leaves
  
    loss.diff <- AFDM.loss[leaf.final$Position == "Sed"] - AFDM.loss[leaf.final$Position == "Top"]

    par(las = 1)
    plot(loss.diff * 1000 ~ leaf.final$Bottle[leaf.final$Position == "Top"], xlab = "Bottle", ylab = "Sediment Mass Loss - Water Col. Mass Loss (mg AFDM)")
    abline(h = 0)
    dev.copy(jpeg, "./output/plots/mass_loss_diff.jpg")
    dev.off()

![Sediment Mass Loss - Water Column Mass Loss](../output/plots/mass_loss_diff.jpg)

Sediment Mass Loss - Water Column Mass Loss

##### Determine the 95% CI of the difference in mass loss

    t.test(loss.diff)

~~~~
One Sample t-test

data:  loss.diff
t = 0.8572, df = 9, p-value = 0.4136
alternative hypothesis: true mean is not equal to 0
95 percent confidence interval:
 -0.0003879115  0.0008612448
sample estimates:
   mean of x 
0.0002366667 
~~~~
     
# Analysis of the Ergosterol Content of the leaves in the sediment priming experiment.

## Metadata

* 4 October 2017

* Modified:
 * Added summary stats for ergosterol mass per leaf
 * 1 Nov 2017 - KF - calculated the degree that fungal C mass was from converted leaf C
 * 25 Jan 2018 - KF - tested differences in the percent fungal carbon in the leaves
 * 30 Jan 2018 - KF - recalculated the carbon mass, and percent of fungal C to leaf C based on AFDM rather than leaf dry mass - this better matches with the mass loss analysis
 * 20 June 2018 - KF - calculated the N mass of the fungi and the amount of final leaf N that would be in fungal biomass
 
### Description

These analyses are to evaluate the Ergosterol Content of the leaves in the sediment priming experiment. Details on the experimental set-up and execution can be found: [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md) & [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md)

## Analysis

### Import data

    erg <- read.table("./data/leaf_ergosterol.csv", header = T, sep = ",")
    init_om <- read.table("data/inital_om.csv", header = T, sep = ",")
    cn <- read.table("data/leaf_disc_CN.csv", header = T, sep = ",")

## Data Summaries

## Ergosterol mass per leaf (ug Ergosterol / leaf disc)

     tapply(erg$Erg_per_leaf, erg$Position, summary)
     tapply(erg$Erg_per_leaf, erg$Position, sd)

~~~~
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
0.09457 0.18100 0.23190 0.28440 0.37240 0.55790  0.1534152 

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
 0.3473  0.6070  0.7751  0.8014  0.8757  1.5250  0.3267842 

~~~~
 
### Mass Normalized Ergosterol (ug Ergosterol / g AFDM)

     tapply(erg$Erg_mass_norm, erg$Position, summary)
     tapply(erg$Erg_mass_norm, erg$Position, sd)

~~~~
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
  46.36   70.19   98.74  119.80  171.70  260.70   71.92231

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
  167.0   271.1   278.8   292.7   312.5   476.5   78.89246 
~~~~

### Area Normalized Ergosterol (ug Ergosterol / cm^2)

     tapply(erg$Erg_area_norm, erg$Position, summary)
     tapply(erg$Erg_area_norm, erg$Position, sd)

~~~~
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
  3.304   6.321   8.100   9.934  13.010  19.490   5.358965 

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
  12.13   21.20   27.08   27.99   30.59   53.26   11.414939 
~~~~
 
 
## Analysis of the Effect of Position on Mass Normalized Ergosterol

    par(las = 1, cex = 1.2, mar = c(4, 5, 4, 5))
    plot(Erg_mass_norm ~ Position, data = erg, ylim = c(0, 550), ylab = "Ergosterol (ug/g AFDM)", xlab = "", col = 8, axes = F)
    axis(2)
    axis(1, c("Sediment Contact", "No Sediment Contact"), at = c(1, 2))
    text(1, mean(erg$Erg_mass_norm[erg$Position == "Sed"]), "*", cex = 2)
    text(2, mean(erg$Erg_mass_norm[erg$Position == "Top"]), "*", cex = 2)
    box()
    dev.copy(jpeg, "./output/plots/erg_mass_norm_by_position.jpg")
    dev.off()

![Mass Normalized Ergosterol by leaf Position](../output/plots/erg_mass_norm_by_position.jpg)

### T-test

    t.test(Erg_mass_norm ~ Position, data = erg)

~~~~
 Welch Two Sample t-test

data:  Erg_mass_norm by Position
t = -5.1216, df = 17.848, p-value = 7.328e-05
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -243.8690 -101.9316
sample estimates:
mean in group Sed mean in group Top 
         119.7838          292.6841 
~~~~

 
## Analysis of the Effect of Position on Area Normalized Ergosterol

    par(las = 1, lwd = 1)
    plot(Erg_area_norm ~ Position, data = erg, ylim = c(0, 60), ylab = "Ergosterol (ug/cm^2)", xlab = " ", col = "gray", axes = F)
    axis(2, cex.lab = 1.5)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2), cex.lab = 1.5)
    box()
    dev.copy(jpeg, "./output/plots/Erg_area_norm_by_position.jpg")
    dev.off()

![Percent N by leaf Position](../output/plots/Erg_area_norm_by_position.jpg)

### T test

    t.test(Erg_area_norm ~ Position, data = erg)


~~~~
  Welch Two Sample t-test

data:  Erg_area_norm by Position
t = -4.529, df = 12.783, p-value = 0.0005905
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -26.690215  -9.430595
sample estimates:
mean in group Sed mean in group Top 
         9.934036         27.994441 

~~~~

## Calculation of the mass of C in fungal biomass
### Background information
 
There is 1 mg fungal dry mass / 5 ug of ergosterol mass (Su et al. 2015 - citing Gessner and Newell 2002)

Fungi had 43% C and 6.5% N (Findlay et al 2002)

We measured the % C of the leached leaf litter used in the exp as 45 % - this comes from measurements taken from the leached litter CPOM flux experiment.

### Calculation
#### Fungal Mass
Using these estimates we can estimate the fungal dry mass (mg) on the leaves as:
 
    fungal_mass <- (1 / 5) * erg$Erg_per_leaf # 1 mg fungal mass / 5 ug ergosterl mass

#### Fungal C and N Mass
The carbon mass (mg) of the fungi on the leaves would be:
 
    fungal_C_mass <- fungal_mass * 0.43
    
The nitrogen mass (mg) of the fungi on the leaves would be:

    fungal_N_mass <- fungal_mass * 0.065

     tapply(fungal_mass, erg$Position, summary)
     tapply(fungal_mass, erg$Position, sd)

~~~~
# Fungal Mass per Leaf (mg)
 
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
0.01891 0.03619 0.04638 0.05688 0.07448 0.11160  0.03068304

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
0.06946 0.12140 0.15500 0.16030 0.17510 0.30490  0.06535683

~~~~
  
    tapply(fungal_C_mass, erg$Position, summary)
    tapply(fungal_C_mass, erg$Position, sd)

~~~~
# Fungal C Mass per Leaf (mg)
$Sed
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.       SD
    0.008133 0.015562 0.019943 0.024457 0.032027 0.047981   0.01319371
    
$Top
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.            SD
    0.02987 0.05221 0.06666 0.06892 0.07531 0.13113         0.02810344 
    
~~~~
    

     tapply(fungal_N_mass, erg$Position, summary)
     tapply(fungal_N_mass, erg$Position, sd)

~~~~
# Fungal N Mass per Leaf (mg)
       $Sed
     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.      SD
     0.001229 0.002352 0.003015 0.003697 0.004841 0.007253  0.001994397
     
     $Top
     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.      SD
     0.004515 0.007892 0.010076 0.010418 0.011384 0.019821  0.004248194

~~~~

# Percentage of Final Leaf C Mass in the Fungi

To calculate the percent of the final C mass of the leaf that is in fungi, I need the final C mass of the leaves from the mass analysis.

To complete the remaining calculations, you need to run the code in the mass_loss_analysis.R [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/analysis/mass_loss_analysis.md#determine-the-c-mass-of-the-leaves](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/analysis/mass_loss_analysis.md#determine-the-c-mass-of-the-leaves) so that you get the 'disc_C_mass_final' and the 'disc_N_mass_final' object.
                                                                                              
## Percent of Final C mass of the leaf that is in fungi

The percent of the final leaf C mass that is in fungi:
 
    perc_fungal_C <- (fungal_C_mass / disc_C_mass_final) * 100 

    tapply(perc_fungal_C, erg$Position, summary)
    tapply(perc_fungal_C, erg$Position, sd)
    
~~~~
# Percent of the final C mass of each leaf disc that is in fungal C

$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. SD
  1.026   1.609   2.171   2.890   4.331   6.178 1.886135 

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. SD
  3.189   5.141   5.237   5.602   5.987   9.258 1.566612 


~~~~

## Test of % Fungal Carbon by Position
  
    t.test(perc_fungal_C ~ erg$Position)

~~~~

 Welch Two Sample t-test

data:  perc_fungal_C by erg$Position
t = -3.4985, df = 17.414, p-value = 0.002672
alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:
 -4.345464 -1.079654
sample estimates:
mean in group Sed mean in group Top 
         2.889725          5.602283 

~~~~
 
    par(las = 1)
    plot(perc_fungal_C ~ erg$Position, ylim = c(0, 10), ylab = "Percent of Final Leaf C Mass in Fungal C", xlab = "", col = 8, axes = F)
    axis(2)
    axis(1, c("Sediment Contact", "No Sediment Contact"), at = c(1, 2))
    text(1, mean(perc_fungal_C[erg$Position == "Sed"]), "*", cex = 2)
    text(2, mean(perc_fungal_C[erg$Position == "Top"]), "*", cex = 2)
    box()
    dev.copy(jpeg, "./output/plots/percent_fungal_c_mass.jpg")
    dev.off()

![Percent of final leaf C mass in fungal C mass](../output/plots/percent_fungal_c_mass.jpg)

Figure: Percent of the the final leaf C mass in fungal C mass

## Percent of the final leaf N mass that is in Fungi

The percent of the final leaf N mass that is in fungi:
 
    perc_fungal_N <- (fungal_N_mass / disc_N_mass_final) * 100 

    tapply(perc_fungal_N, erg$Position, summary)
    tapply(perc_fungal_N, erg$Position, sd)
    
~~~~
# Percent of the final C mass of each leaf disc that is in fungal C

    $Sed
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
    3.913   5.539   7.316  10.117  15.382  20.666  6.502462 
    
    $Top
    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
    13.08   21.53   23.85   24.45   27.68   35.40  6.024858 
    

~~~~

## Test of % Fungal Carbon by Position
  
    t.test(perc_fungal_N ~ erg$Position)

~~~~

      Welch Two Sample t-test
    
    data:  perc_fungal_N by erg$Position
    t = -5.1132, df = 17.896, p-value = 7.399e-05
    alternative hypothesis: true difference in means is not equal to 0
    95 percent confidence interval:
      -20.225377  -8.441749
    sample estimates:
      mean in group Sed mean in group Top 
    10.11698          24.45054 

~~~~
 
    par(las = 1)
    plot(perc_fungal_N ~ erg$Position, ylim = c(0, 50), ylab = "Percent of Final Leaf N Mass in Fungal C", xlab = "", col = 8, axes = F)
    axis(2)
    axis(1, c("Sediment Contact", "No Sediment Contact"), at = c(1, 2))
    text(1, mean(perc_fungal_N[erg$Position == "Sed"]), "*", cex = 2)
    text(2, mean(perc_fungal_N[erg$Position == "Top"]), "*", cex = 2)
    box()
    dev.copy(jpeg, "./output/plots/percent_fungal_N_mass.jpg")
    dev.off()

![Percent of final leaf C mass in fungal N mass](../output/plots/percent_fungal_N_mass.jpg)

Figure: Percent of the the final leaf C mass in fungal C mass

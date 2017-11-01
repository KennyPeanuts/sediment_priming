# Analysis of the Ergosterol Content of the leaves in the sediment priming experiment.

## Metadata

* 4 October 2017

* Modified:
 * Added summary stats for ergosterol mass per leaf
 * 1 Nov 2017 - KF - calculated the degree that fungal C mass was from converted leaf C

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

    par(las = 1)
    plot(Erg_mass_norm ~ Position, data = erg, ylim = c(0, 550), ylab = "Ergosterol (ug/g AFDM)", xlab = "Leaf Position", col = "lightsalmon", axes = F)
    axis(2)
    axis(1, c("Sediment Contact", "No Sediment Contact"), at = c(1, 2))
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

Fungi had 43% C (Findlay et al 2002)

We measured the % C of the leached leaf litter used in the exp as 45 % - this comes from measurements taken from the leached litter CPOM flux experiment.

### Calculation
#### Fungal Mass
Using these estimates we can estimate the fungal dry mass (mg) on the leaves as:
 
    fungal_mass <- (1 / 5) * erg$Erg_per_leaf # 1 mg fungal mass / 5 ug ergosterl mass

#### Fungal C Mass
The carbon mass (mg) of the fungi on the leaves would be:
 
    fungal_C_mass <- fungal_mass * 0.43

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
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.  SD 
0.008133 0.015560 0.019940 0.024460 0.032030 0.047980  0.01319371

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.   SD
0.02987 0.05221 0.06666 0.06892 0.07531 0.13110   0.02810344 

~~~~

#### Leaf Disc C Mass Final
 
To estimate the C mass of a single leaf we need to divide the leaf mass by the number of leaves in the mass estimate sample. 

    disc_mass_final <- (erg$LeafMass / erg$LeafNum) * 1000 #converted to mg

    tapply(disc_mass_final, erg$Position, summary)
    tapply(disc_mass_final, erg$Position, sd)
    
~~~~
# Estimated dry mass of a single leaf disc after incubation (mg)
 
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
  2.920   3.010   3.250   3.355   3.625   4.080  0.4055518 

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
  2.200   2.610   2.835   3.031   3.518   4.020  0.6148315 

~~~~
 
The C mass of the leaf discs at the end of the experiment is estimated by the % C of the leaves after to incubation and the mass of the leaves after incubation

To complete this calculation, I need a treatment level variable for the cn data.frame

     cn.position <- c(rep("top", 10), rep("sed", 10))

I now calculate mass of C for each treatment level:

    disc_C_mass_final_TOP <- disc_mass_final[erg$Position == "Top"] * (cn$percC[cn.position == "top"]) / 100 # convert to proportion
    disc_C_mass_final_SED <- disc_mass_final[erg$Position == "Sed"] * (cn$percC[cn.position == "sed"]) / 100
    disc_C_mass_final <- c(disc_C_mass_final_TOP, disc_C_mass_final_SED)

    tapply(disc_C_mass_final, erg$Position, summary) 
    tapply(disc_C_mass_final, erg$Position, sd)

~~~~
# Mass of C in each leaf disc after incubation (mg)
 
$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
 0.9126  1.1680  1.2380  1.2380  1.2970  1.5400  0.1785781 

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
  1.018   1.173   1.282   1.362   1.596   1.768  0.2639970 

~~~~

#### Leaf Disc C Mass Initial
 
The C mass of the leaf discs prior to the incbation is estimated by the % C of the leaves before the incubation and the masses of the leaf discs before the incubation.

The initial leaf disc masses are calculated by dividing the total sample dry mass by the number of leaf discs in the sample and then converting to mg

    disc_mass_init <- (init_om$dry.mass[init_om$sample == "leaf"] / init_om$leaf.num[init_om$sample == "leaf"]) * 1000 # converted to mg 

    disc_C_mass_init <- disc_mass_init * 0.45 # the % C of the leaves prior to incubation = 45%

    summary(disc_C_mass_init)
    sd(disc_C_mass_init)

~~~~
# Estimated carbon mass of a single leaf disc prior to incubation (mg)
 
 Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    SD
  1.309   1.440   1.471   1.496   1.530   1.688  0.1115964

~~~~

#### Change in C Mass During Incubation
 
    delta_C_mass <- mean(disc_C_mass_init) - disc_C_mass_final

    tapply(delta_C_mass, erg$Position, summary)
    tapply(delta_C_mass, erg$Position, sd)

~~~~
# Change in leaf disc C mass during incubation (mg)
 
$Sed
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max.   SD
-0.04411  0.19880  0.25770  0.25730  0.32750  0.58290   0.1785781 

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
-0.2725 -0.1010  0.2136  0.1331  0.3224  0.4773  0.2639970 

~~~~
 
    par(las = 1)
    plot(delta_C_mass ~ erg$Position)


#### Percentage of Final Leaf C Mass in the Fungi

The percent of the final leaf C mass that is in fungi:
 
    perc_fungal_C <- (fungal_C_mass / disc_C_mass_final) * 100 

    tapply(perc_fungal_C, erg$Position, summary)
    tapply(perc_fungal_C, erg$Position, sd)
    
~~~~
# Percent of the final C mass of each leaf disc that is in fungal C

$Sed
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
 0.7023  1.2470  1.6030  2.1040  2.4920  4.5980  1.415832

$Top
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.  SD
  2.719   4.534   4.650   4.948   5.295   7.796  1.339615 

~~~~
 
    par(las = 1)
    plot(perc_fungal_C ~ erg$Position, ylim = c(0, 10), ylab = "Percent of Final Leaf C Mass in Fungal C", xlab = "Position")
    dev.copy(jpeg, "./output/plots/percent_fungal_c_mass.jpg")
    dev.off()

![Percent of final leaf C mass in fungal C mass](../output/plots/percent_fungal_c_mass.jpg)

Figure: Percent of the the final leaf C mass in fungal C mass
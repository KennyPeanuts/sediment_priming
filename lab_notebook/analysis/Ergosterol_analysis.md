# Analysis of the Ergosterol Content of the leaves in the sediment priming experiment.

## Metadata

* 4 October 2017

* Modified:
 * Added summary stats for ergosterol mass per leaf

### Description

These analyses are to evaluate the Ergosterol Content of the leaves in the sediment priming experiment. Details on the experimental set-up and execution can be found: [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_set_up.md) & [https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md](https://github.com/KennyPeanuts/sediment_priming/blob/master/lab_notebook/lab_notes/Notes_on_breakdown.md)

## Analysis

### Import data

    erg <- read.table("./data/leaf_ergosterol.csv", header = T, sep = ",")


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


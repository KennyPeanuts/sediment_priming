# Code to create a single figure with 4 panes for mass loss, toughness, perc C and perc N.

## Metadata

* file created 2 Sept 2019 - KF 

### Description

Before running this code, you need to make all the objects in:
  * CN_analysis.md
  * mass_loss_analysis.md
  * toughness_analysis,md

## Code

    par(las = 1, mfcol = c(2, 2), cex = 0.5, res = 300)
    # toughness
    par(mar = c(2, 15, 4, 5))
    boxplot(mean.tough.sed, mean.tough.top, ylim = c(0, 60), ylab = "Toughness (Grams Required to Puncture the Leaf)", xlab = " ", col = 8 )
    text(1, mean(mean.tough.sed), "*", cex = 2)
    text(2, mean(mean.tough.top), "*", cex = 2)
    # mass loss
    par(mar = c(4, 15, 2, 5))
    plot(AFDM.loss * 1000 ~ Position, data = leaf.final, ylim = c(0, 2), xlim = c(.50, 2.5), axes = F, xlab = " ", ylab = "Mass Loss (mg AFDM)", col = "gray")
    text(1, mean(AFDM.loss[leaf.final$Position == "Sed"] * 1000), "*", cex = 2)
    text(2, mean(AFDM.loss[leaf.final$Position == "Top"] * 1000), "*", cex = 2)
    axis(2)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2))
    box()
    # perc C
    par(mar = c(2, 5, 4, 15))
    plot(percC ~ pos, data = leaf, ylim = c(0, 50), ylab = "Percent Leaf C", xlab = " ", col = "gray", axes = F)
    text(1, mean(leaf$percC[leaf$pos == "sed"]), "*", cex = 2)
    text(2, mean(leaf$percC[leaf$pos == "top"]), "*", cex = 2)
    box()
    axis(1, c("", ""), at = c(1, 2), cex.lab = 2.5)
    axis(2, cex.lab = 2.5)
    # perc N
    par(mar = c(4, 5, 2, 15))
    plot(percN ~ pos, data = leaf, ylim = c(0, 2), ylab = "Percent Leaf N", xlab = " ", col = "gray", axes = F)
    text(1, mean(leaf$percN[leaf$pos == "sed"]), "*", cex = 2)
    text(2, mean(leaf$percN[leaf$pos == "top"]), "*", cex = 2)
    axis(2, cex.lab = 2.5)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2), cex.lab = 2.5)
    box()
    #dev.copy(jpeg, "./output/plots/manuscript_figures/combined.jpg")
    dev.off()
    
## Code for high-res figure
    
    tiff("./output/plots/manuscript_figures/combined_highres.tiff", width = 4.5, height = 4.5, res = 700, units = "in")
    par(las = 1, mfcol = c(2, 2), cex = 0.5)
    # toughness
    par(mar = c(2, 4, 4, 2))
    boxplot(mean.tough.sed, mean.tough.top, ylim = c(0, 60), ylab = "Toughness (Grams Required to Puncture the Leaf)", xlab = " ", col = 8 )
    text(1, mean(mean.tough.sed), "*", cex = 2)
    text(2, mean(mean.tough.top), "*", cex = 2)
    # mass loss
    par(mar = c(4, 4, 2, 2))
    plot(AFDM.loss * 1000 ~ Position, data = leaf.final, ylim = c(0, 2), xlim = c(.50, 2.5), axes = F, xlab = " ", ylab = "Mass Loss (mg AFDM)", col = "gray")
    text(1, mean(AFDM.loss[leaf.final$Position == "Sed"] * 1000), "*", cex = 2)
    text(2, mean(AFDM.loss[leaf.final$Position == "Top"] * 1000), "*", cex = 2)
    axis(2)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2))
    box()
    # perc C
    par(mar = c(2, 4, 4, 2))
    plot(percC ~ pos, data = leaf, ylim = c(0, 50), ylab = "Percent Leaf C", xlab = " ", col = "gray", axes = F)
    text(1, mean(leaf$percC[leaf$pos == "sed"]), "*", cex = 2)
    text(2, mean(leaf$percC[leaf$pos == "top"]), "*", cex = 2)
    box()
    axis(1, c("", ""), at = c(1, 2), cex.lab = 2.5)
    axis(2, cex.lab = 2.5)
    # perc N
    par(mar = c(4, 4, 2, 2))
    plot(percN ~ pos, data = leaf, ylim = c(0, 2), ylab = "Percent Leaf N", xlab = " ", col = "gray", axes = F)
    text(1, mean(leaf$percN[leaf$pos == "sed"]), "*", cex = 2)
    text(2, mean(leaf$percN[leaf$pos == "top"]), "*", cex = 2)
    axis(2, cex.lab = 2.5)
    axis(1, c("Sediment Contact", "No Sed. Contact"), at = c(1, 2), cex.lab = 2.5)
    box()
    dev.off()
    
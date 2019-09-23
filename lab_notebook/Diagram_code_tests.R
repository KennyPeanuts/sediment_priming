# Diagram for sediment priming manuscript

## Reference
This code is based on:
  https://www.stat.auckland.ac.nz/~paul/R/Diagram/diagram.pdf

## Load Grid Package
library("grid", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

## Create Diagram
grid.roundrect(width = 0.5, height = 0.5)
grid.text("Wow")

grid.roundrect()
grid.circle()
arrow(angle = 30)

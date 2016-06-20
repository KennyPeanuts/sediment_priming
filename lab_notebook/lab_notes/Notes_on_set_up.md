# Notes on the set-up of the sediment priming experiment

## File Info

* File created on 8 June 2016 from lab notes in notebook by KF

### Modified

* 20 June 2016 - KF - added sediment LOI data collected on 3 feb 2016

## Lab Notes

### 29 January 2016 Sediment and Water Collection

The pond was frozen so 2 holes were cut in the ice approximately 20 m from shore and 2 Ekman samples were taken from each of the holes

The sediments collected by the Ekman were then passed through a 250 um mesh net and mixed into 5 gal buckets

10 L of surface water was collected from near the middle of the pond through a hole in the ice

#### YSI Data

The YSI data was collected from the hole in the center of the pond where the water was collected.

| Parameter    | 0 m   | 0.5 m | 1 m   | 
| ---------    | ---   | ----- | ---   |
| Temp (dC)    | 4.69  | 4.73  | 4.95  |
| Cond (uS/cm) | 12.99 | 12.91 | 12.79 |
| %DO          | 66.7  | 70.4  | 76.1  |
| DO (mg/L)    | 8.17  | 8.66  | 9.32  |

#### Sediment LOI

Three 10 ml subsamples of sediment slurry were collected from the sediment buckets and added to pre-weighed crucubles, dried, and ashed at 550 dC to determine LOI

~~~~

#R-code to determine LOI

cruc.num <- c(18, 6, 16)
cruc.mass <- c(29.4371, 31.5170, 28.8739)
cruc.sed <- c(30.2519, 32.3527, 29.7071)
cruc.ash <- c(30.1161, 32.2115, 29.5674)

sed.mass <- cruc.sed - cruc.mass
ash.mass <- cruc.ash - cruc.mass

AFDM <- sed.mass - ash.mass

perc.OM <- (AFDM / sed.mass) * 100

data.frame(sed.mass, AFDM, perc.OM)

 sed.mass   AFDM  perc.OM
1   0.8148 0.1358 16.66667
2   0.8357 0.1412 16.89602
3   0.8332 0.1397 16.76668
> 

~~~~

##### Variable Descriptions

* cruc.num = the ID of the crucibles

* cruc.mass = the mass of the empty crucubles (g)

* cruc.sed = the mass of the crucible + the dry sediment (g)

* cruc.ash = the mass of the crucible + the ash that remained after ashing at 550 dC for >4 hours (g)

* sed.mass = the mass of the dry sediment (g)

* ash.mass = the mass of the ash that remained after ashing at 550 dC for >4 hours (g)

* AFDM = the ash free dry mass of the sediment (g)

* perc.OM = the percent organic matter of the sediment 

### 29 January 2016 Bottle Set Up

The collected sediments were homogenized with a ladel and then 100 ml of slurry was added to each of 10, 250 ml Tall Clear WM Septa-Jar - Fisher Item Number S121-0250

The remaining volume (up to the neck) was filled with the collected surface water

The sediment was then allowed to settle in the dark at room temperature and the water was changed using a siphon and a thin "j" shaped tube suspended over the sediment to prevent resuspending the sediments.

Water was changed on:

* 2 Feb 2016

* 5 Feb 2016 - new LPP  water was collected with the dip sampler on 4 Feb 2016

### 5 February 2016 Leaf Leaching

35 dried senecent tulip poplar leaves (collected Fall 2013) were added to about 10 L of DI water to begin the leaching and softening process

### 10 February 2016 Cutting Leaf Discs

335 leaf discs were cut with a no. 7 coark borer (13.5 mm diameter) and placed in a beaker of DI water in the fridge to insure that they would sink

### 12 February 2016 Adding Leaf Discs to Bottles

To begin the experiment, 10 leaf discs were added to the bottles and allowed to sink to the sediments

Then the wire shelf was added to the sediments so that the legs penetrated about 1 mm into the sediments and the surface was 4 cm above the sediments

10 leaf discs were then added to the top of the shelf 

The bottles were then filled to the neck with LPP water collected on 10 Feb 2016

#### Notes on the leaf addition

* Bottle red-4: the shelf hit some of the sediment leaves and the pushed them a bit into the sediments

* Bottle red-3: a leaf disc was pushed into the sediments by the shelf

* Bottle yellow-3: a leaf disc was pushed into the sediments by the shelf

* Bottle red-10: a disc fell off the shelf, so there are 9 on the shelf and 1 along the side of a shelf leg

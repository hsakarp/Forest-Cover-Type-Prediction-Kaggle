# Forest-Cover-Type-Prediction-Kaggle

In this competition you are asked to predict the forest cover type (the predominant kind of tree cover) from strictly cartographic variables (as opposed to remotely sensed data). The actual forest cover type for a given 30 x 30 meter cell was determined from US Forest Service (USFS) Region 2 Resource Information System data. Independent variables were then derived from data obtained from the US Geological Survey and USFS. The data is in raw form (not scaled) and contains binary columns of data for qualitative independent variables such as wilderness areas and soil type.
This study area includes four wilderness areas located in the Roosevelt National Forest of northern Colorado. These areas represent forests with minimal human-caused disturbances, so that existing forest cover types are more a result of ecological processes rather than forest management practices.

# The Data
The data comprises observations of 30m x 30m patches in four wilderness ares in the Roosevelt National Forest of northern Colorado. Twelve independent variables were derived using data from the US Geological Survey and US Forest Services (Blackard 98):

* Elevation - Elevation in meters
* Aspect - Aspect in degrees azimuth
* Slope - Slope in degrees
* Horizontal_Distance_To_Hydrology - Horz Dist to nearest surface water features
* Vertical_Distance_To_Hydrology - Vert Dist to nearest surface water features
* Horizontal_Distance_To_Roadways - Horz Dist to nearest roadway
* Hillshade_9am (0 to 255 index) - Hillshade index at 9am, summer solstice
* Hillshade_Noon (0 to 255 index) - Hillshade index at noon, summer solstice
* Hillshade_3pm (0 to 255 index) - Hillshade index at 3pm, summer solstice
* Horizontal_Distance_To_Fire_Points - Horz Dist to nearest wildfire ignition points
* Wilderness_Area (4 binary columns, 0 = absence or 1 = presence) - Wilderness area designation
* Soil_Type (40 binary columns, 0 = absence or 1 = presence) - Soil Type designation (see Kaggle for a qualitative description of each soil type)

 From these varaiables, we want to predict the cover type:

* Cover_Type (integers 1 to 7)


    1 - Spruce/Fir
    2 - Lodgepole Pine
    3 - Ponderosa Pine
    4 - Cottonwood/Willow
    5 - Aspen
    6 - Douglas-fir
    7 - Krummholz
Kaggle provides a labeled training data set of 15,120 observations, and an unlabeled test data set of 565,892 observations to be used for the submission.

* training set of 15,120 observations: 

  https://www.kaggle.com/c/forest-cover-type-prediction/download/train.csv.zip
* test set of 565,892 observations:

  https://www.kaggle.com/c/forest-cover-type-prediction/download/test.csv.zip
* sample submission:

  https://www.kaggle.com/c/forest-cover-type-prediction/download/sampleSubmission.csv.zip

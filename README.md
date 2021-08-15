# PCA Face Analysis

Applying PCA to face images, and visulaizing variation of mean image in direction of PCA vectors

## Code Requirements
- MatLab/Octave
- If you face any problem, kindly raise an issue.

## Data set used
- Chosen 500 random images from UTK Face Cropped: https://www.kaggle.com/abhikjha/utk-face-cropped
- Synchronized well cropped face images, small size and colred, Good variance in age, gender, ethinicity etc.

## Setup

1) Need Matlab/Octave

## Execution

- Run pca_training.m
-- Loading Image ...
-- Subtracting mean Image from all images ...
-- Finding PCA ...
-- saving PCA ...
--Saving PCA vectors as Image ...
- Run pca_visualization.m (Choose vector number, vecNo inside the code: Line number 4)
-- Loading PCA Vectors...
-- Loading PCA eigen values...
-- Loading PCA eigen values...

## Results

- It will save Pricipal components images in pca_images folder.
- Visualization of variation of mean image in direction of PCA vectors will be saved in same folder.

## Future Scope
- Adding User Interface using Python/MatLab

## References

- 

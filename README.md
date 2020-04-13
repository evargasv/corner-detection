# Harris Corner Detector

Implementation of a corner detector in MATLAB, using Harris algorithm. 

The derivatives of the intensity image, *I*, are computed in the *x* and *y* directions for every pixel. The squared derivates are then smoothed using a Gaussian filter. These derivated are used to compute the matrix *M*, used to deriva a measure of the "cornerness" for every pixel.

## Matrix E






<p align="center">
  <img src="/img/E_matrix.png" width="300px">
</p>

## Matrix R

<p align="center">
  <img src="/img/R_matrix.png" width="300px">
</p>


## Salient points

<p align="center">
  <img src="/img/E_corners.png" width="300px">
  <img src="/img/R_corners.png" width="300px">
</p>


## Non-maximal supression

<p align="center">
  <img src="/img/E_nms.png" width="300px">
  <img src="/img/R_nms.png" width="300px">
</p>

## References

- 

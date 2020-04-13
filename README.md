# Harris Corner Detector

Implementation of a corner detector in MATLAB, using Harris algorithm. The derivatives of the image, *I*, are computed in the *x* and *y* directions for every pixel. The squared derivates are calculated and smoothed using a Gaussian filter. These set of derivatives are employed to compute the matrix *M*, used to derive a measure of the "cornerness" for every pixel.

## Matrix E

Matrix *E* contains for every point the value of the smaller eigenvalue of *M*.

<p align="center">
  <img src="/img/E_matrix.png" width="300px">
</p>

## Matrix R

Matrix *R* uses the determinant and the trace of *M* to detect corners.

<p align="center">
  <img src="/img/R_matrix.png" width="300px">
</p>


## Salient points

Most salient points from *E* and *R*, selected by sorting the values of the matrices in descending order and choosing the *n* largest values. 

<p align="center">
  <img src="/img/E_corners.png" width="300px">
  <img src="/img/R_corners.png" width="300px">
</p>


## Non-maximal supression

Finds the maximum values of a window and suppress the other values that are not the maximum.

<p align="center">
  <img src="/img/E_nms.png" width="300px">
  <img src="/img/R_nms.png" width="300px">
</p>

## References

- Harris, C.G. and Stephens, M. *A combined corner and edge detector*. In Alvey vision conference, 1988. (Vol. 15, No. 50, pp. 10-5244).

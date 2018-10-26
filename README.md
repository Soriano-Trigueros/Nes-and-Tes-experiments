# Nes-and-Tes-experiments
Computational experiments using entropy summary functions that appears
in the paper "On the stability of persistent entropy and new summary 
functions for TDA".

It requires:
  - Matlab with Javaplex installed 
        (http://appliedtopology.github.io/javaplex/)
  - R with the TDA package
        (https://cran.r-project.org/web/packages/TDA/index.html)


Functions used in NES example: 
  - Mosaicos6 is the main code of the experiment. It generates a 
    pattern, use it to create tesselations with different sizes 
    and then duplicate them adding noise.
    Auxiliar functions:
    - random_quad: generates a random non-degenerated quadilateral.
    - quad_tilling: draw the tesselation and generate its point cloud.
    - barcodes3: generate the barcodes.
    - ent_summary3: calculate its NES function.
    - Dist_L1: compute the L1 distance of a function.

Functions used in TES example:
  - average_S1 is the main code of the experiment. It generates a list
    feature.candidates[[i]][[j]] where i is the circle sample and j the
    importance of the feature.
    Auxiliar functions:
    - Points_S1: generate a random sample of points in a circle.
    - TES: Calculate the NES function and indicates the topological 
      features. 

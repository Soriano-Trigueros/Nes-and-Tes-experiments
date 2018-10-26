
points_S1 <- function(n,nname)
  # Obtain random points from a cyrcle. n number of points of each cloud, 
  # nname is the surname used for saving the files
{
  
  # Obtain the random points
  a <- runif(n,0,1)*2*pi
  x = cos(a)
  y = sin(a)
  X <- matrix(0,n,2)
  X[,1] = x
  X[,2] = y
  
  # Compute the distance matrix.
  DisMat <- as.matrix(dist(X))
  DisMat<<- DisMat  
  
  point_cloud = X
  #setwd("/Users/manu/ripser/Datos/")
  
  #save the points and the distance matrix as a txt.
  write.table(DisMat, file = paste( 'dist_', nname,'.txt', sep = ""),
              sep = "\t", col.names = F, row.names = F) 
  write.table(X, file = paste( 'point_cloud_', nname,'.txt', sep = ""),
              sep = "\t", col.names = F, row.names = F)
  
  #save the points as an image.
  nname <- paste("inm_",nname,'.jpg', sep = "")
  jpeg(nname)
  plot(X[,1],X[,2], xaxp  = c(-1, 1, 2), yaxp  = c(-1, 1, 2),
       main=nname, pch="o")
  dev.off()
}
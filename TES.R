 TES <- function( M, partitions, maxscale, nc, name)
  
  # Calculate the NES function and indicates the topological features. 
  # input: M is the set of intervals, f the average silhouette 
  # and nc the number of candidates. maxscale is the time limit of 
  # calculation of the complex.
  # output: ranking is a list with the topological features ordered
  # by importance.
  
{
   # First, compute calculate a matrix (dif) with the intervals 
   # and the unmodified silhouette f.
   t = 1:partitions *maxscale/partitions
   f = matrix(0,partitions,1)
   
   m = dim(M)[1]
   dif = matrix(0,m,1)
   
   for (j in 1:m){
     dif[j,1] = M[j,3] - M[j,2]
   }
   
   L = colSums(dif)
   
   for (i in 1:partitions){
     a = 0
     l = matrix(L,m,1)
     for (j in 1:m){
       if ((M[j,2] <= t[i]) && (M[j,3] >= t[i])){
         l[j,1] = dif[j,1]
         a = a + 1
       }
     }
     if (a != 0){
       f[i] = (-colSums(l/L*(log(l/L))))/a
     }
   }
  
  # Calculate the modified silhouette f2 and obtain the candidates 
  # to be topological features. The first row is the average
  # point of the bar and the second its  modified silhouette value.
  n <- 1
  tt <- 1
  inicio <- 1
  f2 <- matrix(0, 1, length(f))
  candidates <- matrix(0,0,0)
  for (t in 1:(length(f)-1)){
    if (f[t] == f[t+1]){
      n = n+1
      tt = tt + 0.5
      f2[t] = f[t]
    }
    else{
      f2[inicio:(inicio + n)] <- f[inicio:(inicio + n)]* + 
        ((t - inicio)*maxscale/partitions)
      candidates <- c(candidates,tt,f2[t])
      tt = t+1
      n = 1
      inicio = t+1
    }
  }
  write.table( f2, file = paste( 'function_', name,'.txt', sep = ""),
               sep = "\t", col.names = F, row.names = F)
  name <- paste( "Sil_", name, '.jpg', sep = "")
  jpeg( name)
  plot( 1:partitions, f2, xlab="Time", ylab="Entropy", 
        xaxp  = c(0, maxscale, 10), main=nname, pch=".")
  dev.off()
  
  candidates <- matrix(candidates, 2, length(candidates)/2)

  # Take a concrete time for each of the first nc candidates
  # and compute its betti numbers.
  tfea <- (candidates[1,order(-candidates[2,])[1:nc]])/
          (partitions/maxscale)
                        
  fea <- list()
 
  for (t in 1:nc){
      a = matrix(0,0,0)
      for (j in 1:dim(M)[1]){
        if ((M[j,3] >= tfea[t]) && (M[j,2] <= tfea[t])){
          a = c( M[j,1], M[j,2], M[j,3], a)
        }
      }
      if (length(a) > 3){
        a = matrix( a, nrow = length(a)/3, ncol = 3, byrow = TRUE)
        fea[[length(fea)+1]] <- a 
      }
  }
  
  ranking <<- fea
}
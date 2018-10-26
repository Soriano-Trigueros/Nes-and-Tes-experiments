# Calculate the average of the entropy functions of point clouds in
# S1 and obtain the candidates to be topological freatures.

#Load auxiliar functions and packets.
require("TDA")
source('points_S1.R')
source('TES.R')

# Parameters: maxscale.- this is the rips complex filtration limit.
#             maxdimension.- last dimension where persistent
#             homology is computed.
#             n.- number of points in the cloud.
#             npc.- number of point clouds.
#             nc .- number of candidates to be.
#             partition .- number of subdivisions of the domain.
#             nname .- all files saved with this code will have
#             nname as a surname.
partitions <- 250
maxscale <- 2
maxdimension <- 3
n <- 40
npc <- 2
nc <- 10
nname <- "circle"
features.candidates <- list()

for (i in 1:npc){
  # Generate each point cloud, its persistent diagram, its 
  # barcode and save them.
  
  name <- paste( "Circ", n, as.character(i), sep = "")
  P <- points_S1( n, name)
  DiagRips <- ripsDiag( X = DisMat, maxdimension, 
                        maxscale, library = "Dionysus", 
                        location = TRUE, 
                        printProgress = TRUE,
                        dist = "arbitrary")
  M <- as.matrix(DiagRips[["diagram"]])
  write.table(M, file = paste("Bar_Val_", name, '.txt', sep = ""), 
              sep = "\t", col.names = F, row.names = F)
  
  jpeg(paste("bar_",name,'.jpg', sep = ""))
  plot(M, barcode = TRUE, main = "Barcode")
  dev.off()

  # Compute its modified entropy silhouette and generate the 
  # topological features.
  TES( M, partitions, maxscale, nc, name)
  # Save the topological features by importance.
  features.candidates[[i]] <- ranking
}

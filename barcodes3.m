function  [intervals_dim0] = barcodes3(point_cloud, name,...
    end_time, partition)

% Generate the barcodes and save them in a .png file.
% input: point_cloud are the coordinates of the vertexes, 
% name is the name of the .png, end_time indicates the 
% maximum value of the filtration and partition the size
% of the discretization.
% output: the intervals of dimension 0

% Require Javaplex.
import edu.stanford.math.plex4.*;

% Compute the barcodes of the point cloud.
stream = api.Plex4.createVietorisRipsStream(point_cloud, 1, end_time,...
    partition);
persistence =  api.Plex4.getModularSimplicialAlgorithm(1, 2);
intervals = persistence.computeIntervals(stream);

intervals_dim0 = edu.stanford.math.plex4.homology.barcodes.BarcodeUtility...
.getEndpoints(intervals, 0, 1);

% create the barcode plots
opt.filename = strcat('Barcode ',name,'.png');
opt.max_filtration_value=double(end_time);
opt.max_dimension = 0;
plot_barcodes(intervals,opt);
close all

end

function  [image] = ent_summary3( intervals, end_time, partition)
% Compute the summary function of a given barcode and create a plot.
% Input: intervals is a persistence barcode/diagram, end_time the 
% maximum value of the filtration and partition the size of the 
% discretization.
% Output: image are the values of the function.

% Calculate the image of the function.
total_sum = sum( intervals(:,2) - intervals(:,1));
image = zeros(partition,1);
for t = 1:partition
    time = t*end_time/partition;
    v = ones(1,size(intervals,1)) ;
    for i = 1:size(intervals,1)
        if and(intervals(i,1) <= time, intervals(i,2) > time) 
            v(i) = (intervals(i,2) - intervals(i,1))/total_sum;
        end
    end
    image(t) = -sum(v.*log(v));
end

%Compute the L1 norm to normalize
aux = distL1(image, zeros(1,partition),partition,end_time/partition);

%normalize and plot.
image = image/aux;
scatter((1:partition)/partition*end_time,image,10,[1 0 0],'filled');

end


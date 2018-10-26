function mosaicos6(sur)
import edu.stanford.math.plex4.*;
% The function mosaicos generates 6 tesselations from a random 
% quadrilateral figure. They have all the same pattern differing in the 
% size of the tesselation. 3 of them have random noise added.
% input: sur is the surname of the generated files.
% output: sur

% First, we generate four random points wich will determine the 
% quadilateral figure.
[x,y] = random_quad();

% n determine the row and column size of the tesselations, end_time and 
% partition are the maximum value of the filtration and its number of 
% subdivisions.
n = [3,5];
end_time = 3;
partition = 200;
a = 0;
for i = 1:2;
    for j = 1:i;
        a = a+1;
        name = strcat(sur,num2str(a));
        % Generate the tesselations. n(i), n(j) are the row and column 
        % number of quadilaterals in the tesselation.
        point_cloud = quad_tiling(n(i),n(j),x,y,name);
        m = size(point_cloud);

        % Choose random entries in the matrix. Create the noisy point cloud
        % from moving and deleting points. Save it.
        l = unique(m(1)*rand(fix(m(1)/3),1));
        l = fix(l/1)+1;
        noise_matrix = zeros(m);
        for k = 1:fix(length(l)/2)
            noise_matrix(l(k),1) = (-1)^(round(rand))*rand/3;
            noise_matrix(l(k),2) = (-1)^(round(rand))*rand/3;
        end
        for k = (fix(length(l)/2)+1):length(l)
            noise_matrix(l(k),:) = -point_cloud(l(k),:);
        end
        noisy_point_cloud = point_cloud + noise_matrix;
        
        % Save the original point cloud and the noisy one.
        title(strcat('Point Cloud ', name))
        scatter(point_cloud(:,1), point_cloud(:,2),20,'filled')
        saveas(gcf,strcat('pc_',name,'.png'))
        close all
        
        title(strcat('Noisy PC ', name))
        scatter( noisy_point_cloud(:,1), noisy_point_cloud(:,2), 20,...
            'filled');
        saveas(gcf,strcat('pc_noisy_',name,'.png'))
        close all
        
        % Generate the barcodes for both of them.
        [intervals0] = barcodes3(point_cloud, name, end_time,...
            partition);
        [noisy_intervals0] = barcodes3(noisy_point_cloud,...
            strcat('Noisy ',name), end_time, partition);
        
        % Save the summary functions.
        image = ent_summary3( intervals0, end_time, partition);
        save(strcat('val_',name,'_0'), 'image');
        saveas(gcf,strcat('fun_',name,'.png'))
        close all
        
        image = ent_summary3(noisy_intervals0, end_time, partition);
        save(strcat('val_','noisy_',name,'_0'), 'image');
        saveas(gcf,strcat('fun_','_noisy',name,'.png'))
        close all
        
        save(strcat('data_',name))
    end
end

end


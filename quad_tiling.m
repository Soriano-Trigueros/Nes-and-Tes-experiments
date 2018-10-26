function points = quad_tiling(n,m,x,y,name)
% Based on 
% https://blogs.mathworks.com/graphics/2015/09/04/tiling-quadrilaterals/
% It genereates a tesselation of quadrilaterals and save a .png file.
% Input: (n,m) determines the size; x,y vectors the quadrilateral and 
% name is a string determining the name of the image.
% Output: The coordinates of the vertexes.
% 

pts = [x; y; ones(1,4)];
% Matrix which rotates by 180 degrees
rotmat = [-1  0 0; ...
           0 -1 0; ...
           0  0 1];
% Translation vectors
uvec = pts(:,1) - pts(:,3);
vvec = pts(:,2) - pts(:,4);

%colors
cols = zeros(7,3);
cols(:,3) = 0.75;
cols(:,2) = 1;

% generate c (center) and construc a partner.
c = [(pts(1:2,1) + pts(1:2,2))/2; 1];
offset = rotmat*c - c;
xlatmat = [1 0 offset(1); ...
           0 1 offset(2); ...
           0 0         1];
p2 = rotmat*xlatmat*pts;
xdata(2,:) = p2(1,:);
ydata(2,:) = p2(2,:);


%Repeat the process, draw the tiling and save the points.
cla
points = zeros(4*(2*m+1)*(2*n+1), 2);
for i=-n:n
    for j=-m:m
        x = xdata' + i*uvec(1) + j*vvec(1);
        y = ydata' + i*uvec(2) + j*vvec(2);
        points((4*(2*m+1)*(i+n)+4*(j+m)+1):(4*(2*m+1)*(i+n)+4*(j+m+1)),1) = x(:,2);
        points((4*(2*m+1)*(i+n)+4*(j+m)+1):(4*(2*m+1)*(i+n)+4*(j+m+1)),2) = y(:,2);
        ci = mod(3*j+2*i,5);
        h = patch('XData',x,'YData',y);
        h.FaceVertexCData = cols(ci+(1:2),:);
        h.FaceColor = 'flat';
    end
end
saveas(gcf,strcat('til_',name,'.png'))
close all
end


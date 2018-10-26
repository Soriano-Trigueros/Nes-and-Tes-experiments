function d = distL1(x,y,n,l)
% Compute de L1 distance for piecwise linear functions x and y defined by 
% n intervals of length l.
d = 0;
for i = 1:n
    d = (abs(x(i)-y(i)))/l + d;
end
end
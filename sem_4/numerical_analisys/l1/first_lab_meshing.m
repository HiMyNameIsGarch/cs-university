[gx,gy] = meshgrid(-2:0.01:2 , -4:0.01:4);
g = exp(-((gx-1/2).^2 + (gy-1/2).^2));
mesh(gx,gy,g)
title("mathlab logo")
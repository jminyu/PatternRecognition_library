% Making an sofm grid
colordef none;			% So that it looks ok on a B/W screen
clear;                          % Get rid of any old variables which mess it up

% Represent it as a grid of complex numbers

num_rows = 15;
num_cols = 15;
a = 0.20;			% Exponent in eta and G reduction (HKP p.237)

%%%%% Initialise with small real and complex coords, centred on the origin
dx = 0.1;
m = dx*(1-2*rand(num_rows,num_cols)) + dx*(1i-2i*rand(num_rows,num_cols));

%%%%% Plot the shape which will be mapped (a letter in this case);

%%%%%%% Plot an A 
%%%%%%% NB: It's better to have this in a separate function file,
%%%%%%%     but it's harder to mail that way. 
%%%%%%%     Same for making the A input below 
figure(1);
clf;

line([-0.8 -0.4],[-1 1]);
line([-0.8 -0.5],[-1 -1]);
line([-0.5 -0.38],[-1 -0.4]);
line([-0.02  0.1],[-0.4 -1]);
line([-0.02  -0.38],[-0.4 -0.4]);
line([0 0.4],[1 -1]);
line([0 -0.4],[1 1]);
line([-0.1 -0.2],[0 0.5]);
line([-0.3 -0.2],[0 0.5]);
line([-0.3 -0.1],[0 0]);
line([0.1 0.4],[-1 -1]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% The main loop

for cycle=1:5000,

	eta = cycle^(-a);		% Learning rate (how much nodes move)
	G = 0.5 + 10*cycle^(-a);		% Gaussian width parameter
	%%% NB: G<0.5 is boring because the Gaussian only covers one node

	%%%%% Give an input (I have code for R,A,J and C)
	x = 1-2*rand;
	y = 1-2*rand;

	while ~( (x>-0.4 & x<0 & y>-0.4 & y<0) | ... % Middle bar
	 	((y>-5*x - 0.5) & (y<-5*x + 1) ) | ...% Right diagonal
	 	((y>5*x + 1.5) & (y<5*x + 3) ) ) ...% Left diagonal
	 	x = 1-2*rand;
		y = 1-2*rand;
	end;

	inp = x + y*i;		% This is the input point

	%%%%% Find winning node

	dist_mat = (real(m)-real(inp)).^2 + (imag(m)-imag(inp)).^2;
	[win_rows,win_cols] = find(dist_mat==min(dist_mat(:)));
	rand_idx = ceil(length(win_rows)*rand);	
	win_row = win_rows(rand_idx);
	win_col = win_cols(rand_idx);
	%%% This turns dist_mat into a vector, finds its min element,
	%%% then gives each place in an m-size matrix a 1 if it is this min,
	%%% otherwise 0, then gives the row and col indices of the 1s
	%%% Then we pick a random one of these winners
	
	%%% Calculate city-block distance from winner in grid
	[col_idx,row_idx] = meshgrid(1:num_cols,1:num_rows);
		%%%% Make matrices of indices
	grid_dist = abs(row_idx-win_row) + abs(col_idx-win_col);
	
	%%% Calculate Gaussian movement-strength function for each node
	f = eta * exp(-(grid_dist/G).^2);

	%%%% Plot the map
	if max(cycle == [1 10 30 50 100 200 400 600 800 1000 3000 5000]),
	
		%%%%%%%%%% Do the plotting
		figure(1);
		if (cycle>1),delete(h);end;	% This wipes the old grid plot
		hold on;
		h=plot(real(m),imag(m),'w-',real(m'),-imag(m'),'w-');
				% This draws the new SOFM grid
		hold off;
		title(['Input presentation number ' num2str(cycle) ...
       			'     Neighbourhood size ' num2str(G) ...
       			'     Learning rate ' num2str(eta) ]); 
		drawnow;
		%eval(['print ' num2str(cycle) 'R.ps']);  
			% This would make a PostScript file
	end;

	%%% Move nodes
	m = m + f.*(inp-m);

end;    	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Go to next cycle 

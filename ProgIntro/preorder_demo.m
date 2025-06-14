function preorder_demo()
  % nodes appears in order in the matrix from 1 to 7 
  % every row contains left and right for a node
   % 0 means no child
   % tree root in the first row (node 1)
   tree = [
		2 3
		4 0
		5 6
		0 0
		0 0
		0 7
		0 0
	  ];

	% visit in preorder
	preorder(tree)

end
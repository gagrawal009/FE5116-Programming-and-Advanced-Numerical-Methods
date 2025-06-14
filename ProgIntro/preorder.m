function r = preorder(tree)
	 assert(size(tree,1) >=1, 'tree must contain at least one node');
     assert(size(tree,2) ==2, 'tree must have two columns');
     r = inner_preorder(tree, 1, []);
end

function visited = inner_preorder(tree, node, visited)
    if (node ~= 0)
	    visited = [visited, node];

	    leftnode = tree(node,1);
	    rightnode = tree(node,2);
	
		visited = inner_preorder(tree, leftnode, visited);
		visited = inner_preorder(tree, rightnode, visited);
    end
end



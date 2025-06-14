% 'from', 'to' and 'via' are the pole indices and must be in the set {1,2,3}
function hanoi_demo(n, from, to, via)
	% compute moves
	moves = hanoi(n, from, to, via);

	% format and display results
	[nMoves, ~] = size(moves);
    %nMoves = size(moves, 1);

	fprintf('%10s%10s%10s%10s\n', 'Move No.', 'Disc No.', 'From', 'To');
    for i=1:nMoves
		fprintf('%10d%10d%10d%10d\n', i, moves(i,1), moves(i,2), moves(i,3));
    end
end
    

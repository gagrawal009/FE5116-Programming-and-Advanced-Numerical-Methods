
% Move n discs from pole 'from' to pole 'to' using as support pole 'via'
% Return the sequence of moves
function moves = hanoi(n, from, to, via)
	% we use as data representation a (n+1)x3 matrix
	% discs are numbered from 1 to n
	% discs are stored in poles
	% columns correspond to poles
	% the last row contains the number of discs in each pole
	% example:
	% with n = 3, we initialize the data matrix to:
	% data = [ 3, 0, 0
	%          2, 0, 0
	%          1, 0, 0
	%          3, 0, 0   % last row: number of discs in each pole
	%        ]
	% first pole contains the discs 3,2,1, i.e. a total of 3 discs
	% all other columns contain 0 discs
    
    % In the main function we do some error checks, which do not need to 
    % repeat during the recursion
    % Note the use of the function sprintf to construct the error message
    assert(n>=0, sprintf('n must be positive, but you entered: %d\n', n) );
    assert(n == uint64(n), sprintf('n must be integer, but you entered: %d\n', n) );
    assert(min([1,2,3] == sort([from, to, via])), "from, to and via must be the numbers 1, 2 and 3 in any order");
    
	data = zeros(n+1, 3);
	data(1:n, from) = [n:-1:1];
	data(n+1, from) = n;

	% start recursion
	moves = move(n, from, to, via, data, []);
end

% recursive function which performs and logs all necessary moves
function [moves, data] = move(n, from, to, via, data, moves)
   [m,nc] = size(data);
   if(n == 1)
	   nDiscsInColFrom = data(m, from);
	   nDiscsInColTo = data(m, to);
	   discToMove = data(nDiscsInColFrom, from);
	   data(nDiscsInColFrom, from) = 0;
	   data(m, from) = data(m, from) - 1;
	   nDiscsInColTo = nDiscsInColTo +1;
	   data(m, to) = nDiscsInColTo;
	   data(nDiscsInColTo, to) = discToMove;
	   moves = [ moves;
				discToMove, from, to];
   else
	   [moves, data] = move(n - 1, from, via, to, data, moves);
	   [moves, data] = move(1, from, to, via, data, moves);
	   [moves, data] = move(n - 1, via, to, from, data, moves);
   end
end

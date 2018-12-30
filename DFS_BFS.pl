

% direct_route(1,7).
% direct_route(1,8).
% direct_route(1,3).
% direct_route(7,4).
% direct_route(7,20).
% direct_route(7,17).
% direct_route(8,6).
% direct_route(3,9).
% direct_route(3,12).
% direct_route(4,42).
% direct_route(17,10).
% direct_route(20,28).
% direct_route(9,19).

% connected(X,Y) :- direct_route(X,Y) ; direct_route(Y,X).

% breadth_first( Start, Goal, Path):- 
%     bfs( Goal, [[Start]], Path).


% bfs(Goal, [[Goal|Visited]|_], Path):- 
%     reverse([Goal|Visited], Path).

% consed(A,B,[B|A]).
% bfs(Goal, [Visited|Rest], Path) :-                     % take one from front
%     Visited = [Start|_],            
%     Start \== Goal,
%     findall(X,
%         (connected(X,Start),not(member(X,Visited))),
%         [T|Extend]),
%     maplist( consed(Visited), [T|Extend], VisitedExtended),      % make many
%     append(Rest, VisitedExtended, UpdatedQueue),       % put them at the end
%     bfs( Goal, UpdatedQueue, Path ).

edge(1,[2,3]).
       edge(2,[4,7]).
       edge(3,[5,6]).
       edge(4,[8,9]).
       edge(7,[]).
       edge(8,[]).
       edge(9,[]).
       edge(5,[]).
       edge(6,[]).

       breadthfirst([], List, List).
       breadthfirst([H|L1], List, [H|L3]) :- 
           breadthfirst(L1, List, L3).

       sol(X, [F|T]) :-
           edge(F, Y),
           breadthfirst(T, Y, Z),
           write(F), nl,
           sol(X, Z).
%    goal 
%        sol(9, [1]).


    
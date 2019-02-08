include "alldifferent.mzn";
include "crossword3.dzn";

set of int: solutions; %le soluzioni previste
int: rows; %numero di righe
int: columns; %numero di colonne
 
int: r;  
int: s;

constraint assert(r>0, "r>0");
constraint assert(s>=r , "s>=r");

int: maxlengthseg; %massima lunghezza dei segmenti
int: size = card(solutions); %cardinalità solutions
array [1..size] of var solutions: sol; %registra il prodotto di ogni segmento
array [1..(rows*columns)] of var r..s union {0,r} : board;
array [1..size, 1..maxlengthseg] of var int: segments; 

constraint alldifferent(sol);

%calcola la produttoria relativa ad ogni segmento della board e la pone uguale ad una delle soluzioni
constraint forall(i in 1..size)(product(j in 1..maxlengthseg)(if segments[i, j] != 0 then board[segments[i,j]] else 1 endif)==sol[i]); 
                 
solve satisfy;

output [show(board[i]) ++ if i mod columns == 0 then "\n" else " " endif | i in 1..rows*columns] ++ ["\n"] ++ [show(sol)]
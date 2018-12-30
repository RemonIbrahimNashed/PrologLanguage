
male(ahmed).    /* ahmed is  male */
male(aymen).    
male(ali).      
male(sami).     
male(said).     

female(aml).    /* aml is  female  */   
female(nada).       
female(sara).       
female(noha).     
female(mona).   

parent(ahmed,ali).  /* ahmed is a parent of ali  */
parent(aml,ali).      
parent(aymen,sara). 
parent(nada,sara).    
parent(ali,noha).  
parent(sara,noha).  
parent(noha,mona). 
parent(noha,sami).    
parent(mona,said).    
parent(sami,said).  


different(X,Y)   :- X \= Y .
father(F,X)      :- male(F)   , parent(F,X) .
mother(M,X)      :- female(M) , parent(M,X) .
brother(B,X)     :- male(B)   , parent(P,B) , parent(P,X) , different(B,X).
sister(S,X)      :- female(S) , parent(P,S) , parent(P,X)  , different(S,X).
aunt(A,X)        :- female(A) , parent(F,X) , male(F)     , sister(A,F) .
uncle(U,X)       :- male(U)   , parent(M,X) , female(M)   , brother(U,M) .
grandpa(G,X)     :- male(G)   , parent(G,P) , parent(P,X) .
grandma(G,X)     :- female(G) , parent(G,P) , parent(P,X) .

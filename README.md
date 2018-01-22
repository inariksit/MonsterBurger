# MonsterBurger

## Basic sentences 

`Pred Restaurant (Serve Burger)`  
the restaurant serves the burger

`Pred Customer (Order Burger)`  
the customer orders the burger

## Modals 
`Pred Customer (May (Order Burger))`  
the customer may order the burger

You can certainly overgenerate, and a lot of the trees don't make semantic sense, but it's grammatical :-D

`Pred Customer (May Finish)`  
the customer may finish

`Pred Customer (May (May Finish))`  
the customer may be allowed to finish

## Sentence complements

`Pred Restaurant (Confirm (Pred Customer Finish))`  
the restaurant confirms that the customer finishes

(TODO: tenses -- would like to have "customer is finished" too?)

## Time expressions


### Two variants in the linearisation: 

`Transition (Within 999) (Pred Customer Finish)`  
* the customer finishes within 999 minutes
* within 999 minutes , the customer finishes

`Transition (Upon Sim (Pred Customer (Order Burger))) (Pred Restaurant Finish)`  
* upon the customer ordering the burger , the restaurant finishes
* the restaurant finishes upon the customer ordering the burger

`Transition (Upon Ant (Pred Customer (Order Burger))) (Pred Restaurant Finish)`  
* upon the customer having ordered the burger , the restaurant finishes
* the restaurant finishes upon the customer having ordered the burger

Maybe `EndOfChallenge` can also be an `Event`? (NB: this linearisation is just an ugly quick hack, probably the lincat of `Event` should be changed to accommodate different types of events).

`Transition (Upon Sim EndOfChallenge) (Pred Customer (Order Burger))`  
upon ing the end of challenge , the customer orders the burger

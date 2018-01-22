abstract MonsterBurgerv3 = {

flags startcat = Statement ;

  cat
    Statement ;
    Event ;
    Party ;
	Object ;
    Action ;
    Guarantee ;
	TimeExpression ;
	Temporal ;

  fun

-- Parties, objects, guarantees
	Restaurant : Party ;
	Customer : Party ;

	Burger : Object ;

	PromptCheck : Guarantee ;
	PromptServe : Guarantee ;

 -- Actions

    -- intransitive
    Finish : Action ;

    -- transitive, with different types of complements
	Serve   : Object -> Action ;
	Order   : Object -> Action ;
	Pay     : Object -> Action ;
	Violate : Guarantee -> Action ;

    -- sentential complement
    Confirm    : Event -> Action ; -- linearisation variants: check, confirm 
	Disconfirm : Event -> Action ;

    -- modals -- TODO should there be a different abstract category? 
	May    : Action -> Action ;
	Should : Action -> Action ;


-- Time expressions, control flow

    -- these are just parameters to Upon, to allow "upon the customer ordering"
    -- and "upon the restaurant having checked"
    Sim : Temporal ;
    Ant : Temporal ;

    Upon : Temporal -> Event -> TimeExpression ;
    Within : Int -> TimeExpression ;


    Transition : TimeExpression -> Event -> Statement ;

    --If : Event -> ??? ;




-- Events

	Pred : Party -> Action -> Event ;
	EndOfChallenge : Event ;



}
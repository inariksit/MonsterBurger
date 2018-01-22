concrete MonsterBurgerv3Eng of MonsterBurgerv3 =
 open Prelude, SyntaxEng, ExtraEng, (E=ExtendEng), IrregEng, SentenceEng, ParadigmsEng in {


  lincat
--    Statement = S ;
    Event = Ev ; -- Control flow functions take Events as arguments, so we need to keep tense open:
                 -- e.g. "when ordering", "upon having checked"
    Party = NP ;
    Object = NP ;
    Action = VP ;
    Guarantee = NP ;
    TimeExpression = Adv ;
    Temporal = Tempor ;

  linref Event = linEvent ;

  lin 

-- Parties, objects, guarantees

    Customer = np "customer" ;
    Restaurant = np "restaurant" ;
    Burger = np "burger" ;

    --PromptCheck : Guarantee ;
    --PromptServe : Guarantee ;


 -- Actions

    -- intransitive
    Finish = mkVP (mkV "finish") ;

    -- transitive
    Order obj = vp "order" obj ;
    Serve obj = vp "serve" obj ;

    -- modal
    May action = mkVP may_VV action ;

    Confirm ev = 
        let evCl = mkCl ev.subj ev.pred ;
        in mkVP (mkVS (mkV "confirm")) (mkS evCl) ;

-- Time expressions
    Sim = TSim ;
    Ant = TAnt ;

    Upon temp event = 
      let 
          -- This is a hack -- what we really need to do is to
          -- generalise GerundAdv in Extend to take temporal parameters!
          having_finished : Adv = case temp of {
            TAnt => ParadigmsEng.mkAdv 
                      (mkS (mkTemp pastTense simultaneousAnt) positivePol 
                           (mkCl (E.GerundNP (mkVP have_V)) event.pred)).s ; ----hack
            TSim => E.GerundAdv event.pred } ;
          customer_having_finished : NP = mkNP event.subj having_finished ;
      in SyntaxEng.mkAdv (mkPrep "upon") customer_having_finished ;

    Within n = ParadigmsEng.mkAdv ("within" ++ n.s ++ "minutes") ; 

    Transition tim ev =
      let event = mkS (mkCl ev.subj ev.pred)
       in variants { cc2 event tim         -- the restaurant serves the burger within 5 minutes
                   ; ExtAdvS tim event } ; -- within 5 minutes, the restaurant serves the burger 


-- Events, Statements
    Pred p a = { subj = p; pred = a } ;


------

oper
  np : Str -> NP = \s -> mkNP the_Det (mkN s) ;
  vp : Str -> NP -> VP = \s,obj -> mkVP (mkV2 s) obj ;

  Ev : Type = { subj : NP ; pred : VP } ;

  linEvent : Ev -> Str = \ev -> (mkS (mkCl ev.subj ev.pred)).s ;

  param Tempor = TSim | TAnt ;
}

{-
`Pred Customer Finish`
"the customer finishes"


`Pred Customer (May Finish)`
"the customer may finish"

`Pred Customer (May (May Finish))`
"the customer may be allowed to finish" -}
concrete MonsterBurgerv3Eng of MonsterBurgerv3 =
 open Prelude, SyntaxEng, ExtraEng, (E=ExtendEng), IrregEng, SentenceEng, ParadigmsEng in {


  lincat
    Statement = SS ;
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

    -- "Confirm that the restaurant serves the burger" or
    -- "Confirm the end of the challenge"
    Confirm ev =
      case ev.evtype of {
        Atom => mkVP (mkV2 "confirm") ev.atom ;

        Sentence =>
          let evCl = mkCl ev.subj ev.pred ;
          in mkVP (mkVS (mkV "confirm")) (mkS evCl)
      };

-- Time expressions
    Sim = TSim ;
    Ant = TAnt ;

    -- "Upon the customer having finished" or
    -- "Upon the end of the challenge"
    Upon temp event =
      let having_finished : Adv = case temp of {
            TAnt => E.GerundAdv
                      (E.ComplGenVV have_VV
                                    simultaneousAnt
                                    positivePol
                                    event.pred) ; -- TODO: incorrect form
            TSim => E.GerundAdv event.pred } ;
          event_NP : NP = case event.evtype of {
            Atom => event.atom ;
            Sentence => mkNP event.subj having_finished } ;
      in SyntaxEng.mkAdv (mkPrep "upon") event_NP ;


    Within n = ParadigmsEng.mkAdv ("within" ++ n.s ++ "minutes") ;

    Transition tim ev =
      let event = mkS (mkCl ev.subj ev.pred)
       in variants { ExtAdvS tim event  -- within 5 minutes, the restaurant serves the burger
                   ; cc2 event tim } ;-- the restaurant serves the burger within 5 minutes


-- Events, Statements
    Pred party action = {
      atom = mkNP (mkN nonExist) ;
      subj = party ;
      pred = action ;
      evtype = Sentence
      } ;

    EndOfChallenge =
      npEvent "end of challenge"
              "challenge"
              "end" ;

------

oper

  np : Str -> NP = \s -> mkNP the_Det (mkN s) ;
  vp : Str -> NP -> VP = \s,obj -> mkVP (mkV2 s) obj ;

  Ev : Type = {
    atom : NP ;
    subj : NP ;
    pred : VP ;
    evtype : EvType
    } ;

  linEvent : Ev -> Str = \ev -> case ev.evtype of {
    Sentence => (mkS (mkCl ev.subj ev.pred)).s ;
    Atom => (mkUtt ev.atom).s
    } ;

  npEvent : (atom,subj,pred : Str) -> Ev = \atom,s,p -> {
    atom = np atom ;
    subj = np s ;
    pred = mkVP (mkV p) ;
    evtype = Atom
    } ;

  have_VV : VV = infVV (lin V have_V2) ;

  param
    Tempor = TSim | TAnt ;

    EvType = Sentence | Atom ;
}

{-
`Pred Customer Finish`
"the customer finishes"


`Pred Customer (May Finish)`
"the customer may finish"

`Pred Customer (May (May Finish))`
"the customer may be allowed to finish" -}

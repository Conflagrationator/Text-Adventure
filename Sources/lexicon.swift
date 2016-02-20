let lexicon: [String: Set<LexicalCategory>] = [
    //"look":[Verb],
    //"examine":[Verb],
    //"glance":[Verb],
    //"read":[Verb],
    //"save":[Verb],
    //"restore":[Verb],
    //"quit":[Verb],
    //"restart":[Verb],
    "take":[Verb("take")],
    "get":[Verb("take")],
    "drop":[Verb("drop")],
    //"transfer":[Verb],
    "go":[Verb("go")],
    "move":[Verb("go")],
    //"open":[Verb, Adjective],
    //"close":[Verb],
    //"put":[Verb],
    //"push":[Verb],
    //"pull":[Verb],
    //"turn":[Verb],
    //"feel":[Verb],
    //"eat":[Verb],
    //"drink":[Verb],
    //"smell":[Verb],
    //"listen":[Verb],
    //"climb":[Verb],
    //"break":[Verb],
    //"burn":[Verb],
    //"lock":[Verb, Noun],
    //"unlock":[Verb],
    //"wave":[Verb],
    //"wear":[Verb],
    //"dig":[Verb],
    //"enter":[Verb],
    //"exit":[Verb],
    //"go":[Verb],
    //"search":[Verb],
    //"jump":[Verb],
    //"say":[Verb],
    //"yell":[Verb],
    //"whisper":[Verb],
    //"tell":[Verb],
    //"show":[Verb],
    //"help":[Verb, Noun],
    //"give":[Verb],
    //"kill":[Verb],
    //"attack":[Verb],
    //"kiss":[Verb],
    //"knock":[Verb],
    //"lick":[Verb],
    //"remove":[Verb],
    //"sit":[Verb],
    //"sleep":[Verb],
    //"wait":[Verb],
    //"taste":[Verb],
    "throw":[Verb("throw")],
    //"toss":[Verb],
    //"tie":[Verb, Noun],
    //"untie":[Verb],
    //"touch":[Verb],
    //"prod":[Verb],
    //"poke":[Verb],
    //"nudge":[Verb],
    //"blow":[Verb],
    //"buy":[Verb],
    //"cut":[Verb],
    //"rub":[Verb],
    //"wake":[Verb],
    //"swim":[Verb],
    //"squeeze":[Verb],
    //"crush":[Verb],
    //"mash":[Verb],
    //"set":[Verb],
    //"is":[Verb],
    
    "red":[Adjective("red")],
    "green":[Adjective("green")],
    "blue":[Adjective("blue")],
    "yellow":[Adjective("yellow")],
    "orange":[Adjective("orange"), Noun("orange")],
    "purple":[Adjective("purple")],
    "violet":[Adjective("purple")],
    "brown":[Adjective("brown")],
    "silver":[Adjective("silver"), Noun("silver")],
    "gold":[Adjective("gold"), Noun("gold")],
    "golden":[Adjective("gold")],
    "white":[Adjective("white")],
    "black":[Adjective("black")],
    "light":[Adjective("light"), Verb("light")],
    "dark":[Adjective("dark")],
    "clear":[Adjective("transparent"), Verb("clear")],
    "transparent":[Adjective("transparent")],
    "transluscent":[Adjective("transparent")],
    //"new":[Adjective],
    //"old":[Adjective],
    //"big":[Adjective],
    //"large":[Adjective],
    //"small":[Adjective],
    //"little":[Adjective],
    //"young":[Adjective],
    //"long":[Adjective],
    //"tall":[Adjective],
    //"broad":[Adjective],
    //"short":[Adjective],
    //"only":[Adjective],
    //"strong":[Adjective],
    //"weak":[Adjective],
    //"dead":[Adjective],
    //"best":[Adjective],
    //"worst":[Adjective],
    //"strongest":[Adjective],
    //"weakest":[Adjective],
    //"most":[Adjective],
    
    //"not":[Adverb],???
    
    "up":[Preposition("up")],
    "down":[Preposition("down")],
    "north":[Preposition("north")],
    "south":[Preposition("south")],
    "east":[Preposition("east")],
    "west":[Preposition("west")],
    "in":[Preposition("in")],
    "above":[Preposition("above")],
    "below":[Preposition("below")],
    "at":[Preposition("at")],
    "to":[Preposition("to")],
    "from":[Preposition("from")],
    //"left":[Preposition],
    //"right":[Preposition],
    "on":[Preposition("on"), Adverb("on"), Adjective("on")],
    "of":[Preposition("of")],
    //"about":[Preposition],
    //"around":[Preposition],
    //"except":[Preposition],
    //"with":[Preposition],
    //"using":[Preposition],
    
    "the":[Determiner("the")],
    "a":[Determiner("a")],
    "an":[Determiner("an")],
    "that":[Determiner("that"), Conjunction("that")],
    "my":[Determiner("my")],
    
    "and":[Conjunction("and")],
    "but":[Conjunction("but")],
    "then":[Conjunction("then")],
    
    // and some things (nouns) for testing ---------------------
    
    "inventory":[Noun("inventory")],
    "self":[Noun("self")],
    "pick":[Noun("pick"), Verb("unlock")],
    "broom":[Noun("broom")],
    "room":[Noun("room")],
    "door":[Noun("door")],
    "chair":[Noun("chair")],
    "me":[Noun("me")],
    "egg":[Noun("egg")],
    "pan":[Noun("pan")],
    "spoon":[Noun("spoon")],
    "fork":[Noun("fork")],
    "knife":[Noun("knife")],
    "sword":[Noun("sword")],
    "longsword":[Noun("longsword")],
    "bow":[Noun("bow")],
    "longbow":[Noun("longbow")],
    "mary":[Noun("mary")],
    "foe":[Noun("foe")]
]
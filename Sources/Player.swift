public class Player: Creature {
    
    override class var identifiers: Set<String> { return super.identifiers.union(["player"]) }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////
    
    var playing: Bool = true // to quit game loop // always starts as true when created (obviously)
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////
    
    /*init(named name: String, andDescription description: String = "", withHealth health: Int, atLocation location: Location, withEncumbrence encumbrance: Int, withInventoryOf inventory: Set<Item> = []) {
        super.init(named: name, andDescription: description, withHealth: health, atLocation: location, withEncumbrence: encumbrance, withInventoryOf: inventory)
    }*/
    
    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    // STATUS
    
    
    
    // ACTIONS
    
    func findItems(item: NounPhrase) -> Set<Item> {
        return []
    }
    
    // INTERACTIONS
    
    func input() {
        do {
            
            let command = try parse(prompt("> "), player: self) // global prompt
            command.perform(self)
            
        } catch SyntaxError.NoMatchesInLexicon(let word) {
            self.output("I do not know what you mean by \"\(word)\". Perhaps you misspelled the word?")
            // TODO: maybe do some searching for words that are close?
        } catch GrammarError.TooManyTokensLeft(let tokens) { // cannot match grammar fully
            // the
            func formatTokens(tokens: [Set<PhrasalCategory>]) -> String {
                let phrases: [String] = tokens.map({ (phrasePossibilities: Set<PhrasalCategory>) -> String in
                    var possibilities: [String] = []
                    for item in phrasePossibilities { // phrasalCategories in the set
                        possibilities += [item.phrasalOutput]
                    }
                    return possibilities.joinWithSeparator("/")
                })
                return phrases.joinWithSeparator(" | ")
            }
            
            self.output("cannot infer what you mean by \"\(formatTokens(tokens))\"")
        } catch GrammarError.NoTokensInSentence {
            self.output("\(self.name) simply stood there. silent.")
        } catch GrammarError.MultipleBuildsPossible(let possibilities) { // ambiguous
            // the resulting set of phrasal categories has too many possibilites in it
            let builds: [String] = Array(possibilities).map({ (phrase: PhrasalCategory) -> String in
                phrase.phrasalOutput
            })
            
            self.output("Ambiguous usage of input. Did you mean: \"\(builds.joinWithSeparator("\" or \""))\"")
        } catch SemanticsError.NotACommand(let phrase) {
            self.output("please enter a command. \"\(phrase.phrasalOutput)\" phrase is not a command")
        } catch { // catch-all
            self.output("something went wrong in parsing your input, please try again")
        }
    }
    
    func output(text: String) {
        // NOTE: keep any output to the player going through this function
        message(text)
    }
    
    // _________________________
    // PhrasalCategory Reference
    //
    // NounPhrase <- (Determiner) (Adjective) Noun (PrepositionalPhrase)
    // PrepositionalPhrase <- Preposition (NounPhrase)
    // VerbPhrase <- Verb (NounPhrase) (PrepositionalPhrase) (Adverb)
    
    func perform(command: RegularVerbPhrase) {
        switch command.verb.word {
            case "quit":
                if !hasNounPhrase(command) && !hasPrepositionalPhrase(command) && !hasAdverb(command) {
                    // TODO: check for save
                    quitGame()
                } else {
                    self.output("quit failed")
                }
            
            
            case "go":
                self.go(command.pp)
            
            
            case "look":
                if hasPrepositionalPhrase(command) && isCompound(command.pp) {
                    switch (command.pp as! RegularPrepositionalPhrase).prep.word {
                        case "at":
                            if hasNounPhrase(command) {
                                self.examine(command.np!, modifier: command.adv)
                            } else {
                                self.output("look at what?")
                            }
                        default:
                            self.output("look what?")
                    }
                } else if !hasNounPhrase(command) && !hasPrepositionalPhrase(command) && !hasAdverb(command) {
                    self.look()
                } else {
                    self.output("You're looking too complicatedly!")
                }
            
            
            case "examine":
                if hasNounPhrase(command) && !hasPrepositionalPhrase(command) {
                    self.examine(command.np!, modifier: command.adv)
                } else {
                    self.output("examine what?")
                }
            
            
            case "take":
                if hasPrepositionalPhrase(command) && !isCompound(command.pp) {
                    switch (command.pp as! RegularPrepositionalPhrase).prep.word {
                        case "from":
                            if hasNounPhrase(command) {
                                self.take(command.np!, modifier: command.adv)
                            } else {
                                self.output("take what from who?")
                            }
                        default:
                            self.output("take how?")
                    }
                } else {
                    if hasNounPhrase(command) {
                        self.take(command.np!, modifier: command.adv)
                    } else {
                        self.output("take what?")
                    }
                }
            
            
            default:
                self.output("I don't know how to \(command.verb.word) yet") // then the developer forgot to implement from the lexicon
        }
    }
    
    // ACTIONS
    
    func quitGame() {
        // TODO: make a quit sequence
        self.output("goodbye")
        self.playing = false
    }
    
    func take(selector: NounPhrase, from target: NounPhrase? = nil, modifier: Adverb?) { // transfer an item from the target's inventory to your own
        if (selector as! RegularNounPhrase).noun.word == "inventory" { // take inventory
            self.output(self.showInventory())
        } else { // take the item
            var items: Set<Item> = []
            do {
                if target == nil { // take from the location
                    items = try selector.select(fromItems: self.location.contents)
                } else { // take from the location specified
                    // TODO: add support for "take from [container]" && "take from [creature]" etc.
                    items = try selector.select(fromItems: self.location.contents)
                }
            } catch EvaluationError.DeterminerDidNotMatch(let determiner) {
                switch determiner {
                    case "the": // will be an error only if there are too many found and can't choose "the" item
                        self.output("matched too many")
                    case "a", "an": // only will be an error if it couldn't find any at all to choose from
                        self.output("no such items found")
                    default:
                        self.output("could not find items with restriction of \"\(determiner)\"")
                }
            } catch _ {
                self.output("unknown error when trying to find items")
            }
            
            if items.isEmpty {
                self.output("no such items found")
            } else { // it found things to take
                self.location.extract(items) // take the things from the location
                self.inventory.unionInPlace(items) // put them into your inventory
                self.output("taken")
                // TODO: test if it works
            }
        }
    }
    
    func give(selector: NounPhrase, to target: NounPhrase? = nil, modifier: Adverb?) { // transfer item from your inventory to another inventory
        
    }
    
    func look() {
        self.output(self.location.showDescription(self))
    }
    
    func examine(object: NounPhrase, modifier: Adverb? = nil) {
        for item in self.findItems(object) { // examine each item that matches filter
            item.showDescription()
            /* TODO: here
            switch modifier {
                case nil: // without modification
                    // do nothing
                case "closely":
                    // give very long details
                    // TODO: implement
                    
                default: // with unknown modification
                    self.output("examine \(object.phrasalOutput) how?")
            }*/
        }
    }
    
    func go(direction: PrepositionalPhrase?) { // move from this location to another through a portal
        if direction == nil {
            self.output("please specify a direction")
            return // abort
        }
        
        if let dir = direction as? RegularPrepositionalPhrase {
            switch dir.preposition.word {
                case "up", "down", "north", "south", "east", "west", "northwest", "northeast", "southwest", "southeast", "in", "out":
                    self.location.go(dir.preposition.word, by: self)
                default:
                    self.output("your direction was not understood")
            }
        } else if let dir = direction as? CompoundPrepositionalPhrase { // direction is CompoundPrepositionalPhrase
            switch dir.conjunction.word {
                case "and":
                    self.output("you can't move two ways at once!")
                case "then":
                    self.go(dir.firstPrepositionalPhrase)
                    self.output("then")
                    self.go(dir.secondPrepositionalPhrase)
                default:
                    self.output("I do not understand that conjunction in this context")
            }
        }
    }
    
}
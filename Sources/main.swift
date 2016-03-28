import CoreFoundation


////////////////////////////////////////////////////////////////
// TESTS
///////////////////////////////////////////////////////////////


var broom = Item(named: "broom", withDescription: "A sturdy, old broom", andWeight: 5, withAttributes: ["sturdy", "old"])
var initialLocation = Location(named: "Start Box", withDescription: "A plain, boring, empty room.", withContents: [broom])
var player = Player(named: "Jeff", withDescription: "you", withHealth: 100, atLocation: initialLocation, withEncumbrence: 12) // and no default inventory
var secondaryLocation = Location(named: "Hallway", withDescription: "A boring, long hallway.")
var portal = Portal(named: "Generic Portal", withDescription: "A boring, old portal.", from: initialLocation, to: secondaryLocation)
initialLocation.directions["north"] = portal
secondaryLocation.directions["south"] = portal


// Utility Functions

////////////////////////////////////////////////////////////////
// SETUP
////////////////////////////////////////////////////////////////

// Launch Arguments
let args = Process.arguments

// Game Variables

////////////////////////////////////////////////////////////////
// GAME LOOP
////////////////////////////////////////////////////////////////

//print(["asdf", "asj", "word"].joinWithSeparator("   "))
//message("Welcome to the game!")
//message(player.location.showDescription())


while player.playing {
    player.input()
}

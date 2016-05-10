public class Thing: Equatable, Hashable {
    
    class var identifiers: Set<String> { return ["thing"] }
    
    ////////////////////////////////////////////////////////////////
    // INSTANCE VARIABLES
    ////////////////////////////////////////////////////////////////

    var name: String // more of an "identifier" than a "name" really
    var description: String // what gets printed out

    public var hashValue: Int { // To conform with Hashable
        return unsafeAddressOf(self).hashValue
    }
    
    ////////////////////////////////////////////////////////////////
    // INITIALIZATION
    ////////////////////////////////////////////////////////////////

    init(_ name: String, _ description: String = "") {
        self.name = name
        self.description = description
    }

    ////////////////////////////////////////////////////////////////
    // METHODS
    ////////////////////////////////////////////////////////////////
    
    func showName() -> String {
        return self.name
    }
    
    func showDescription() -> String {
        return self.description
    }

}

////////////////////////////////////////////////////////////////
// EXTERNAL DEPENDENCIES
////////////////////////////////////////////////////////////////

public func ==(lhs: Thing, rhs: Thing) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

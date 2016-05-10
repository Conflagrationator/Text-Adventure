import Foundation

let whitespace = NSCharacterSet.whitespaceAndNewlineCharacterSet()

func zipToDict<S0 : SequenceType, S1 : SequenceType where S0.Generator.Element : Hashable>(keys: S0, values: S1) -> [S0.Generator.Element:[S1.Generator.Element]] {
    var dict: [S0.Generator.Element:[S1.Generator.Element]] = [:]
    for (key, value) in zip(keys, values) {
      dict[key] = (dict[key] ?? []) + [value]
    }
    return dict
}

extension Int {
    static func random(range: Range<Int> ) -> Int {
        var offset = 0
        
        if range.startIndex < 0   // allow negative ranges
        {
            offset = abs(range.startIndex)
        }
        
        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
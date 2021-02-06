//
//  ArrayExtension.swift
//  pokeFW
//
//  Created by burcu kirik on 6.02.2021.
//

import Foundation

public extension Array where Element: Equatable {
    
    func unique() -> Array {
        return reduce([]) { $0.contains($1) ? $0 : $0 + [$1] }
    }
    
}

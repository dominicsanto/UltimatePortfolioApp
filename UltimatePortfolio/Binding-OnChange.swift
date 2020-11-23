//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Dominic Santo on 2020/11/23.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}

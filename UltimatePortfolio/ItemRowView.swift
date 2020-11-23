//
//  ItemRowView.swift
//  UltimatePortfolio
//
//  Created by Dominic Santo on 2020/11/23.
//

import SwiftUI

struct ItemRowView: View {
    @ObservedObject var item: Item
    
    var body: some View {
        NavigationLink(destination: EditItemView(item: item)) {
            Text(item.itemTitle)
        }
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(item: <#T##Item#>.example)
    }
}

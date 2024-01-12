//
//  ToolbarItem.swift
//  Asana
//
//  Created by Nick Black on 1/11/24.
//

import SwiftUI

struct CustomToolbarItem: View {
    var image: String
    var body: some View {
        Image(systemName: image)
            .imageScale(.small)
    }
}

#Preview {
    CustomToolbarItem(image: "chevron.left")
}

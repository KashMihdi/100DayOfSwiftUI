//
//  DetailInformationRow.swift
//  FriendFace
//
//  Created by Kasharin Mikhail on 19.09.2023.
//

import SwiftUI

struct DetailInformationRow: View {
    let title: String
    let description: String

    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text("\(title):")
                .font(.title3.bold())
                .underline()
            
            Text(description)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DetailInformationRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailInformationRow(title: "Email", description: "alum32@yandex.ru")
    }
}

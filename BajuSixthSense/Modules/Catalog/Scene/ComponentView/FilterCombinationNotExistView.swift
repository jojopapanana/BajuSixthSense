//
//  FilterCombinationNotExistView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct FilterCombinationNotExistView: View {
    var body: some View {
        VStack {
            Text("Whoops, Sorry there’s no result available for this combination. Try another filter combination.")
                .font(.footnote)
                .foregroundStyle(.labelSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 231)
    }
}

#Preview {
    FilterCombinationNotExistView()
}

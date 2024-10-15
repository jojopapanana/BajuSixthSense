//
//  CatalogEmptyView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 13/10/24.
//

import SwiftUI

struct CatalogEmptyView: View {
    let filters = ["Shirt", "T-Shirt", "Sweater", "Hoodies", "Long Pants", "Skirts", "Shorts", "Jacket"]
    @State private var selectedFilters: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        disabledFilterLabel
                            .disabled(true)
                            .padding(.bottom, 86)
                        emptyCard
                    }
                }
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 393, height: 107)
                        .overlay(
                            HStack {
                                Spacer()
                                VStack {
                                    NavigationLink {
                                        UploadClothView()
                                    } label: {
                                        uploadButton
                                    }
                                    .disabled(true)
                                    Spacer()
                                }
                            }
                        )
                }
                .ignoresSafeArea()
            }
            .navigationTitle("Discover")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
//                        ProfileView()
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.systemPrimary)
                    }
                }
            }
        }
    }
    
    private var disabledFilterLabel: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(filters.indices, id: \.self) { index in
                    let filter = filters[index]
                    
                    DisabledFilterButton(
                        label: filter,
                        isSelected: selectedFilters.contains(filter),
                        action: {
                            if selectedFilters.contains(filter) {
                                selectedFilters.remove(filter)
                            } else {
                                selectedFilters.insert(filter)
                            }
                        }
                    )
                    .padding(.leading, index == 0 ? 16 : 0)
                    .padding(.trailing, index == filters.count - 1 ? 16 : 0)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.bottom)
    }
    
    private var emptyCard: some View {
        ZStack {
            Rectangle()
                .frame(width: 361, height: 220)
                .foregroundStyle(Color.systemGrey2)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 0.33)
                )
            VStack(alignment: .leading) {
                Text("Upload your Unused Clothes and Be Agent of Change")
                    .font(.system(size: 20, weight: .semibold))
                    .tracking(-0.4)
                    .frame(height: 50)
                    .foregroundStyle(Color.systemBlack)
                    .padding(.bottom, 10)
                Text("By uploading and sharing your unused clothes, it would minimizing environment pollution. Let’s start and make your move.")
                    .font(.system(size: 13, weight: .regular))
                    .tracking(-0.4)
                    .foregroundStyle(Color.systemGrey1)
                Spacer()
                HStack {
                    NavigationLink {
                        UploadClothView()
                    } label: {
                        Spacer()
                        Rectangle()
                            .frame(width: 158, height: 50)
                            .cornerRadius(12)
                            .overlay(
                                Text("Upload")
                                    .font(.system(size: 17, weight: .regular))
                                    .tracking(-0.43)
                                    .foregroundStyle(Color.systemWhite)
                            )
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal)
        }
        .frame(width: 361, height: 220)
    }
    
    private var uploadButton: some View {
        ZStack {
            Circle()
                .frame(width: 59, height: 59)
                .foregroundStyle(Color.systemGrey1)
                .shadow(radius: 4, y: 4)
            Image(systemName: "plus")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.systemWhite)
                .font(.system(size: 28, weight: .bold))
        }
        .padding(.trailing, 16)
        .padding(.top, 10)
    }
}

struct DisabledFilterButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 15))
                .tracking(-0.3)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(Color.clear)
                .foregroundColor(Color.systemGrey1)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.systemBlack, lineWidth: 1)
                )
                .cornerRadius(18)
        }
    }
}

#Preview {
    CatalogEmptyView()
}

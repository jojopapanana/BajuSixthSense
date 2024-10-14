//
//  CatalogNotAllowedLocationView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 14/10/24.
//

import SwiftUI

struct CatalogNotAllowedLocationView: View {
    let filters = ["Shirt", "T-Shirt", "Sweater", "Hoodies", "Long Pants", "Skirts", "Shorts", "Jacket"]
    @State private var selectedFilters: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    disabledFilterLabel
                        .disabled(true)
                        .padding(.bottom, 86)
                    notAllowedLocation
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
            .navigationTitle("Discover")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfileView()
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
                    
                    FilterButton(
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
    
    private var notAllowedLocation: some View {
        VStack {
            Text("Can we get your location, please?")
                .font(.system(size: 22, weight: .semibold))
                .tracking(-0.4)
                .lineSpacing(2.8)
                .foregroundStyle(Color.systemBlack)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 11)
            Text("We need it so we can show you all combinations you prefer.")
                .font(.system(size: 15, weight: .regular))
                .tracking(-0.4)
                .lineSpacing(2.0)
                .foregroundStyle(Color.systemGrey1)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 11)
            Rectangle()
                .frame(width: 212, height: 50)
                .foregroundStyle(Color.systemPrimary)
                .cornerRadius(12)                        .overlay(
                    Text("Check Location Setting")
                        .font(.system(size: 17, weight: .regular))
                        .tracking(-0.43)
                        .foregroundStyle(Color.white)
                )
        }
        .padding(.horizontal, 84)
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

#Preview {
    CatalogNotAllowedLocationView()
}

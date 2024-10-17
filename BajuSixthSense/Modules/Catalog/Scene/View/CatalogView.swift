//
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct CatalogView: View {
    let filters = ["Shirt", "T-Shirt", "Sweater", "Hoodies", "Long Pants", "Skirts", "Shorts", "Jacket"]
    @State private var selectedFilters: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        // filter
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
                        
                        // CatalogCard()
                        // masih ngakalin hehe
                        HStack(spacing: 36) {
                            CatalogCard()
                            CatalogCard()
                        }
                        .padding(.bottom, 36)
                        HStack(spacing: 36) {
                            CatalogCard()
                            CatalogCard()
                        }
                        .padding(.bottom, 36)
                        HStack(spacing: 36) {
                            CatalogCard()
                            CatalogCard()
                        }
                        .padding(.bottom, 107)
                    }
                }
                
                // blur + plus button
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .frame(width: 393, height: 107)
                        .overlay(
                            HStack {
                                Spacer()
                                VStack {
                                    NavigationLink {
                                        UploadClothView()
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: 59, height: 59)
                                                .foregroundStyle(Color.systemPrimary)
                                                .shadow(radius: 4, y: 4)
                                            Image(systemName: "plus")
                                                .resizable()
                                                .frame(width: 28, height: 28)
                                                .foregroundStyle(Color.systemWhite)
                                                .font(.system(size: 28, weight: .bold))                                        }
                                        .padding(.trailing, 16)
                                        .padding(.top, 10)
                                    }
                                    Spacer()
                                }
                            }
                        )
                }
                .ignoresSafeArea()
            }
            
            //navigation bar
            .navigationTitle("Discover")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // ke profile
                    }, label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.systemPrimary)
                    })
                }
            }
        }
    }
    
    // func buat kotak filter
    @ViewBuilder
    func selectedFilterButton(label: String, selectedFilter: Binding<Set<String>>) -> some View {
        Button(action: {
            if selectedFilter.wrappedValue.contains(label) {
                selectedFilter.wrappedValue.remove(label)
            } else {
                selectedFilter.wrappedValue.insert(label)
            }
        }) {
            Text(label)
                .font(.system(size: 15))
                .tracking(-0.3)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(selectedFilter.wrappedValue.contains(label) ? Color.systemBlack : Color.systemGrey2)
                .foregroundColor(selectedFilter.wrappedValue.contains(label) ? Color.systemWhite : Color.systemBlack)
                .cornerRadius(18)
        }
    }
}

struct FilterButton: View {
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
                .background(isSelected ? Color.black : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? Color.white : Color.black)
                .cornerRadius(18)
        }
    }
}

#Preview {
    CatalogView()
}

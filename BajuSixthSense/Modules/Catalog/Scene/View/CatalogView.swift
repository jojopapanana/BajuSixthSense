//
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct ClothesItem: Identifiable, Hashable {
    let id: UUID
    let tags: [String]
}

struct CatalogView: View {
    let filters = ["Shirt", "T-Shirt", "Sweater", "Hoodies", "Long Pants", "Skirts", "Shorts", "Jacket"]
    @State private var selectedFilters: Set<String> = []
    @State private var isResultEmpty: Bool = true
    @State private var isShowingSheet = false
    
    let clothes: [ClothesItem] = [
        ClothesItem(id: UUID(), tags: ["Shirt", "T-Shirt", "Sweater"]),
        ClothesItem(id: UUID(), tags: ["Shirt", "T-Shirt"]),
        ClothesItem(id: UUID(), tags: ["Shirt", "T-Shirt"]),
        ClothesItem(id: UUID(), tags: ["Shirt", "T-Shirt"]),
        ClothesItem(id: UUID(), tags: ["Shirt", "T-Shirt"]),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
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
//                        HStack(spacing: 36) {
////                            CatalogCard()
////                            CatalogCard()
//                        }
//                        .padding(.bottom, 36)
//                        HStack(spacing: 36) {
////                            CatalogCard()
////                            CatalogCard()
//                        }
//                        .padding(.bottom, 36)
//                        HStack(spacing: 36) {
//                            CatalogCard()
//                            CatalogCard()
//                        }
//                        .padding(.bottom, 107)
                    }
                }
                .padding(.bottom, 107)
            }
            
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
                                    //uploadButton
                                }
                                Spacer()
                            }
                        }
                    )
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Discover")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
//                    ProfileView()
                } label: {
                    Image(systemName: "person.fill")
                        .foregroundStyle(Color.systemPrimary)
                }
            }
        }
    }
    
    private var filterLabel: some View {
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
                            //                        updateResultState()
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
    
    private var clothesCard: some View {
        VStack(spacing: 36) {
            //        if filteredClothes.isEmpty {
            //            VStack {
            //                noResultMessage
            //                    .padding(.top, 263)
            //            }
            //        } else {
            //            ForEach(filteredClothes.chunked(into: 2), id: \.self) { pair in
            //                HStack(spacing: 16) {
            //                    ForEach(pair.indices, id: \.self) { index in
            //                        let cloth = pair[index]
            //                        NavigationLink {
            //                            ProductDetailReceiverView(numberofClothes: 5)
            //                        } label: {
            //                            ClothesCardView(numberofClothes: 10)
            //                                .padding(.leading, index == pair.count - 1 ? 16 : 0)
            //                        }
            //                    }
            //                    if pair.count == 1 {
            //                        Spacer()
            //                    }
            //                }
            //            }
            //        }
        }
    }
    
    private var uploadButton: some View {
        ZStack {
            Circle()
                .frame(width: 59, height: 59)
                .foregroundStyle(Color.systemPrimary)
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

//struct FilterButton: View {
//    let label: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(label)
//                .font(.system(size: 15))
//                .tracking(-0.3)
//                .padding(.horizontal, 14)
//                .padding(.vertical, 7)
//                .frame(height: 34)
//                .background(isSelected ? Color.black : Color.gray.opacity(0.2))
//                .foregroundColor(isSelected ? Color.white : Color.black)
//                .cornerRadius(18)
//        }
//        
//        private var filteredClothes: [ClothesItem] {
//            if selectedFilters.isEmpty {
//                return clothes
//            } else {
//                return clothes.filter { cloth in
//                    Set(cloth.tags).isSuperset(of: selectedFilters)
//                }
//            }
//        }
//        
//        private var noResultMessage: some View {
//            Text("Whoops, Sorry there’s no result available for this combination. Try another filter combination.")
//                .font(.system(size: 15))
//                .foregroundColor(Color.systemGrey1)
//                .multilineTextAlignment(.center)
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .padding(.horizontal, 80)
//        }
//        
//        private func updateResultState() {
//            isResultEmpty = selectedFilters.isEmpty
//        }
//        
//        func didDismiss() {
//            // Handle the dismissing action.
//        }
//    }
//    
//    extension Array {
//        func chunked(into size: Int) -> [[Element]] {
//            stride(from: 0, to: count, by: size).map {
//                Array(self[$0..<Swift.min($0 + size, count)])
//            }
//        }
//    }
//}



#Preview {
    CatalogView()
}

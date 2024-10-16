//
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct CatalogView: View {
    let filters: [ClothType] = [.Hoodies, .Jacket, .LongPants, .Shirt, .Shorts, .Skirts, .Sweater, .TShirt]
    @State private var selectedFilters: Set<ClothType> = []
//    @State var isFilterSelected: Bool = false
    @State private var isResultEmpty: Bool = false
    @State private var isShowingSheet = false
    @State private var isButtonDisabled = true
    @State private var isLocationAllowed = true
    @State private var catalogState: CatalogState = .initial
    
    @StateObject private var locationManager = LocationManager()
    @ObservedObject private var vm = CatalogViewModel()
    
    let clothes: [CatalogItemEntity] = [
        CatalogItemEntity(clothID: "cloth1", owner: ItemOwnerEntity(username: "un1", contactInfo: "08111111111", coordinate: (lat: 0, lon: 0)), photos: [], quantity: 10, category: [.Shirt, .Sweater], additionalNotes: "bajunya bagus semua", lastUpdated: Date(), status: .Posted)
    ]
    
    var body: some View {
        ZStack{
            Color.systemBGBase
                .ignoresSafeArea()
            
            NavigationStack {
                ZStack{
                    ScrollView {
                        VStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(filters.indices, id: \.self) { index in
                                        let filter = filters[index]
                                        
                                        FilterButton(label: filter, selectedFilters: $selectedFilters)
                                    }
                                }
                            }
                            .scrollIndicators(.hidden)
                            .padding([.horizontal, .bottom])
                            
                            switch catalogState {
                                case .initial:
                                    Text("Catalogue initial state")
                                case .locationNotAllowed:
                                    LocationNotAllowedView(isButtonDisabled: $isButtonDisabled)
                                case .catalogEmpty:
                                    EmptyCatalogueLabelView()
                                case .normal:
                                AllCatalogueView(filteredClothes: filteredClothes)
                                        .padding(.top, 20)
                                case .filterCombinationNotFound:
                                    FilterCombinationNotExistView()
                            }
                        }
                    }
                    .padding(.top, 9)
                    
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(height: 107)
                            .overlay(
                                HStack {
                                    Spacer()
                                    VStack {
                                        NavigationLink {
                                            UploadClothView()
                                        } label: {
                                            UploadButtonView(isButtonDisabled: $isButtonDisabled)
                                                .padding(.trailing, 16)
                                                .padding(.top, 10)
                                        }
                                        .disabled(isButtonDisabled)
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
                            ProfileView(isOwner: true)
                        } label: {
                            Image(systemName: "person.fill")
                                .foregroundStyle(Color.systemPrimary)
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear{
                catalogState = vm.checkCatalogStatus(clothesCount: clothes.count, isResultEmpty: isResultEmpty, isLocationAllowed: isLocationAllowed)
                checkUploadButtonStatus()
            }
//            .onChange(of: clothes){
//                catalogState = vm.checkCatalogStatus(clothesCount: clothes.count, isResultEmpty: isResultEmpty, isLocationAllowed: isLocationAllowed)
//            }
            .onChange(of: isResultEmpty){
                catalogState = vm.checkCatalogStatus(clothesCount: clothes.count, isResultEmpty: isResultEmpty, isLocationAllowed: isLocationAllowed)
            }
            .onChange(of: isLocationAllowed){
                catalogState = vm.checkCatalogStatus(clothesCount: clothes.count, isResultEmpty: isResultEmpty, isLocationAllowed: isLocationAllowed)
            }
            .task {
                locationManager.checkAuthorization()
            }
        }
    }
    
    private func checkUploadButtonStatus(){
        if clothes.isEmpty || !isLocationAllowed{
            isButtonDisabled = true
        } else {
            isButtonDisabled = false
        }
    }
    
//    @ViewBuilder
//    func selectedFilterButton(label: String, selectedFilter: Binding<Set<String>>) -> some View {
//        Button(action: {
//            if selectedFilter.wrappedValue.contains(label) {
//                selectedFilter.wrappedValue.remove(label)
//            } else {
//                selectedFilter.wrappedValue.insert(label)
//            }
//        }) {
//            Text(label)
//                .font(.system(size: 15))
//                .tracking(-0.3)
//                .padding(.horizontal, 14)
//                .padding(.vertical, 7)
//                .frame(height: 34)
//                .background(selectedFilter.wrappedValue.contains(label) ? Color.systemBlack : Color.systemGrey2)
//                .foregroundColor(selectedFilter.wrappedValue.contains(label) ? Color.systemWhite : Color.systemBlack)
//                .cornerRadius(18)
//        }
//    }
    
    private var filteredClothes: [CatalogItemEntity] {
        if selectedFilters.isEmpty {
            return clothes
        } else {
            return clothes.filter { cloth in
                let clothCategories = Set(cloth.category)
                let selected = selectedFilters
                return clothCategories.isSuperset(of: selected)
            }
        }
    }
}

#Preview {
    CatalogView()
}

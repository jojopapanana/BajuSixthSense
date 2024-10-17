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
//                                            UploadClothView()
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
//                            ProfileView(isOwner: true)
                        } label: {
                            Image(systemName: "person.fill")
                                .foregroundStyle(Color.systemPrimary)
                        }
                    }
                }
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
                                    //                                    UploadClothView()
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
    }
    
    private func checkUploadButtonStatus(){
        if clothes.isEmpty || !isLocationAllowed{
            isButtonDisabled = true
        } else {
            isButtonDisabled = false
        }
    }
    
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

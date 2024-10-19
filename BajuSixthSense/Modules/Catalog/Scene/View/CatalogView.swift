//
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI

struct CatalogView: View {
    @State private var selectedFilters: Set<ClothType> = []
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject private var vm = CatalogViewModel.shared
    
    let filters: [ClothType] = [.Hoodies, .Jacket, .LongPants, .Shirt, .Shorts, .Skirts, .Sweater, .TShirt]
    
    var body: some View {
        ZStack {
            Color.systemBGBase
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ScrollView {
                        VStack {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(filters.indices, id: \.self) { index in
                                        let filter = filters[index]
                                        
                                        FilterButton(label: filter, selectedFilters: $selectedFilters)
                                    }
                                }
                                .disabled(vm.isButtonDisabled)
                            }
                            .scrollIndicators(.hidden)
                            .padding([.horizontal, .bottom])
                            
                            switch vm.catalogState {
                                case .initial:
                                    Text("Catalogue initial state")
                                case .locationNotAllowed:
                                    LocationNotAllowedView(isButtonDisabled: $vm.isButtonDisabled)
                                case .catalogEmpty:
                                    EmptyCatalogueLabelView()
                                        .padding(.horizontal, 20)
                                case .normal:
                                    AllCatalogueView(
                                        filteredClothes: vm.filteredItems,
                                        catalogVM: vm
                                    )
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
                                        Button {
                                            navigationRouter.push(to: .Upload(state: .Upload, cloth: ClothEntity()))
                                        } label: {
                                            UploadButtonView(isButtonDisabled: $vm.isButtonDisabled)
                                                .padding(.trailing, 16)
                                                .padding(.top, 10)
                                        }
                                        .disabled(vm.isButtonDisabled)
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
                        Button {
                            navigationRouter.push(to: .Profile(items: nil))
                        } label: {
                            Image(systemName: "person.fill")
                                .foregroundStyle(Color.systemPrimary)
                        }
                    }
                }
            }
            .onChange(of: selectedFilters) { _, _ in
                vm.filterCatalogItems(filter: selectedFilters)
                vm.checkUploadButtonStatus()
            }
        }
    }
}

#Preview {
    CatalogView()
}

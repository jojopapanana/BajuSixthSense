//
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI
import RiveRuntime

struct CatalogView: View {
    @State private var selectedFilters: Set<ClothType> = []
    @State var isLocationButtonDisabled = false
    @State private var isFilterSheetShowed = false
    @State private var minimumPriceLimit = 50000.0
    @State private var maximumPriceLimit = 300000.0
//    @State private var cartItem = CartItem()
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject private var vm = CatalogViewModel.shared
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.systemBackground
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ScrollView {
                        VStack {
                            switch vm.catalogState {
                                case .initial:
                                    RiveViewModel(fileName:"shellyloading-4").view()
                                .frame(width: 200, height: 200)
                                .padding(.top, 200)
                                case .locationNotAllowed:
                                    LocationNotAllowedView(isButtonDisabled: $isLocationButtonDisabled)
                                case .catalogEmpty:
                                    EmptyCatalogueLabelView()
                                        .padding(.horizontal, 20)
                                case .normal:
                                    AllCatalogueView(
                                        filteredItem: vm.filteredItems,
                                        catalogVM: vm, isFilterSheetShowed: $isFilterSheetShowed
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
                            .fill(.clear)
                            .frame(height: 107)
                            .overlay(
                                HStack {
                                    #warning("code buat munculin cart iconnya :D")
//                                    if(!cartItem.clothes.isEmpty){
//                                        ZStack{
//                                            Button {
//                                                #warning("TO-DO: Navigate to cart page")
//                                            } label: {
//                                                ZStack{
//                                                    Circle()
//                                                        .fill(.systemBlack)
//                                                    
//                                                    Image(systemName: "basket.fill")
//                                                        .foregroundStyle(.systemPureWhite)
//                                                }
//                                                .frame(width: 50, height: 50)
//                                            }
//                                            
//                                            ZStack{
//                                                Circle()
//                                                    .stroke(.systemBlack, lineWidth: 1)
//                                                    .fill(.systemPureWhite)
//                                                    .frame(width: 19, height: 19)
//                                                
//                                                Text("\(cartItem.clothes.count)")
//                                            }
//                                            .offset(x: 15, y: -20)
//                                        }
//                                        .padding([.leading, .top])
//                                    }
                                    
                                    Spacer()
                                    
                                        Button {
                                            navigationRouter.push(to: .Upload(state: .Upload, cloth: ClothEntity()))
                                        } label: {
                                            UploadButtonView(isButtonDisabled: $vm.isButtonDisabled)
                                        }
                                        .disabled(vm.isButtonDisabled)
                                }
                            )
                    }
                    .padding([.horizontal, .bottom])
                    .ignoresSafeArea()
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Text("Katalog")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        ProfileView(VariantType: .pemberi)
//                        navigationRouter.push(to: .Profile(items: nil))
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.systemPurple)
                    }
                }
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        isFilterSheetShowed = true
//                    } label: {
//                        Image(systemName: "slider.horizontal.3")
//                            .foregroundStyle(Color.systemPurple)
//                    }
//                }
//            }
//            .onChange(of: selectedFilters) { _, _ in
//                vm.filterCatalogItems(filter: selectedFilters)
//                vm.checkUploadButtonStatus()
//            }
            
//            HStack{
//                Spacer()
//                Button{
//                    print("buttonnya ke klik")
//                    isFilterSheetShowed = true
//                } label: {
//                    Image(systemName: "slider.horizontal.3")
//                        .font(.system(size: 20))
//                        .onTapGesture {
//                            isFilterSheetShowed = true
//                        }
//                }
//                .padding(.top, -35)
//            }
        }
        .sheet(isPresented: $isFilterSheetShowed) {
            PriceFilterSheetView(isSheetShowing: $isFilterSheetShowed, currentMinPrice: $minimumPriceLimit, currentMaxPrice: $maximumPriceLimit)
                .presentationDetents([.height(271)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    CatalogView()
}

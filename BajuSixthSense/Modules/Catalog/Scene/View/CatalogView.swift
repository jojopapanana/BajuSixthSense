//
//  CatalogViewController.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import SwiftUI
import RiveRuntime

struct CatalogView: View {
    @State var isLocationButtonDisabled = false
    @State private var isFilterSheetShowed = false
    @State private var minimumPriceLimit = 0.0
    @State private var maximumPriceLimit = 500000.0
    @State private var isRefreshing = false
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject private var vm = CatalogViewModel.shared
    @ObservedObject private var cartVM = ClothCartViewModel.shared
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.systemBackground
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    ScrollView {
                        LazyVStack {
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
                                AllCatalogueView(catalogVM: vm, cartVM: cartVM, isFilterSheetShowed: $isFilterSheetShowed)
                                    .padding(.top, 20)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .padding(.top, 9)
                    
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 107)
                            .overlay(
                                HStack {
                                    if(!cartVM.catalogCart.clothItems.isEmpty){
                                        ZStack{
                                            Button {
                                                navigationRouter.push(to: .ClothCart)
                                            } label: {
                                                ZStack{
                                                    Circle()
                                                        .fill(.systemBlack)
                                                    
                                                    Image(systemName: "basket.fill")
                                                        .foregroundStyle(.systemPureWhite)
                                                }
                                                .frame(width: 50, height: 50)
                                            }
                                            
                                            ZStack{
                                                Circle()
                                                    .stroke(.systemBlack, lineWidth: 1)
                                                    .fill(.systemPureWhite)
                                                    .frame(width: 19, height: 19)
                                                
                                                Text("\(cartVM.catalogCart.clothItems.count)")
                                            }
                                            .offset(x: 15, y: -20)
                                        }
                                        .padding([.leading, .top])
                                    }
                                    
                                    Spacer()
                                    
                                    Button {
                                        if(LocalUserDefaultRepository.shared.fetch()?.username != ""){
                                            navigationRouter.push(to: .Upload)
                                        } else {
                                            navigationRouter.push(to: .FillData)
                                        }
                                        
                                    } label: {
                                        UploadButtonView(isButtonDisabled: $vm.isButtonDisabled)
                                    }
                                    .disabled(vm.isButtonDisabled)
                                }
                                    .padding([.horizontal, .bottom])
                                    .background(.ultraThinMaterial)
                            )
                    }
                    .ignoresSafeArea()
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Text("Katalog")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        navigationRouter.push(to: .Profile(userID: nil))
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.systemPurple)
                    }
                }
            }
        }
        .sheet(isPresented: $isFilterSheetShowed) {
            PriceFilterSheetView(isSheetShowing: $isFilterSheetShowed, currentMinPrice: $minimumPriceLimit, currentMaxPrice: $maximumPriceLimit, viewModel: vm)
                .presentationDetents([.height(271)])
                .presentationDragIndicator(.visible)
        }
    }
}

//#Preview {
//    CatalogView()
//}

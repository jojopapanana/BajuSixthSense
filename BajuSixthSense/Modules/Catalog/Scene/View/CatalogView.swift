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
                                    AllCatalogueView(catalogVM: vm, cartVM: cartVM)
                                    .padding(.top, 20)
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
                                        navigationRouter.push(to: .Upload)
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
                    Button {
                        navigationRouter.push(to: .Profile(userID: nil))
                    } label: {
                        Image(systemName: "person.fill")
                            .foregroundStyle(Color.systemPurple)
                    }
                    .padding(.top, 20)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isFilterSheetShowed = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(Color.systemPurple)
                    }
                    .padding(.top, 20)
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

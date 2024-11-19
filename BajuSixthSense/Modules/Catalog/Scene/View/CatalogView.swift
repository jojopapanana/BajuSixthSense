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
    @State private var minimumPriceLimit = 50000.0
    @State private var maximumPriceLimit = 300000.0
    
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
                                    AllCatalogueView(catalogVM: vm)
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
                                    if(vm.checkCartIsEmpty()){
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
                                                
                                                Text("\(vm.catalogCart.clothItems.count)")
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
            .navigationTitle("Katalog")
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
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isFilterSheetShowed = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(Color.systemPurple)
                    }
                }
            }
            
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

//#Preview {
//    CatalogView()
//}

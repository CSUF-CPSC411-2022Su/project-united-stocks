//
//  WatchlistView.swift
//  UnitedStock
//
//  Created by csuftitan on 6/11/22.
//
//

import SwiftUI

struct WatchlistView: View {
    @EnvironmentObject var stockManager: Watchlist
    @State var searchStock = ""
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(stockManager.stocks) {
                        WatchlistStocks in
                        HStack {
                            NavigationLink(destination: Text("\(WatchlistStocks.stockName) view \n Description: \(WatchlistStocks.description)").multilineTextAlignment(.center)) {
                                Text(WatchlistStocks.stockName)
                                Spacer()
                                Text(WatchlistStocks.price)
                                    .font(.headline).foregroundColor(Color.green)
                            }
                        }
                    }.onDelete(perform: stockManager.deleteStock)
                        .onMove(perform: stockManager.moveStock)
                }
            }.navigationBarTitle(Text("Watchlist"))
                .navigationBarItems(leading: EditButton())
                .toolbar {
                    Button {} label: {
                        Label("Add Stock", systemImage: "plus")
                    }
                }
                .searchable(text: $searchStock, placement: .navigationBarDrawer(displayMode: .always))
        }
    }

    struct AddStocksView: View {
        @SceneStorage("Stock Name") var addStockName: String = ""
        @EnvironmentObject var stockManager: Watchlist
        var body: some View {
            NavigationView {
                VStack {
                    HStack {
                        Text("Stock Submission")
                            .bold()
                            .font(.largeTitle)
                    }
                    .padding(.bottom, 30)

                    HStack {
                        Text("Stock Name")
                            .bold()
                        Spacer()
                    }
                    .padding(.bottom, 5)
                    HStack {
                        TextField("Stock Name", text: $addStockName)
                        Spacer()
                    }
                    .padding(.bottom, 20)
                    Button(action: {
                        stockManager.stocks.append(StockProps(stockName: addStockName, symbol: "", description: "", price: ""))
                        addStockName = ""
                    }) {
                        Text("Submit")
                    }
                    Spacer()
                }
                .padding()
            }
        }
    }

    struct WatchlistView_Previews: PreviewProvider {
        static var previews: some View {
            WatchlistView()
        }
    }
}

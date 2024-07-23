//
//  ListLoop.swift
//  WarmUp
//
//  Created by 서정원 on 7/19/24.
//

import SwiftUI

struct Fruits: Hashable {
    let name: String
    let matchFruitName: String
    let price: Int
}

struct ListLoop: View {
    
    @State var favoritePrice = [
        Fruits(name: "Apple", matchFruitName: "Banana", price: 1000),
        Fruits(name: "Banana", matchFruitName: "Banana", price: 3000),
        Fruits(name: "Cherry", matchFruitName: "Banana", price: 4000),
        Fruits(name: "Double", matchFruitName: "Banana", price: 2400),
        Fruits(name: "Edit", matchFruitName: "Apple", price: 8000)
    ]
    
    @State var fruitname = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("insert fruit name", text: $fruitname)
                    Button {
                        favoritePrice.append(Fruits(name: fruitname, matchFruitName: "Apple", price: 1000))
                    } label: {
                        Text("Insert")
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                }
                .padding()
                List {
                    ForEach(favoritePrice, id: \.self) { fruits in
                        VStack(alignment: .leading) {
                            Text("named: \(fruits.name)")
                            Text("matchFruitName: \(fruits.matchFruitName)")
                            Text("named: \(fruits.price)")
                        }
                    }
                    .onDelete(perform: { indexSet in
                        favoritePrice.remove(atOffsets: indexSet)
                    })
                }
                
                .navigationTitle("Fruit List")
            }
        }
    }
}

#Preview {
    ListLoop()
}

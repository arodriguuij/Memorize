//
//  ContentView.swift
//  Memorize
//
//  Created by Alejandro Rodriguez on 7/11/23.
//

import SwiftUI

struct ContentView: View {
    let spaceEmojis: [String] = ["🔭", "🪐", "☄️", "🛸", "👽", "🛰️", "🌎", "🚀", "🧑‍🚀", "👾"]
    let scarryEmojis: [String] = ["💀", "👻", "🎃", "🕷️", "🕸️", "🐦‍⬛", "🦂"]
    let vechicleEmojis: [String] = ["✈️", "🛵", "⛴️", "⛵️", "🏎️"]
    
    @State var emojis: [String] = []
    
    var body: some View {
        Text("Memorize").font(.largeTitle)
        VStack{
            ScrollView{
                cards
            }
            Spacer()
            cardButtons
        }
        .padding()
    }
   
    var cardButtons: some View {
        HStack{
            buttonSpaceTheme
            Spacer()
            buttonScarryTheme
            Spacer()
            buttonVehicleTheme
        }
        .imageScale(.large)
        .font(.largeTitle)
        
    }
    
    func themeButtonAction(theme: String, symbol: String, emojis themedEmojies: [String])-> some View{
        Button(action: {
            var duplicatedEmojis = themedEmojies + themedEmojies
            duplicatedEmojis.shuffle()
            emojis = duplicatedEmojis
        }, label: {
            VStack{
                Image(systemName: symbol)
                Text(theme).font(.caption)
            }
        })
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 68))]){
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var buttonSpaceTheme: some View {
        themeButtonAction(theme: "Space", symbol: "star.fill", emojis: spaceEmojis)
    }
    var buttonScarryTheme: some View {
        themeButtonAction(theme: "Scarry", symbol: "moon.stars.fill", emojis: scarryEmojis)
    }
    var buttonVehicleTheme: some View {
        themeButtonAction(theme: "Vehicle", symbol: "car.fill", emojis: vechicleEmojis)
    }

//    var cardButtons: some View {
//        HStack{
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
        
//    func cardCountAjuster(by offset : Int, symbol: String) -> some View {
//        Button(action: {
//                cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount - offset < 1 || cardCount + offset > emojis.count)
//    }
    
//    var cardRemover: some View {
//        cardCountAjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
//    }
//    
//    var cardAdder: some View {
//        cardCountAjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
//    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false //Temporary state

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
            print("Tapped")
        }
    }
}

#Preview {
    ContentView()
}

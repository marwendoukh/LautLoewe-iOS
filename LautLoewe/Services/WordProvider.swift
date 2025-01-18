//
//  WordProvider.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

class WordProvider: WordProvidable {
    
    private let wordsWithD = [
        Word(text: "Dach", systemImageName: "house.fill"),
        Word(text: "Dose", systemImageName: "cylinder.fill"),
        Word(text: "Dampf", systemImageName: "smoke.fill"),
        Word(text: "Daumen", systemImageName: "hand.thumbsup.fill"),
        Word(text: "Drache", systemImageName: "flame.fill"),
        Word(text: "Drucker", systemImageName: "printer.fill"),
        Word(text: "Diamant", systemImageName: "diamond.fill"),
        Word(text: "Decke", systemImageName: "bed.double.fill"),
        Word(text: "Donner", systemImageName: "cloud.bolt.fill"),
        Word(text: "Delfin", systemImageName: "water.waves"),
        Word(text: "Doktor", systemImageName: "cross.case.fill"),
        Word(text: "Dusche", systemImageName: "shower.fill"),
        Word(text: "Daumen", systemImageName: "hand.thumbsup.fill"),
        Word(text: "Dorf", systemImageName: "house.and.flag.fill"),
        Word(text: "Düne", systemImageName: "mountain.2.fill")
    ]
    
    private let wordsWithB = [
        Word(text: "Ball", systemImageName: "circle.fill"),
        Word(text: "Buch", systemImageName: "book.fill"),
        Word(text: "Baum", systemImageName: "leaf.fill"),
        Word(text: "Biene", systemImageName: "ant.fill"),
        Word(text: "Brot", systemImageName: "takeoutbag.and.cup.and.straw.fill"),
        Word(text: "Berg", systemImageName: "mountain.2.fill"),
        Word(text: "Boot", systemImageName: "ferry.fill"),
        Word(text: "Blume", systemImageName: "flower.fill"),
        Word(text: "Brief", systemImageName: "envelope.fill"),
        Word(text: "Brille", systemImageName: "eyeglasses"),
        Word(text: "Bett", systemImageName: "bed.double.fill"),
        Word(text: "Birne", systemImageName: "lightbulb.fill"),
        Word(text: "Bahn", systemImageName: "tram.fill"),
        Word(text: "Bohne", systemImageName: "leaf.fill"),
        Word(text: "Blitz", systemImageName: "bolt.fill")
    ]
    
    private var allWords: [Word] {
        self.wordsWithD + self.wordsWithB
    }
    
    func getRandomWord() -> Word {
        self.allWords.randomElement() ?? self.allWords[0]
    }
}

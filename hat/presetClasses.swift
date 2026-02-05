//
//  presetClasses.swift
//  hat
//
//  Created by Alisa Potapova on 28.01.2026.
//

class SectionPreset {
    let id: Int
    let image: String
    let name: String
    let desc: String
    let wordsCount: String
    
    init(id: Int, image: String, name: String, desc: String, wordsCount: String) {
        self.id = id
        self.image = image
        self.name = name
        self.desc = desc
        self.wordsCount = wordsCount
    }
}

class OwnwordPreset {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

class ResultPreset {
    let id: Int
    let word: String
    let isCorrect: Bool
    
    init(id: Int, word: String, isCorrect: Bool) {
        self.id = id
        self.word = word
        self.isCorrect = isCorrect
    }
}

class PlayerPreset {
    let id: Int
    let name: String
    let wordsRoundScore: Int
    let gesturesRoundScore: Int
    let onewordRoundScore: Int
    let drawingRoundScore: Int
    let totalScore: Int
    
    
    init(id: Int, name: String, wordsRoundScore: Int = 0, gesturesRoundScore: Int = 0, onewordRoundScore: Int = 0, drawingRoundScore: Int = 0, totalScore: Int = 0) {
        self.id = id
        self.name = name
        self.wordsRoundScore = wordsRoundScore
        self.gesturesRoundScore = gesturesRoundScore
        self.onewordRoundScore = onewordRoundScore
        self.drawingRoundScore = drawingRoundScore
        self.totalScore = totalScore
    }
}

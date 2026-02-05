
import UIKit
import CoreData




extension testScreensVC {
    
    func loadPresets() {
        let moc = getContext()
        let sortdDescriptor = NSSortDescriptor.init(key: "id", ascending: true)
        
        
        var results = getEntity(type: Result.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        if results.isEmpty {
            if let mc = moc {
                for i in 0..<resultPresets.count {
                   let newItem = Result(context: mc)
                   newItem.id = Int32(resultPresets[i].id)
                   newItem.word = resultPresets[i].word
                   newItem.isCorrect = resultPresets[i].isCorrect
        
                   results.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
        
        
        var ownwords = getEntity(type: Ownword.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        if ownwords.isEmpty {
            if let mc = moc {
                for i in 0..<ownwordPresets.count {
                   let newItem = Ownword(context: mc)
                   newItem.id = Int32(ownwordPresets[i].id)
                   newItem.name = ownwordPresets[i].name
        
                   ownwords.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
        
        var players = getEntity(type: Player.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        if players.isEmpty {
            if let mc = moc {
                for i in 0..<playerPresets.count {
                    let newItem = Player(context: mc)
                    newItem.id = Int32(playerPresets[i].id)
                    newItem.name = playerPresets[i].name
                    newItem.wordsRoundScore = Int32(playerPresets[i].wordsRoundScore)
                    newItem.gesturesRoundScore = Int32(playerPresets[i].gesturesRoundScore)
                    newItem.onewordRoundScore = Int32(playerPresets[i].onewordRoundScore)
                    newItem.drawingRoundScore = Int32(playerPresets[i].drawingRoundScore)
                    newItem.totalScore = Int32(playerPresets  [i].totalScore)

                   players.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
        
        
        var sections = getEntity(type: Section.self, moc: moc, sortdDescriptors: [sortdDescriptor], predicates: [])
        if sections.isEmpty {
            if let mc = moc {
                for i in 0..<testSectionPresets.count {
                    let newItem = Section(context: mc)
                    newItem.id = Int32(testSectionPresets[i].id)
                    newItem.image = testSectionPresets[i].image
                    newItem.name = testSectionPresets[i].name
                    newItem.desc = testSectionPresets[i].desc
                    newItem.wordsCount = testSectionPresets[i].wordsCount
                    sections.append(newItem)
                }
            }
            saveContext(moc: moc)
        }
        
    }
    
    
}




let testSectionPresets: [SectionPreset] = [
    SectionPreset(id: 1, image: "themeImage", name: "Стартовый набор", desc: "здесь бедут боольшое описание темы Старт десь бедут боольшое описание темы Старт", wordsCount: "120"),
    SectionPreset(id: 2, image: "themeImage", name: "Гарри Поттер", desc: "здесь бедут боольшое описание темы Гарри десь бедут боольшое описание темы Гарри", wordsCount: "230", ),
    SectionPreset(id: 3, image: "themeImage", name: "Средняя сложность", desc: "здесь бедут боольшое описание темы Средняя десь бедут боольшое описание темы Средняя", wordsCount: "187")
    ]





let testPlayerPresets: [PlayerPreset] = [
    PlayerPreset(id: 1, name: "Таня", wordsRoundScore: 2, gesturesRoundScore: 1, onewordRoundScore: 0, drawingRoundScore: 15, totalScore: 8),
    PlayerPreset(id: 2, name: "Алекс", wordsRoundScore: 14, gesturesRoundScore: 3, onewordRoundScore: 5, drawingRoundScore: 6, totalScore: 18),
    PlayerPreset(id: 3, name: "Дима", wordsRoundScore: 1, gesturesRoundScore: 7, onewordRoundScore: 4, drawingRoundScore: 2, totalScore: 14),
]


let ownwordPresets: [OwnwordPreset] = [
    OwnwordPreset(id: 1, name: "Корова"),
    OwnwordPreset(id: 2, name: "Кошка маркошка пирожка"),
    OwnwordPreset(id: 3, name: "Собака"),
    OwnwordPreset(id: 4, name: "Крыша"),
    OwnwordPreset(id: 5, name: "Ток"),
    OwnwordPreset(id: 6, name: "Выбросить мусор"),
    OwnwordPreset(id: 7, name: "Карандаш"),
]

let resultPresets: [ResultPreset] = [
    ResultPreset(id: 1, word: "Розетка", isCorrect: true),
    ResultPreset(id: 2, word: "Слон", isCorrect: false),
    ResultPreset(id: 3, word: "Гвоздь", isCorrect: true),
    ResultPreset(id: 4, word: "С неба упали три яблока", isCorrect: false),
]
/*
 
 let testSectionPresets: [SectionPreset] = [
     SectionPreset(id: 1, image: "themeImage", name: "Стартовый набор", desc: "здесь бедут боольшое описание темы Старт десь бедут боольшое описание темы Старт", wordsCount: "120", product_id: "none", state: "unlocked"),
     SectionPreset(id: 2, image: "themeImage", name: "Гарри Поттер", desc: "здесь бедут боольшое описание темы Гарри десь бедут боольшое описание темы Гарри", wordsCount: "230", product_id: "com.potapova.test", state: "locked"),
     SectionPreset(id: 3, image: "themeImage", name: "Средняя сложность", desc: "здесь бедут боольшое описание темы Средняя десь бедут боольшое описание темы Средняя", wordsCount: "187", product_id: "com.potapova.test", state: "locked")
     ]
 
 
 
 if players.isEmpty {
     if let mc = moc {
         for i in 0..<playerPresets.count {
            let newItem = Player(context: mc)
            newItem.id = Int32(playerPresets[i].id)
            newItem.wordsRoundScore = playerPresets[i].wordsRoundScore
            newItem.gesturesRoundScore = playerPresets[i].gesturesRoundScore
            newItem.onewordRoundScore = playerPresets[i].onewordRoundScore
            newItem.drawingRoundScore = playerPresets[i].drawingRoundScore
            newItem.totalScore = playerPresets[i].totalScore

            players.append(newItem)
         }
     }
     saveContext(moc: moc)
 }
 
 
 if results.isEmpty {
     if let mc = moc {
         for i in 0..<resultPresets.count {
            let newItem = Result(context: mc)
            newItem.id = Int32(resultPresets[i].id)
            newItem.word = resultPresets[i].word
            newItem.isCorrect = resultPresets[i].isCorrect
 
            results.append(newItem)
         }
     }
     saveContext(moc: moc)
 }
 
 
 
 if ownwords.isEmpty {
     if let mc = moc {
         for i in 0..<ownwordPresets.count {
            let newItem = Ownword(context: mc)
            newItem.id = Int32(ownwordPresets[i].id)
            newItem.name = ownwordPresets[i].name
 
            ownwords.append(newItem)
         }
     }
     saveContext(moc: moc)
 }
 
 if sections.isEmpty {
     if let mc = moc {
         for i in 0..<sectionPresets.count {
             let newItem = Section(context: mc)
             newItem.id = Int32(sectionPresets[i].id)
             newItem.image = sectionPresets[i].image
             newItem.name = sectionPresets[i].name
             newItem.desc = sectionPresets[i].desc
             newItem.wordsCount = sectionPresets[i].wordsCount
             newItem.product_id = sectionPresets[i].product_id
             newItem.state = sectionPresets[i].state
 
             sections.append(newItem)
         }
     }
     saveContext(moc: moc)
 }
 */

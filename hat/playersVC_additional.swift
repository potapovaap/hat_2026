import UIKit
extension playersVC {
    func clearResultsAlert() {
        let alert = UIAlertController(title: lang_scheme[cur_lang]?["alertClearResultsTitle"] as? String, message: lang_scheme[cur_lang]?["alertClearResultsMessage"] as? String, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: yesTitle, style: .default) { (_) in
            self.clearResults()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    func clearResults() {
        for player in players {
            player.wordsRoundScore = 0
            player.gesturesRoundScore = 0
            player.onewordRoundScore = 0
            player.drawingRoundScore = 0
            player.totalScore = 0
        }
        getPlayers()
        updatePlayers()
    }

    func setGameType() {
        let gameType = Int(settings["gameType"] ?? "0") ?? 0
        let gameTypeText = gameType == 0 ? "teamGame" : "singleGame"
        gameTypeLabel.text = (lang_scheme[cur_lang]?[gameTypeText] as? String)?.uppercased()
    }
}

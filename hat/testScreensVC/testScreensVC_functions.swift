import UIKit
extension testScreensVC {
	@objc func menuButtonPressed() {
		goNextVC("menuVC")
	}

	@objc func emptyhatButtonPressed() {
		goNextVC("emptyhatVC")
	}

	@objc func gameButtonPressed() {
		goNextVC("gameVC")
	}

	@objc func ownwordsButtonPressed() {
		goNextVC("ownwordsVC")
	}

	@objc func playersButtonPressed() {
		goNextVC("playersVC")
	}

	@objc func resultsButtonPressed() {
		goNextVC("resultsVC")
	}

	@objc func sectionsButtonPressed() {
		goNextVC("sectionsVC")
	}

	@objc func startNewPlayerButtonPressed() {
		goNextVC("startNewPlayerVC")
	}

	@objc func startNewRoundButtonPressed() {
		goNextVC("startNewRoundVC")
	}

	@objc func victoryButtonPressed() {
		goNextVC("victoryVC")
	}
    
    @objc func settingsButtonPressed() {
        goNextVC("settingsVC")
    }
    
    @objc func rulesButtonPressed() {
        goNextVC("rulesVC")
    }

    
    
}

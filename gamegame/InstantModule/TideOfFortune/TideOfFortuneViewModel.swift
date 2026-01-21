import SwiftUI

class TideOfFortuneViewModel: ObservableObject {
    let contact = TideOfFortuneModel()
    @Published var win = 0
    @Published var coin = UserDefaultsManager.shared.coins
    @Published var bet: Int = 50
    
    @Published var isFlying = false
    @Published var multiplier: Double = 1.00
    @Published var gameResult: GameResult = .none
    @Published var showResult = false
    
    enum GameResult {
        case none, win, lose
    }
    
    private var timer: Timer?
    private var crashMultiplier: Double = 0
    
    func startGame() {
        isFlying = true
        showResult = false
        multiplier = 1.0
        gameResult = .none
        
        crashMultiplier = Double.random(in: 1.5...4.5)
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            self.updateMultiplier()
        }
    }
    
    func withdraw() {
        timer?.invalidate()
        isFlying = false
        multiplier = max(1.2, multiplier)
        gameResult = .win
        showResult = true
        updateCoins(true)
    }
    
    private func updateMultiplier() {
        multiplier += 0.08
        
        if multiplier >= crashMultiplier {
            timer?.invalidate()
            isFlying = false
            gameResult = .lose
            showResult = true
            updateCoins(false)
        }
    }
    
    private func updateCoins(_ won: Bool) {
        let payout = Int(Double(bet) * multiplier)
        if won {
            coin += payout - bet
            UserDefaultsManager.shared.recordWin(payout)
        } else {
            coin -= bet
            UserDefaultsManager.shared.recordLoss(bet)
        }
        UserDefaultsManager.shared.coins = coin
    }
}

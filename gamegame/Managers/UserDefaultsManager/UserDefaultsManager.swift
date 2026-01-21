import SwiftUI

class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()
     let defaults = UserDefaults.standard
    
    @Published var coins: Int = 0 {
        didSet { defaults.set(coins, forKey: "coins") }
    }
    
    @Published var profileImageData: Data? {
        didSet {
            if let data = profileImageData {
                defaults.set(data, forKey: "profileImageData")
            } else {
                defaults.removeObject(forKey: "profileImageData")
            }
        }
    }
    @Published var currentStreak: Int = 0 {
        didSet { defaults.set(currentStreak, forKey: "currentStreak") }
    }
    @Published var totalWins: Int = 0 {
        didSet { defaults.set(totalWins, forKey: "totalWins") }
    }
    
    @Published var totalLosses: Int = 0 {
        didSet { defaults.set(totalLosses, forKey: "totalLosses") }
    }
    
    @Published var maxWinAmount: Int = 0 {
        didSet { defaults.set(maxWinAmount, forKey: "maxWinAmount") }
    }
    
    var totalGames: Int { totalWins + totalLosses }
    var winRate: Double {
        guard totalGames > 0 else { return 0.0 }
        return Double(totalWins) / Double(totalGames) * 100
    }
    
    private init() {
        loadData()
    }
    
    func addCoins(_ amount: Int) {
        coins += amount
        updateMaxWin(amount)
    }
    
    func removeCoins(_ amount: Int) {
        coins = max(0, coins - amount)
    }
    
    func recordWin(_ winAmount: Int) {
        totalWins += 1
        currentStreak = (currentStreak >= 0 ? currentStreak + 1 : 1)
        addCoins(winAmount)
        updateMaxWin(winAmount)
    }

    func recordLoss(_ betAmount: Int) {
        totalLosses += 1
        currentStreak = -1
        removeCoins(betAmount)
    }
    
    private func updateMaxWin(_ amount: Int) {
        if amount > maxWinAmount {
            maxWinAmount = amount
        }
    }
    
    private func loadData() {
        if let imageData = defaults.data(forKey: "profileImageData") {
            profileImageData = imageData
        }
        currentStreak = defaults.integer(forKey: "currentStreak")
        coins = defaults.integer(forKey: "coins")
        totalWins = defaults.integer(forKey: "totalWins")
        totalLosses = defaults.integer(forKey: "totalLosses")
        maxWinAmount = defaults.integer(forKey: "maxWinAmount")
    }
    
    func resetStats() {
        let defaults = UserDefaults.standard
        defaults.set(5000, forKey: "coins")
        defaults.set(0, forKey: "currentStreak")
        defaults.set(0, forKey: "totalWins")
        defaults.set(0, forKey: "totalLosses")
        defaults.set(0, forKey: "maxWinAmount")
        defaults.removeObject(forKey: "profileImageData")
        
        loadData()
    }

}

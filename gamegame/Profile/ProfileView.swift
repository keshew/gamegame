import SwiftUI

struct ProfileView: View {
    @StateObject var profileModel =  ProfileViewModel()
    @ObservedObject private var soundManager = SoundManager.shared
    @State var coin = UserDefaultsManager.shared.coins
    @ObservedObject private var userDefaults = UserDefaultsManager.shared
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .overlay {
                    VStack {
                        Circle()
                            .fill(.orange)
                            .blur(radius: 100)
                            .shadow(color: .orange, radius: 110)
                            .offset(x: -400)
                        
                        Circle()
                            .fill(.green)
                            .blur(radius: 100)
                            .shadow(color: .green, radius: 110)
                            .offset(x: 350)
                    }
                }
            
            VStack(spacing: 20) {
                HStack {
                    Button(action: {
                        soundManager.toggleMusic()
                    }) {
                        Image("backBtn")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .overlay {
                                Image(systemName: soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            }
                            .frame(width: 40, height: 40)
                    }
                    
                    Spacer()
                    
                    ZStack(alignment: .trailing) {
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 20/255, green: 29/255, blue: 39/255))
                                .frame(width: 95, height: 34)
                                .cornerRadius(12)
                            
                            HStack {
                                Image("coins")
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                
                                Text("\(coin)")
                                    .font(.custom("Gantari-Medium", size: 15))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal,5)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Text("Profile")
                    .font(.custom("ErasITC-Bold", size: 36))
                    .foregroundStyle(.white)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        HStack(spacing: 50) {
                            VStack {
                                Image("pr1")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                
                                Text("\(userDefaults.totalGames)")
                                    .font(.custom("Gantari-Bold", size: 36))
                                    .foregroundStyle(.white)
                                
                                Text("Games Played")
                                    .font(.custom("Gantari-Medium", size: 20))
                                    .foregroundStyle(.white)
                            }
                            
                            VStack {
                                Image("pr2")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                
                                Text("\(userDefaults.totalWins)")
                                    .font(.custom("Gantari-Bold", size: 36))
                                    .foregroundStyle(.white)
                                
                                Text("Total Winning")
                                    .font(.custom("Gantari-Medium", size: 20))
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        HStack(spacing: 50) {
                            VStack {
                                Image("pr3")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                
                                Text("\(userDefaults.winRate, specifier: "%.1f")%")
                                    .font(.custom("Gantari-Bold", size: 36))
                                    .foregroundStyle(.white)
                                
                                Text("Win Rate")
                                    .font(.custom("Gantari-Medium", size: 20))
                                    .foregroundStyle(.white)
                            }
                            
                            VStack {
                                Image("pr4")
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                
                                Text("\(userDefaults.currentStreak)")
                                    .font(.custom("Gantari-Bold", size: 36))
                                    .foregroundStyle(.white)
                                
                                Text("Current Streak")
                                    .font(.custom("Gantari-Medium", size: 20))
                                    .foregroundStyle(.white)
                            }
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}


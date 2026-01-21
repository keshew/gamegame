import SwiftUI

struct CrashGamesView: View {
    @StateObject var crashGamesModel =  CrashGamesViewModel()
    @State var shpwAlert = false
    var game = [Game(image: "cr1", name: "Tide of Fortune"), Game(image: "cr2", name: "Starship Overload"),
                Game(image: "locked", name: "Dragon’s Greed"), Game(image: "locked", name: "Alchemist’s Exp"),
                Game(image: "locked", name: "Volcano Riches"), Game(image: "locked", name: "Time Loop"),
                Game(image: "locked", name: "Oracle’s Vision"), Game(image: "locked", name: "Power Grid"),
                Game(image: "locked", name: "Golden Mint"), Game(image: "locked", name: "Cosmic Rift")]
    @ObservedObject private var soundManager = SoundManager.shared
@State var sl1 = false
@State var sl2 = false
    @State var coin = UserDefaultsManager.shared.coins
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
                
                Text("Slots Games")
                    .font(.custom("ErasITC-Bold", size: 36))
                    .foregroundStyle(.white)
                
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 130, maximum: 170)),
                                        GridItem(.flexible(minimum: 130, maximum: 170))], spacing: 30) {
                        ForEach(0..<10, id: \.self) { index in
                            if index <= 1 {
                                VStack(spacing: 10) {
                                    Button(action: {
                                        switch index {
                                        case 0: sl1 = true
                                            
                                        case 1: sl2 = true
                                        default: sl1 = true
                                        }
                                    }) {
                                        Image("cr\(index+1)")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                    }
                                    
                                    Text(game[index].name)
                                        .font(.custom("Gantari-Medium", size: 16))
                                        .foregroundStyle(.white)
                                        .frame(width: 130)
                                        .multilineTextAlignment(.center)
//                                        .lineLimit(1)
                                }
                                .frame(height: 180)
                            } else {
                                VStack(spacing: 10) {
                                    Button(action: {
                                        shpwAlert = true
                                    }) {
                                        Image("locked")
                                            .resizable()
                                            .frame(width: 140, height: 140)
                                    }
                                    Text(game[index].name)
                                        .font(.custom("Gantari-Medium", size: 16))
                                        .foregroundStyle(.white)
                                        .frame(width: 130)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(height: 180)
                                .alert("Locked", isPresented: $shpwAlert) {
                                    Button("OK") {}
                                }
                            }
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                }
            }
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                coin = UserDefaultsManager.shared.coins
            }
        }
        .fullScreenCover(isPresented: $sl1) {
            TideOfFortuneView()
        }
        .fullScreenCover(isPresented: $sl2) {
            StarshipOverloadView()
        }
    }
}

#Preview {
    CrashGamesView()
}


import SwiftUI

struct Game: Identifiable {
    var id = UUID()
    var image: String
    var name: String
}
struct SlotsView: View {
    @StateObject var slotsModel =  SlotsViewModel()
    @State var shpwAlert = false
    @ObservedObject private var soundManager = SoundManager.shared
    @State var coin = UserDefaultsManager.shared.coins
    var game = [Game(image: "sl1", name: "Time Heist Slots"), Game(image: "sl2", name: "Mythical Zoo "),
                Game(image: "sl3", name: "Pirate Queen’s Fortune"), Game(image: "locked", name: "Gods of Chaos"),
                Game(image: "locked", name: "Street Racing"), Game(image: "locked", name: "Haunted Film"),
                Game(image: "locked", name: "Alchemy Lab"), Game(image: "locked", name: "Sky Kingdoms"),
                Game(image: "locked", name: "AI Takeover "), Game(image: "locked", name: "Royal Scandal")]
    @State var sl1 = false
    @State var sl2 = false
    @State var sl3 = false
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
                            if index <= 2 {
                                VStack(spacing: 10) {
                                    Button(action: {
                                        switch index {
                                        case 0: sl1 = true
                                        case 1: sl2 = true
                                        case 2: sl3 = true
                                        default: sl1 = true
                                        }
                                    }) {
                                        Image("sl\(index+1)")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                    }
                                    
                                    Text(game[index].name)
                                        .font(.custom("Gantari-Medium", size: 16))
                                        .foregroundStyle(.white)
                                        .frame(width: 130)
                                        .multilineTextAlignment(.center)
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
            TimeHeistSlotsView()
        }
        .fullScreenCover(isPresented: $sl2) {
            MythicalZooView()
        }
        .fullScreenCover(isPresented: $sl3) {
            PirateQueensFortuneView()
        }
    }
}

#Preview {
    SlotsView()
}


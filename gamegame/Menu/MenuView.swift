import SwiftUI

struct MenuView: View {
    @StateObject var menuModel =  MenuViewModel()
    @Binding var selectedTab: CustomTabBar.TabType
    @ObservedObject private var soundManager = SoundManager.shared
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
                
                Text("Menu")
                    .font(.custom("ErasITC-Bold", size: 36))
                    .foregroundStyle(.white)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        Button(action: {
                            selectedTab = .Crash
                        }) {
                            Image("slots")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 240)
                        }
                        
                        Button(action: {
                            selectedTab = .Slots
                        }) {
                            Image("crash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 240)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MenuView(selectedTab: .constant(CustomTabBar.TabType.Menu))
}


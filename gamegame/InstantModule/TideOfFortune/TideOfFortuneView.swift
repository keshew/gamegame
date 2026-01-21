import SwiftUI

struct TideOfFortuneView: View {
    @StateObject var viewModel =  TideOfFortuneViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading) {
                Color.black.ignoresSafeArea()
                    .overlay {
                        Image(viewModel.gameResult == .win ? "tideWin" : "bgtide")
                            .resizable()
                            .overlay {
                                if viewModel.showResult {
                                    if viewModel.gameResult == .win {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                                          Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                                            .overlay {
                                                Text("\(Int(Double(viewModel.bet) * viewModel.multiplier))$")
                                                    .font(.custom("Gantari-Bold", size: 63))
                                                    .foregroundStyle(.white)
                                            }
                                            .frame(width: 268, height: 116)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                    }
                
                Image("wave")
                    .resizable()
                    .frame(width: 350 ,height: 650)
                    .rotationEffect(.degrees(viewModel.isFlying ? -15 : 0))
                    .scaleEffect(viewModel.isFlying ? 1.1 : 1.0)
                    .offset(x: viewModel.isFlying ? -50 : 0, y: viewModel.isFlying ? -30 : 0)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.isFlying)
                    .opacity(viewModel.showResult ? 0 : 1)
            }
            .ignoresSafeArea()
            
            VStack(spacing: 50) {
                HStack(spacing: 15) {
                    Button(action: {
                        NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Circle()
                            .fill(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                          Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                Image("backImg2")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .offset(y: 2)
                            }
                            .frame(width: 40, height: 40)
                    }
                    
                    Button(action: {
                        soundManager.toggleMusic()
                    }) {
                        Circle()
                            .fill(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                          Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                Image(systemName: soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            }
                            .frame(width: 40, height: 40)
                    }
                    
                    Text("Tide of Fortune")
                        .font(.custom("Gantari-Medium", size: 22))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                VStack(spacing: 30) {
                    if viewModel.showResult {
                        Image(viewModel.gameResult == .win ? "wintide" : "losetide")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 140)
                            .animation(.easeInOut(duration: 0.5).repeatCount(3), value: viewModel.showResult)
                    } else {
                        Text("x \(viewModel.multiplier, specifier: "%.2f")")
                            .font(.custom("ErasITC-Bold", size: 46))
                            .foregroundStyle(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                                     Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                    }
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .overlay {
                                VStack {
                                    Text("\(viewModel.bet)")
                                        .foregroundStyle(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                                                 Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                                        .font(.custom("Gantari-Bold", size: 32))
                                    
                                    Text("BET")
                                        .foregroundStyle(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                                                 Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                                        .font(.custom("Gantari-Bold", size: 16))
                                }
                            }
                            .cornerRadius(20)
                        
                        
                        HStack {
                            Button(action: {
                                if viewModel.bet >= 100 {
                                    viewModel.bet -= 50
                                }
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                                  Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        Text("-")
                                            .font(.custom("Gantari-Bold", size: 42))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 48, height: 60)
                                    .cornerRadius(20)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                if (viewModel.bet + 50) <= viewModel.coin {
                                    viewModel.bet += 50
                                }
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                                  Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        Text("+")
                                            .font(.custom("Gantari-Bold", size: 42))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 48, height: 60)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .frame(width: 264, height: 62)
                    
                    Button(action: {
                        if viewModel.isFlying {
                            viewModel.withdraw()
                        } else {
                            if viewModel.bet <= viewModel.coin {
                                viewModel.startGame()
                            }
                        }
                    }) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 3/255, green: 88/255, blue: 211/255),
                                                          Color(red: 2/255, green: 45/255, blue: 109/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                Text(viewModel.isFlying ? "WITHDRAW" : "PLACE BET")
                                    .font(.custom("Gantari-Bold", size: 24))
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 200, height: 51)
                            .cornerRadius(20)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    TideOfFortuneView()
}


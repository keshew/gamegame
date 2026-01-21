import SwiftUI

struct MythicalZooView: View {
    @StateObject var viewModel =  MythicalZooViewModel()
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .overlay {
                    Image(viewModel.win > 0  ? "bgwinzoo" : "bgzoo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                }
            
            
            VStack(spacing: 50) {
                HStack(spacing: 15) {
                    Button(action: {
                        NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Circle()
                            .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                          Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
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
                            .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                          Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
                            .overlay {
                                Image(systemName: soundManager.isMusicEnabled ? "speaker.wave.3.fill" : "speaker.fill")
                                    .resizable()
                                    .foregroundStyle(.white)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                            }
                            .frame(width: 40, height: 40)
                    }
                    
                    Text("Mythical Zoo")
                        .font(.custom("Gantari-Medium", size: 22))
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView(showsIndicators: false) {
                    if viewModel.win > 0 {
                        VStack(spacing: 20) {
                            Image("winzoo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350, height: 110)
                            
                            Color.clear.frame(height: 241)
                            
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                              Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    Text("WIN: \(viewModel.win)")
                                        .font(.custom("Gantari-Bold", size: 36))
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 296, height: 76)
                                .cornerRadius(20)
                            
                            Button(action: {
                                viewModel.win = 0
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                                  Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        Text("CLAIM")
                                            .font(.custom("Gantari-Bold", size: 36))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 296, height: 76)
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        VStack(spacing: 50) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color.black,
                                                              Color(red: 217/255, green: 217/255, blue: 217/255).opacity(0.5)], startPoint: .top, endPoint: .bottom))
                                .overlay {
                                    VStack(spacing: 50) {
                                        Rectangle()
                                            .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                                          Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(.white, lineWidth: 3)
                                                    .overlay {
                                                        Text("WIN: \(viewModel.win)")
                                                            .font(.custom("Gantari-Bold", size: 26))
                                                            .foregroundStyle(.white)
                                                    }
                                            }
                                            .frame(height: 62)
                                            .cornerRadius(5)
                                            .padding(.horizontal)
                                        
                                        VStack(spacing: 1) {
                                            ForEach(0..<3, id: \.self) { row in
                                                HStack(spacing: 1) {
                                                    ForEach(0..<5, id: \.self) { col in
                                                        Rectangle()
                                                            .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                                                          Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
                                                            .overlay {
                                                                RoundedRectangle(cornerRadius: 5)
                                                                    .stroke(.white, lineWidth: 2)
                                                                    .overlay {
                                                                        Image(viewModel.slots[row][col])
                                                                            .resizable()
                                                                            .aspectRatio(contentMode: .fit)
                                                                            .frame(width: 45, height: 35)
                                                                            .background(viewModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? .white : Color.black.opacity(0))
                                                                    }
                                                            }
                                                            .frame(width: 50, height: 50)
                                                            .cornerRadius(5)
                                                    }
                                                }
                                            }
                                        }
                                        
                                        ZStack {
                                            Rectangle()
                                                .fill(.white)
                                                .overlay {
                                                    VStack {
                                                        Text("\(viewModel.bet)")
                                                            .foregroundStyle(LinearGradient(colors: [Color(red: 28/255, green: 9/255, blue: 112/255),
                                                                                                     Color(red: 53/255, green: 18/255, blue: 214/255)], startPoint: .leading, endPoint: .trailing))
                                                            .font(.custom("Gantari-Bold", size: 32))
                                                        
                                                        Text("BET")
                                                            .foregroundStyle(LinearGradient(colors: [Color(red: 28/255, green: 9/255, blue: 112/255),
                                                                                                     Color(red: 53/255, green: 18/255, blue: 214/255)], startPoint: .leading, endPoint: .trailing))
                                                            .font(.custom("Gantari-Bold", size: 16))
                                                    }
                                                }
                                                .frame(height: 62)
                                                .cornerRadius(20)
                                            
                                            
                                            HStack {
                                                Button(action: {
                                                    if viewModel.bet >= 100 {
                                                        viewModel.bet -= 50
                                                    }
                                                }) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                                                      Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
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
                                                        .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                                                      Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
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
                                        .padding(.horizontal)
                                    }
                                }
                                .frame(width: 296, height: 421)
                                .cornerRadius(30)
                            
                            Button(action: {
                                if viewModel.coin >= viewModel.bet {
                                    viewModel.spin()
                                }
                            }) {
                                Rectangle()
                                    .fill(LinearGradient(colors: [Color(red: 30/255, green: 180/255, blue: 240/255),
                                                                  Color(red: 112/255, green: 233/255, blue: 248/255)], startPoint: .top, endPoint: .bottom))
                                    .overlay {
                                        Text("SPIN")
                                            .font(.custom("Gantari-Bold", size: 36))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 296, height: 76)
                                    .cornerRadius(20)
                            }
                            .disabled(viewModel.isSpinning)
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    MythicalZooView()
}


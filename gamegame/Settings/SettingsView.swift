import SwiftUI

struct SettingsView: View {
    @StateObject var settingsModel =  SettingsViewModel()
    @State var coin = UserDefaultsManager.shared.coins
    @State private var showResetAlert = false
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
                
                Text("Settings")
                    .font(.custom("ErasITC-Bold", size: 36))
                    .foregroundStyle(.white)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 25) {
                        ZStack(alignment: .leading) {
                            ZStack(alignment: .trailing) {
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 29/255, blue: 39/255))
                                    .frame(height: 93)
                                    .cornerRadius(20)
                                
                                VStack(alignment: .trailing) {
                                    Text("Sound Effect")
                                        .font(.custom("Gantari-Bold", size: 25))
                                        .foregroundStyle(.white)
                                    
                                    Toggle("", isOn: $settingsModel.isSounds)
                                        .toggleStyle(CustomToggleStyle())
                                        .frame(width: 48)
                                }
                                .padding(.horizontal,15)
                            }
                            
                            Image("sound")
                                .resizable()
                                .frame(width: 97, height: 93)
                        }
                        
                        ZStack(alignment: .leading) {
                            ZStack(alignment: .trailing) {
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 29/255, blue: 39/255))
                                    .frame(height: 93)
                                    .cornerRadius(20)
                                
                                VStack(alignment: .trailing) {
                                    Text("Notifications")
                                        .font(.custom("Gantari-Bold", size: 25))
                                        .foregroundStyle(.white)
                                    
                                    Toggle("", isOn: $settingsModel.isNotifOn)
                                        .toggleStyle(CustomToggleStyle())
                                        .frame(width: 48)
                                }
                                .padding(.horizontal,15)
                            }
                            
                            Image("notif")
                                .resizable()
                                .frame(width: 97, height: 93)
                        }
                        
                        ZStack(alignment: .leading) {
                            ZStack(alignment: .trailing) {
                                Rectangle()
                                    .fill(Color(red: 20/255, green: 29/255, blue: 39/255))
                                    .frame(height: 93)
                                    .cornerRadius(20)
                                
                                VStack(alignment: .trailing) {
                                    Text("Vibration")
                                        .font(.custom("Gantari-Bold", size: 25))
                                        .foregroundStyle(.white)
                                    
                                    Toggle("", isOn: $settingsModel.isVib)
                                        .toggleStyle(CustomToggleStyle())
                                        .frame(width: 48)
                                }
                                .padding(.horizontal,15)
                            }
                            
                            Image("vibration")
                                .resizable()
                                .frame(width: 97, height: 93)
                        }
                        
                        Button(action: {
                            
                        }) {
                            ZStack(alignment: .leading) {
                                ZStack(alignment: .trailing) {
                                    Rectangle()
                                        .fill(Color(red: 20/255, green: 29/255, blue: 39/255))
                                        .frame(height: 93)
                                        .cornerRadius(20)
                                    
                                    VStack(alignment: .trailing) {
                                        Text("Support")
                                            .font(.custom("Gantari-Bold", size: 25))
                                            .foregroundStyle(.white)
                                        
                                        Toggle("", isOn: $settingsModel.isSounds)
                                            .toggleStyle(CustomToggleStyle())
                                            .frame(width: 48)
                                            .hidden()
                                    }
                                    .padding(.horizontal,15)
                                }
                                
                                Image("support")
                                    .resizable()
                                    .frame(width: 97, height: 93)
                                
                            }
                        }
                        
                        Button(action: {
                            showResetAlert = true
                        }) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 255/255, green: 13/255, blue: 12/255),
                                                              Color(red: 153/255, green: 9/255, blue: 8/255)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay {
                                    HStack {
                                        Text("Reset progress")
                                            .font(.custom("Gantari-Medium", size: 14))
                                            .foregroundStyle(.white)
                                        
                                        Image(systemName: "arrow.triangle.2.circlepath")
                                            .font(.custom("Gantari-Bold", size: 16))
                                            .foregroundStyle(.white)
                                    }
                                }
                                .frame(width: 171, height: 44)
                                .cornerRadius(30)
                        }
                        .alert("Reset Progress", isPresented: $showResetAlert) {
                            Button("Cancel", role: .cancel) { }
                            Button("Reset All", role: .destructive) {
                                userDefaults.resetStats()
                                coin = UserDefaultsManager.shared.coins
                            }
                        } message: {
                            Text("Are you sure? This will delete all your progress, wins, and coins.")
                        }
                        
                        Color.clear.frame(height: 80)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? Color(red: 32/255, green: 88/255, blue: 65/255) : Color(red: 37/255, green: 43/255, blue: 49/255))
                .frame(width: 48, height: 20)
                .overlay(
                    Circle()
                        .fill(configuration.isOn ? Color(red: 119/255, green: 245/255, blue: 136/255) : Color(red: 90/255, green: 112/255, blue: 131/255))
                        .frame(width: 20, height: 20)
                        .offset(x: configuration.isOn ? 15 : -15)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: CustomTabBar.TabType = .Menu
    @ObservedObject  var soundManager = SoundManager.shared
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if selectedTab == .Menu {
                    MenuView(selectedTab: $selectedTab)
                } else if selectedTab == .Slots {
                    SlotsView()
                } else if selectedTab == .Crash {
                    CrashGamesView()
                } else if selectedTab == .Profile {
                    ProfileView()
                } else if selectedTab == .Settings {
                    SettingsView()
                }
            }
            .frame(maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 0)
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TabBarView()
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Menu
        case Slots
        case Crash
        case Profile
        case Settings
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(colors: [Color(red: 77/255, green: 148/255, blue: 105/255),
                                                  Color(red: 23/255, green: 46/255, blue: 33/255)], startPoint: .leading, endPoint: .trailing))
                    .frame(height: 100)
                    .cornerRadius(50)
                    .padding(.horizontal, UIScreen.main.bounds.width > 700 ? 30 : 10)
                
            }
            
            HStack(spacing: -40) {
                TabBarItem(imageName: "tab1", tab: .Menu, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Slots, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Crash, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab4", tab: .Profile, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab5", tab: .Settings, selectedTab: $selectedTab)
            }
            .padding(.top, -40)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            if tab == selectedTab {
                Circle()
                    .fill(LinearGradient(colors: [Color(red: 0/255, green: 244/255, blue: 96/255),
                                                  Color(red: 0/255, green: 170/255, blue: 68/255)], startPoint: .top, endPoint: .bottom))
                    .overlay {
                        VStack(spacing: 5) {
                            Image(selectedTab == tab ? imageName + "Picked" : imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                            
                            Text("\(tab)")
                                .font(.system(size: 10))
                                .foregroundStyle(Color(red: 2/255, green: 105/255, blue: 18/255))
                        }
                        .offset(y: -1)
                    }
                    .frame(width: 55, height: 55)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
            } else {
                VStack(spacing: 5) {
                    Image(selectedTab == tab ? imageName + "Picked" : imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    
                    Text("\(tab)")
                        .font(.system(size: 10))
                        .foregroundStyle(Color(red: 209/255, green: 214/255, blue: 235/255))
                }
                .frame(maxWidth: .infinity)
                .offset(y: -1)
            }
        }
    }
}

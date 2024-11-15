import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @AppStorage("streak", store: UserDefaults(suiteName: "group.com.alexander.www.CountdownWidget")) var streak = 0
    
    var selectedColor = Color.blue
 
    var body: some View {
        
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                ZStack {
                    
                    let percent = Double(streak) / 50.0
                    
                    Circle()
                        .stroke(.white.opacity(0.1), lineWidth: 20)
                    
                    
                    Circle()
                        .trim(from: 0.01, to: percent)
                        .stroke(selectedColor, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.degrees(-90))
                    
                    VStack{
                        Text("Streak")
                            .font(.system(size: 50))
                        Text(String(streak))
                    }
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                    .contentTransition(.numericText())
                }
                .padding(.horizontal, 50)
                Spacer()
                
                Button(action: {
                    
                    streak += 1
                    
                    // Manually reload widget
                    WidgetCenter.shared.reloadAllTimelines()
                    
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(selectedColor)
                            .frame(height: 40)
                        Text("+1")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                })
                .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ContentView()
}

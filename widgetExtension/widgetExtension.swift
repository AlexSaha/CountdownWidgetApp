//
//  widgetExtension.swift
//  widgetExtension
//
//  Created by Alex Saha on 11/15/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let storageManager = StorageManager()
    
    // Picker when the user adds a widget
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), streak: storageManager.progress())
    }

    // Provides instance in time what the widget should look like
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), streak: storageManager.progress())
        completion(entry)
    }

    // Provides a timeline entry representing a placeholder version of the widget
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        
        // 0 - 4 hours in the future
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, streak: storageManager.progress())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }

}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let streak: Int
}

struct widgetExtensionEntryView : View {
    
    var entry: Provider.Entry
    var storageManager = StorageManager()
    
    var body: some View {
        ZStack {
            
            let percent = Double(storageManager.progress()) / 50.0
            
            Circle()
                .stroke(.white.opacity(0.1), lineWidth: 10)
            
            
            Circle()
                .trim(from: 0, to: percent)
                .stroke(.blue, style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-90))
            
            VStack{
                Text(String(storageManager.progress()))
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .contentTransition(.numericText())
            }
            .foregroundStyle(.black)
            .fontDesign(.rounded)
        }
        .padding()
        .background(Color.black)
        
        Button(intent: LogEntry()) {
            Text("+1")
                .padding(.horizontal)
        }
    }

    
}

struct widgetExtension: Widget {
    let kind: String = "widgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                widgetExtensionEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                widgetExtensionEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .contentMarginsDisabled()
        .configurationDisplayName("Countdown Widget")
        .description("Countdown Widget")
    }
}

#Preview(as: .systemSmall) {
    widgetExtension()
} timeline: {
    SimpleEntry(date: .now, streak: 1)
    SimpleEntry(date: .now, streak: 5)
}

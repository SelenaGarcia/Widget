//
//  firstWidget.swift
//  firstWidget
//
//  Created by Selena García Lobo on 14/12/2022.
//

import WidgetKit
import SwiftUI

struct WeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), degrees: 0, title: "", desc: "", icon: "sparkles")
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        completion(WeatherEntry(date: Date(), degrees: 0, title: "", desc: "", icon: "sparkles"))
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        var entries: [WeatherEntry] = []
        entries.append(WeatherEntry(date: Date().addingTimeInterval(5), degrees: 5, title: "Snow", desc: "you need a coat", icon: "snowflake"))
        entries.append(WeatherEntry(date: Date().addingTimeInterval(8), degrees: 15, title: "Raining", desc: "please use an umbrella, like rihanna", icon: "cloud.moon.bolt"))
        entries.append(WeatherEntry(date: Date().addingTimeInterval(12), degrees: 20, title: "Wind", desc: "be carefull with your hat", icon: "wind"))
        entries.append(WeatherEntry(date: Date().addingTimeInterval(20), degrees: 30, title: "Sunny", desc: "hot, like you", icon: "sun.max"))

        completion(Timeline(entries: entries, policy: .atEnd))
    }
}

struct WeatherEntry: TimelineEntry {
    let date: Date
    let degrees: Int
    let title: String
    let desc: String
    let icon: String

}

struct firstWidgetEntryView : View {
    var entry: WeatherProvider.Entry

    var body: some View {
        VStack{
            Image(systemName: entry.icon)
                .resizable()
                .frame(width: 60, height: 60)
            Text("\(entry.degrees)°C")
                .font(.title2)
                .foregroundColor(.indigo)
            Text(entry.date, style: .time)

        }
    }
}

@main
struct firstWidget: Widget {
    let kind: String = "firstWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            firstWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Sele widget")
        .description("this is a widget with swiftui")
    }
}

struct firstWidget_Previews: PreviewProvider {
    static var previews: some View {
        firstWidgetEntryView(entry: WeatherEntry(date: Date(), degrees: 0, title: "Cold", desc: "Snow", icon: "snowflake" ))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

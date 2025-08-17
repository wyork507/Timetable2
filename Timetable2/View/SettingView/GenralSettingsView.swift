//
//  GenralSettingsView.swift
//  Timetable2
//
//  Created by York Wang on 2025/8/17.
//

import SwiftUI
import SwiftData

struct GenralSettingsView: View {
    @Query(sort: [SortDescriptor(\School.name)], animation: .snappy)
    private var schools: [School]
    @Query(sort: [SortDescriptor(\Timetables.name)], animation: .snappy)
    private var timtables: [Timetables]
    
    @State var settings = UserPreference.General()
    @State var enabledNotification = UserPreference.Notification().isEnabled
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Appearance", content: {
                    Toggle("Dark Mode", isOn: $settings.isEnableDarkMode)
                    NavigationLink {
                        UnderConstruction()
                        //SchoolItemView($schools)
                    } label: {
                        LabeledContent {
                            Text(Locale.current.localizedString(
                                forLanguageCode: settings.language.identifier)!
                            )
                        } label: {
                            Text("Language")
                            Text("Under developing")
                                .font(.caption2)
                        }.frame(height: 38)
                    }.disabled(true)
                })
                Section("Manage") {
                    NavigationLink {
                        UnderConstruction()
                        //SchoolItemView($schools)
                    } label: {
                        LabeledContent {
                            VStack {
                                Text("Total")
                                    .font(.caption)
                                Text("\(schools.count.description)")
                            }.frame(height: 38)
                        } label: {
                            Text("Schools")
                            Text("Tap to edit school list, and manage its schedule.")
                                .font(.caption2)
                        }
                    }
                    NavigationLink {
                        UnderConstruction()
                        //TimetableItemView($timetables)
                    } label: {
                        LabeledContent {
                            VStack {
                                Text("Total")
                                    .font(.caption)
                                Text("\(timtables.count.description)")
                            }.frame(height: 38)
                        } label: {
                            Text("Timetables")
                            Text("Active: \(settings.activedTimetable ?? "Not set yet")")
                                .font(.caption2)
                        }
                    }
                }
                Section("Display") {
                    NavigationLink {
                        DisplayViewSettingView()
                    } label: {
                        LabeledContent {
                            EmptyView()
                        } label: {
                            Text("Viewing")
                            Text("Set present way, and layout.")
                                .font(.caption2)
                        }.frame(height: 38)
                    }
                    NavigationLink {
                        UnderConstruction()
                        //DisplayInfoSettingView()
                    } label: {
                        LabeledContent {
                            EmptyView()
                        } label: {
                            Text("Infomation")
                            Text("Dicide which information to show.")
                                .font(.caption2)
                        }.frame(height: 38)
                    }
                }
                
                Section("Others") {
                    Toggle("Push Notification", isOn: $enabledNotification)
                    NavigationLink {
                        UnderConstruction()
                        //NotificationSettingView()
                    } label: {
                        LabeledContent {
                            EmptyView()
                        } label: {
                            Text("Notification Setting")
                            Text("Include push time, sound, and vibration.")
                                .font(.caption2)
                        }.frame(height: 38)
                    }.disabled(!enabledNotification)
                    NavigationLink {
                        UnderConstruction()
                        //WidgetSettingView()
                    } label: {
                        LabeledContent {
                            EmptyView()
                        } label: {
                            Text("Widget Setting")
                            Text("Include push time, sound, and vibration.")
                                .font(.caption2)
                        }.frame(height: 38)
                    }
                    NavigationLink {
                        AboutThisAppView()
                    } label: {
                        LabeledContent {
                            EmptyView()
                        } label: {
                            Text("About This App")
                            Text("Developed and contact infomation.")
                                .font(.caption2)
                        }.frame(height: 38)
                    }
                }
            }
        }.navigationTitle(Text("General Settings"))
    }
}

#Preview {
    GenralSettingsView()
}

import SwiftUI

struct ContentView: View {
    @State private var selectedAction = "Shutdown"
    @State private var scheduleType = "In"
    @State private var hours: Int = 0
    @State private var minutes: Int = 15
    @State private var scheduledDate = Date()

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header (title + quit button)
            HStack {
                Text("Sleepy")
                    .font(.headline)
                    .fontWeight(.semibold)

                Spacer()

                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.trailing, 4)
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)

            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 4)

            // Pickers
            VStack(spacing: 16) {
                Picker(selection: $selectedAction, label: EmptyView()) {
                    Text("Sleep").tag("Sleep")
                    Text("Restart").tag("Restart")
                    Text("Shutdown").tag("Shutdown")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                Picker(selection: $scheduleType, label: EmptyView()) {
                    Text("After delay").tag("In")
                    Text("At time").tag("At")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            .padding(.top, 8)

            // CONDITIONAL INPUTS (fixed height so layout doesn't move)
            ZStack {
                // “In” fields
                VStack(alignment: .leading, spacing: 8) {
                    if scheduleType == "In" {
                        Text("Schedule a \(selectedAction) in")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.leading, 16)

                        HStack(spacing: 8) {
                            HStack {
                                TextField("0", value: $hours, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 40)
                                    .onChange(of: hours) {
                                        if hours < 0 {
                                            hours = 0
                                        }
                                    }
                                Text("h")
                                    .foregroundColor(.secondary)
                            }

                            HStack {
                                TextField("0", value: $minutes, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 50)
                                    .onChange(of: minutes) {
                                        if minutes < 0 {
                                            minutes = 0
                                        }
                                    }
                                Text("min")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }

                // “At” fields
                VStack(alignment: .leading, spacing: 8) {
                    if scheduleType == "At" {
                        Text("Schedule a \(selectedAction) at")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.leading, 16)

                        DatePicker(
                            "",
                            selection: $scheduledDate,
                            in: Date()...,
                            displayedComponents: [.date, .hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(.horizontal, 16)
                    }
                }
            }
            .frame(height: 80)
            .animation(.easeInOut(duration: 0.2), value: scheduleType)
            .padding(.top, 8)

            // SCHEDULE BUTTON (left-aligned)
            Button("Schedule") {
                // TODO: scheduling logic
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.small)
            .padding(.leading, 16)
            .padding(.top, 4)

            // Divider before upcoming section
            Divider()
                .padding(.horizontal, 16)
                .padding(.top, 8)

            // UPCOMING SECTION
            VStack(alignment: .leading, spacing: 4) {
                Text("Upcoming")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .padding(.leading, 16)

                Text("No scheduled actions")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
            }
            .padding(.top, 4)

            Spacer()
        }
        .frame(width: 280, height: 360)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

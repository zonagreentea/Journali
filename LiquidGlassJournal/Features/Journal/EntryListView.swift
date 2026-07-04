import SwiftUI

struct EntryListView: View {
    @State private var entries: [JournalEntry] = [JournalEntry(title: "Welcome", text: "Tap + to create your first entry.")]
    @State private var showingEditor = false

    var body: some View {
        NavigationView {
            List {
                ForEach(entries) { entry in
                    NavigationLink(destination: EntryEditorView(entry: binding(for: entry))) {
                        VStack(alignment: .leading) {
                            Text(entry.title.isEmpty ? entry.text.prefix(40).description : entry.title)
                                .font(.headline)
                            Text(entry.timestamp, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Journali")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingEditor.toggle() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingEditor) {
                EntryEditorView(entry: .constant(JournalEntry()))
            }
        }
    }

    func binding(for entry: JournalEntry) -> Binding<JournalEntry> {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else {
            return .constant(entry)
        }
        return $entries[index]
    }

    func delete(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }
}

struct EntryEditorView: View {
    @Binding var entry: JournalEntry
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $entry.title)
                TextEditor(text: $entry.text)
                    .frame(minHeight: 200)
            }
            .navigationTitle("Edit Entry")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        // Placeholder: persist to Core Data or LoT
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { presentationMode.wrappedValue.dismiss() }
                }
            }
        }
    }
}

// SwiftUI previews
#if DEBUG
struct EntryListView_Previews: PreviewProvider {
    static var previews: some View {
        EntryListView()
    }
}
#endif

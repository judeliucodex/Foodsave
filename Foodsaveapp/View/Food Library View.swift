// Food library page view

import SwiftUI

struct FoodLibraryView: View {
    @State private var searchText = ""

    var groupedItems: [FoodCategory: [FoodItem]] {
        let filtered = searchText.isEmpty
            ? FoodItem.sampleData
            : FoodItem.sampleData.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.details.localizedCaseInsensitiveContains(searchText)
            }
        return Dictionary(grouping: filtered, by: { $0.category })
    }

    var body: some View {
        List {
            ForEach(FoodCategory.allCases.filter { $0 != .all }, id: \.self) { category in
                if let items = groupedItems[category], !items.isEmpty {
                    Section(header: Text(category.rawValue)) {
                        ForEach(items) { item in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(item.emoji)
                                        .font(.title2)
                                    Text(item.name)
                                        .font(.headline)
                                    Spacer()
                                    Text(item.isKeep ? "Keep" : "Dispose")
                                        .font(.caption.bold())
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            (item.isKeep ? AppTheme.greenGlow : AppTheme.orangeAccent).opacity(0.2)
                                        )
                                        .foregroundStyle(item.isKeep ? AppTheme.greenGlow : AppTheme.orangeAccent)
                                        .clipShape(Capsule())
                                }
                                Text(item.details)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                Text(item.explanation)
                                    .font(.footnote)
                                    .foregroundStyle(.secondary)
                                    .padding(.top, 2)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
        }
        .navigationTitle("Food Library")
        .searchable(text: $searchText, prompt: "Search foods...")
    }
}

//Mistake records



import Foundation

struct MistakeRecord: Identifiable {
    let id = UUID()
    let item: FoodItem
    let userChoseKeep: Bool
}

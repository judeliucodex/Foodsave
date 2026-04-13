//Food item json list



import Foundation

enum FoodCategory: String, CaseIterable, Identifiable, Codable {
    case all = "All Foods"
    case produce = "Produce"
    case dairy = "Dairy & Eggs"
    case meat = "Meat & Seafood"
    case pantry = "Pantry"
    case leftovers = "Leftovers"
    
    var id: String { self.rawValue }
    var icon: String {
        switch self {
        case .all: return "basket.fill"
        case .produce: return "leaf.fill"
        case .dairy: return "drop.fill"
        case .meat: return "flame.fill"
        case .pantry: return "cabinet.fill"
        case .leftovers: return "takeoutbox.fill"
        }
    }
}

struct FoodItem: Identifiable, Codable {
    let id = UUID()
    let category: FoodCategory
    let emoji: String
    let name: String
    let details: String
    let conditionHint: String
    let isKeep: Bool
    let explanation: String
}

extension FoodItem {
    static let sampleData: [FoodItem] = [
        // MARK: Produce
        FoodItem(category: .produce, emoji: "🥬", name: "Lettuce", details: "Slightly wilted", conditionHint: "Wilting is moisture loss, not bacterial rot.", isKeep: true, explanation: "Wilted greens are safe. Revive them in ice water! Toss only if slimy."),
        FoodItem(category: .produce, emoji: "🥬", name: "Lettuce", details: "Brown mush & slime", conditionHint: "Slime is a byproduct of bacterial cell breakdown.", isKeep: false, explanation: "Slime clearly indicates rot and bacterial growth. Unsafe to eat."),
        FoodItem(category: .produce, emoji: "🍌", name: "Banana", details: "Heavy brown spots", conditionHint: "Enzymes convert starches into sugars as it ages.", isKeep: true, explanation: "Brown spots mean it's extra sweet and perfect for baking, not spoiled."),
        FoodItem(category: .produce, emoji: "🍌", name: "Banana", details: "Black peel, white inside", conditionHint: "Cold temperatures turn the peel black rapidly.", isKeep: true, explanation: "Fridge shock turns the peel black, but the flesh inside is perfectly ripe and safe."),
        FoodItem(category: .produce, emoji: "🍌", name: "Banana", details: "Surrounded by fruit flies", conditionHint: "Fruit flies carry bacteria from garbage to food.", isKeep: false, explanation: "If broken skin is exposed to fruit flies, it can harbor dangerous bacteria. Discard."),
        FoodItem(category: .produce, emoji: "🍎", name: "Apple", details: "Small soft bruise", conditionHint: "A bruise is physical damage from dropping.", isKeep: true, explanation: "Bruises are cosmetic. Cut away the soft spot; the rest is perfectly safe."),
        FoodItem(category: .produce, emoji: "🍎", name: "Apple", details: "Wrinkled skin", conditionHint: "Apples lose moisture through their skin over time.", isKeep: true, explanation: "Wrinkled apples are just dehydrated. Great for making applesauce or pie!"),
        FoodItem(category: .produce, emoji: "🥔", name: "Potato", details: "Sprouting eyes", conditionHint: "The potato is trying to grow a new plant.", isKeep: true, explanation: "Just cut the sprouts off deeply! The rest of the firm potato is safe to cook."),
        FoodItem(category: .produce, emoji: "🥔", name: "Potato", details: "Green tinted skin", conditionHint: "Light exposure produces chlorophyll and solanine.", isKeep: false, explanation: "Green skin contains solanine, a natural toxin that causes illness. Discard heavily green potatoes."),
        FoodItem(category: .produce, emoji: "🥔", name: "Potato", details: "Soft and shriveled", conditionHint: "Severe dehydration and cellular breakdown.", isKeep: false, explanation: "Once potatoes turn soft, mushy, and deeply wrinkled, they are rotting and unsafe."),
        FoodItem(category: .produce, emoji: "🍓", name: "Strawberries", details: "One moldy berry in box", conditionHint: "Mold spreads through contact and moisture.", isKeep: true, explanation: "Discard the fuzzy one and immediately wash the rest. You don't need to throw away the whole box!"),
        FoodItem(category: .produce, emoji: "🍓", name: "Strawberries", details: "Leaking dark juice at bottom", conditionHint: "Cell walls are collapsing, inviting rapid mold.", isKeep: false, explanation: "Fermenting, leaky berries at room temp are a breeding ground for bacteria and mold."),
        FoodItem(category: .produce, emoji: "🥕", name: "Carrots", details: "Bendy and rubbery", conditionHint: "Root vegetables rely on water for structure.", isKeep: true, explanation: "Floppy carrots just lost water! Soak them in an ice bath for an hour to make them crisp again."),
        FoodItem(category: .produce, emoji: "🥕", name: "Carrots", details: "White blush on surface", conditionHint: "Known as 'white blush', this is just dehydration.", isKeep: true, explanation: "The white film is just dried out skin. Wash and peel them, and they are perfect."),
        FoodItem(category: .produce, emoji: "🧅", name: "Onion", details: "Sprouting green shoot", conditionHint: "The bulb is acting as a seed for a new plant.", isKeep: true, explanation: "Safe to eat! The green sprout is edible (like a scallion), but the onion may taste slightly bitter."),
        FoodItem(category: .produce, emoji: "🧅", name: "Onion", details: "Black powder on skin", conditionHint: "Aspergillus niger - a common harmless soil fungus.", isKeep: true, explanation: "Just rinse it off and peel the outer layers. The inside of the onion is perfectly fine!"),
        FoodItem(category: .produce, emoji: "🧄", name: "Garlic", details: "Green core inside clove", conditionHint: "The garlic is germinating due to age or light.", isKeep: true, explanation: "Completely safe. Cut out the green core if you want, as it can taste slightly bitter."),
        FoodItem(category: .produce, emoji: "🥑", name: "Avocado", details: "Brown streaks in flesh", conditionHint: "Vascular browning from cold temperature shock.", isKeep: true, explanation: "Safe to eat! It's just temperature damage. Cut out the brown strings if you dislike the texture."),
        FoodItem(category: .produce, emoji: "🥑", name: "Avocado", details: "Black mushy flesh", conditionHint: "Oxygen exposure and enzymatic rot.", isKeep: false, explanation: "Mushy, black flesh that smells sour means the fats have gone rancid and it's rotting."),
        FoodItem(category: .produce, emoji: "🍅", name: "Tomato", details: "Slightly wrinkled skin", conditionHint: "Moisture evaporation from the fruit.", isKeep: true, explanation: "Wrinkled tomatoes are safe and actually have a highly concentrated, sweet flavor for sauces!"),
        FoodItem(category: .produce, emoji: "🍅", name: "Tomato", details: "Leaking cloudy fluid", conditionHint: "Bacterial breakdown of the internal structure.", isKeep: false, explanation: "Cloudy, sour-smelling fluid means the tomato is rotting from the inside out."),
        FoodItem(category: .produce, emoji: "🥒", name: "Cucumber", details: "Soft, translucent ends", conditionHint: "Enzymatic breakdown starting at the tips.", isKeep: false, explanation: "Cucumbers spoil rapidly once the ends go mushy. It will likely taste bitter and unsafe."),
        FoodItem(category: .produce, emoji: "🥬", name: "Spinach", details: "Yellowing leaves", conditionHint: "Chlorophyll breakdown due to aging.", isKeep: true, explanation: "Yellow leaves have lost nutrients but are generally safe if they aren't slimy. Best used cooked."),
        FoodItem(category: .produce, emoji: "🍄", name: "Mushroom", details: "Dark, open gills", conditionHint: "The mushroom cap has fully matured.", isKeep: true, explanation: "Dark gills just mean an older mushroom. As long as it is dry and firm, it is great for cooking!"),
        FoodItem(category: .produce, emoji: "🍄", name: "Mushroom", details: "Slimy sticky surface", conditionHint: "Bacterial breakdown of the fungi's protein.", isKeep: false, explanation: "Slimy mushrooms are actively rotting and harbor bacteria. Throw them out immediately."),
        FoodItem(category: .produce, emoji: "🍋", name: "Lemon", details: "Rock hard rind", conditionHint: "Complete dehydration of the citrus skin.", isKeep: true, explanation: "You can still zest the skin or microwave it for 15 seconds to extract the remaining juice!"),
        FoodItem(category: .produce, emoji: "🍋", name: "Lemon", details: "Blue/Green powder mold", conditionHint: "Penicillium mold feeds on citrus acid.", isKeep: false, explanation: "Citrus mold roots spread deeply into the juicy flesh. Discard the whole fruit."),
        FoodItem(category: .produce, emoji: "🫑", name: "Bell Pepper", details: "Wrinkled skin", conditionHint: "Water loss from sitting in the fridge.", isKeep: true, explanation: "Safe to eat! It just lost its crunch. Perfect for slicing up and tossing into a stir-fry."),
        FoodItem(category: .produce, emoji: "🍉", name: "Watermelon", details: "Smells sour/fizzy", conditionHint: "Fermentation from wild yeast and bacteria.", isKeep: false, explanation: "Fizzy or sour melon is fermenting and will make you sick. Discard immediately."),
        FoodItem(category: .produce, emoji: "🌿", name: "Celery", details: "Limp and bendy", conditionHint: "Loss of turgor pressure in the plant cells.", isKeep: true, explanation: "Safe! Cut off the base and stand them in a glass of water in the fridge to regain their crunch."),

        // MARK: Dairy & Eggs
        FoodItem(category: .dairy, emoji: "🥛", name: "Milk", details: "Use By: 1 day ago", conditionHint: "Use By dates are strict safety deadlines.", isKeep: false, explanation: "'Use By' means a safety risk after the date. Err on the side of caution with pasteurized dairy."),
        FoodItem(category: .dairy, emoji: "🥛", name: "Milk", details: "Best Before: 5 days ago", conditionHint: "Best Before relates to peak flavor, not safety.", isKeep: true, explanation: "'Best Before' is just quality. If it smells fine and doesn't clump in hot coffee, it's safe."),
        FoodItem(category: .dairy, emoji: "🥛", name: "Milk", details: "Lumpy texture", conditionHint: "Lactic acid bacteria are curdling the milk proteins.", isKeep: false, explanation: "Chunks or lumps mean bacteria have soured and curdled the milk. Do not drink."),
        FoodItem(category: .dairy, emoji: "🧀", name: "Parmesan", details: "White mold spot", conditionHint: "Hard cheeses have low moisture, stopping mold roots.", isKeep: true, explanation: "Cut 1-inch around the mold on hard cheeses. The rest is completely safe!"),
        FoodItem(category: .dairy, emoji: "🧀", name: "Cheddar", details: "Sweaty / Oily surface", conditionHint: "Butterfat separating at room temperature.", isKeep: true, explanation: "Sweating cheese is totally safe. It just got a little warm and released some oil."),
        FoodItem(category: .dairy, emoji: "🧀", name: "Cream Cheese", details: "Small mold spot", conditionHint: "Soft foods allow mold roots to spread invisibly.", isKeep: false, explanation: "Mold roots spread rapidly in high-moisture, soft foods. Discard the whole tub immediately."),
        FoodItem(category: .dairy, emoji: "🧀", name: "Cream Cheese", details: "Watery liquid on top", conditionHint: "Whey separation from the curds.", isKeep: true, explanation: "This is just harmless whey! Pour it off or stir it back in. Safe to eat."),
        FoodItem(category: .dairy, emoji: "🧀", name: "Blue Cheese", details: "Smells like ammonia", conditionHint: "Over-ripening of the penicillium roqueforti mold.", isKeep: false, explanation: "While blue cheese is moldy by nature, a harsh ammonia chemical smell means it has spoiled."),
        FoodItem(category: .dairy, emoji: "🧈", name: "Butter", details: "Dark yellow translucent outer layer", conditionHint: "Oxidation and dehydration of the outer fat layer.", isKeep: true, explanation: "The outside just oxidized. Scrape off the dark yellow layer; the inside butter is perfectly fresh!"),
        FoodItem(category: .dairy, emoji: "🧈", name: "Butter", details: "Smells rancid/sour", conditionHint: "Butterfat has spoiled due to heat or age.", isKeep: false, explanation: "Rancid butter will ruin the taste of your food and can cause an upset stomach. Toss it."),
        FoodItem(category: .dairy, emoji: "🥣", name: "Yogurt", details: "Watery liquid on top", conditionHint: "This is just whey protein separation.", isKeep: true, explanation: "That's just whey protein separating! Stir it back in. It is completely safe and nutritious."),
        FoodItem(category: .dairy, emoji: "🥣", name: "Yogurt", details: "Pink or Red ring around edge", conditionHint: "Serratia marcescens, a dangerous airborne bacteria.", isKeep: false, explanation: "Pink/red discoloration in dairy is a toxic bacteria, not normal mold. Throw it away immediately."),
        FoodItem(category: .dairy, emoji: "🥚", name: "Raw Eggs", details: "Floats to the top of water", conditionHint: "Eggshells are porous. Gas builds up inside as they rot.", isKeep: false, explanation: "A floating egg has too much gas built up, indicating it has spoiled. A fresh egg sinks."),
        FoodItem(category: .dairy, emoji: "🥚", name: "Raw Eggs", details: "Sinks but stands upright", conditionHint: "Air cell has grown, but not enough to float.", isKeep: true, explanation: "It's an older egg, but completely safe to eat! Great for hard-boiling because they peel easier."),
        FoodItem(category: .dairy, emoji: "🥚", name: "Raw Eggs", details: "Cracked shell in carton", conditionHint: "The protective bloom barrier is broken.", isKeep: false, explanation: "Bacteria like Salmonella can easily enter through a cracked shell. Do not risk it."),
        FoodItem(category: .dairy, emoji: "🥚", name: "Raw Eggs", details: "Cloudy egg white when cracked", conditionHint: "High carbon dioxide levels in a very fresh egg.", isKeep: true, explanation: "A cloudy white actually indicates the egg is incredibly fresh! Totally safe."),
        FoodItem(category: .dairy, emoji: "🥚", name: "Raw Eggs", details: "Tiny blood spot on yolk", conditionHint: "A ruptured blood vessel during egg formation.", isKeep: true, explanation: "Blood spots are natural and safe. You can scrape it off with a spoon if it bothers you."),
        FoodItem(category: .dairy, emoji: "🥛", name: "Heavy Cream", details: "Solid chunks when poured", conditionHint: "The butterfat has separated from the liquid.", isKeep: false, explanation: "If it's chunky but not whipped, the cream has spoiled and curdled. Discard."),
        FoodItem(category: .dairy, emoji: "🥣", name: "Sour Cream", details: "Watery pool in the middle", conditionHint: "Natural whey separation.", isKeep: true, explanation: "Just like yogurt, this is natural whey separation. Stir it up and enjoy!"),
        FoodItem(category: .dairy, emoji: "🧀", name: "Shredded Cheese", details: "Clumped together", conditionHint: "Moisture and anti-caking agents wearing off.", isKeep: true, explanation: "Clumps are normal as long as there is no mold. Just break it apart with your hands."),
        FoodItem(category: .dairy, emoji: "🧀", name: "String Cheese", details: "Hard and dark yellow", conditionHint: "The plastic wrapper had a micro-tear, dehydrating it.", isKeep: false, explanation: "Dehydrated cheese sticks exposed to fridge air can harbor bacteria. Better to toss."),
        FoodItem(category: .dairy, emoji: "🥛", name: "Frozen Milk", details: "Thawed, looks yellow and separated", conditionHint: "Freezing separates the fat and water content.", isKeep: true, explanation: "Frozen milk separates! Shake it vigorously to re-emulsify the fats before drinking."),

        // MARK: Meat & Seafood
        FoodItem(category: .meat, emoji: "🍗", name: "Raw Chicken", details: "Use By: Today", conditionHint: "The final day of guaranteed safety if refrigerated.", isKeep: true, explanation: "Safe to consume on the 'Use By' date. Ensure you cook it to 165°F (74°C)."),
        FoodItem(category: .meat, emoji: "🍗", name: "Raw Chicken", details: "Slimy, sticky surface", conditionHint: "Bacterial growth produces a biofilm slime.", isKeep: false, explanation: "Chicken should be damp, not sticky or slimy. Slime means dangerous bacterial growth."),
        FoodItem(category: .meat, emoji: "🍗", name: "Raw Chicken", details: "Smells like sulfur/eggs", conditionHint: "Salmonella and spoilage bacteria emit sulfur gas.", isKeep: false, explanation: "A bad smell is the #1 indicator of spoiled poultry. Throw it away immediately."),
        FoodItem(category: .meat, emoji: "🍗", name: "Raw Chicken", details: "White dry spots (Freezer Burn)", conditionHint: "Moisture evaporated from the surface in the freezer.", isKeep: true, explanation: "Freezer burn affects taste and texture, but it is technically safe to eat once cooked."),
        FoodItem(category: .meat, emoji: "🥩", name: "Ground Beef", details: "Brown/Grey in the middle", conditionHint: "Lack of oxygen exposure to the internal meat.", isKeep: true, explanation: "Beef needs oxygen to stay red! Brown inside is totally normal and safe. Cook thoroughly."),
        FoodItem(category: .meat, emoji: "🥩", name: "Ground Beef", details: "Smells sour/ammonia", conditionHint: "Gases released by multiplying spoilage bacteria.", isKeep: false, explanation: "An off smell is a clear sign of dangerous bacterial growth. Discard immediately."),
        FoodItem(category: .meat, emoji: "🥩", name: "Ground Beef", details: "Sticky and tacky to touch", conditionHint: "High bacterial load breaking down proteins.", isKeep: false, explanation: "Spoiled ground meat gets sticky. Don't risk food poisoning—toss it."),
        FoodItem(category: .meat, emoji: "🥩", name: "Steak", details: "Iridescent rainbow sheen", conditionHint: "Light refracting off muscle fibers and iron.", isKeep: true, explanation: "A rainbow sheen on sliced meat is just an optical illusion from iron, not spoilage! Safe."),
        FoodItem(category: .meat, emoji: "🥩", name: "Steak", details: "Grey surface, smells fresh", conditionHint: "Oxidation occurs when meat sits in the fridge.", isKeep: true, explanation: "Grey/brown tints are normal oxygen exposure. As long as it smells fresh, it's safe."),
        FoodItem(category: .meat, emoji: "🐟", name: "Raw Fish", details: "Strong 'fishy' or ammonia smell", conditionHint: "Trimethylamine breaking down into ammonia.", isKeep: false, explanation: "Fresh fish smells like the ocean. A pungent, sour, or ammonia smell means it's rotting."),
        FoodItem(category: .meat, emoji: "🐟", name: "Raw Fish", details: "Cloudy, sunken eyes", conditionHint: "Dehydration and decay in a whole fish.", isKeep: false, explanation: "Fresh whole fish have clear, plump eyes. Cloudy, sunken eyes indicate it is old and unsafe."),
        FoodItem(category: .meat, emoji: "🐟", name: "Salmon", details: "Milky white slime", conditionHint: "Biofilm from rapid spoilage bacteria.", isKeep: false, explanation: "Any thick, milky slime on fish means it is unsafe to eat. Discard."),
        FoodItem(category: .meat, emoji: "🍤", name: "Raw Shrimp", details: "Smells like bleach/ammonia", conditionHint: "Chemical breakdown of proteins.", isKeep: false, explanation: "Shrimp should smell neutral or salty. An ammonia/bleach smell means they have spoiled."),
        FoodItem(category: .meat, emoji: "🍤", name: "Raw Shrimp", details: "Pink shells before cooking", conditionHint: "Shrimp turn pink when exposed to heat or acid.", isKeep: false, explanation: "Unless bought pre-cooked, raw shrimp turning pink means they were exposed to unsafe heat."),
        FoodItem(category: .meat, emoji: "🦪", name: "Mussels / Clams", details: "Shell is open before cooking", conditionHint: "Live shellfish close their shells when tapped.", isKeep: false, explanation: "If it doesn't close when tapped, the shellfish is dead and highly toxic. Throw it out."),
        FoodItem(category: .meat, emoji: "🥓", name: "Deli Turkey", details: "Slightly slimy texture", conditionHint: "Listeria and other bacteria multiply even in fridges.", isKeep: false, explanation: "Slimy deli meat is a major risk for Listeria. Do not rinse it; throw it away."),
        FoodItem(category: .meat, emoji: "🥓", name: "Deli Ham", details: "Use By date passed by 3 days", conditionHint: "Deli meats are highly perishable and prone to Listeria.", isKeep: false, explanation: "Never mess around with expired deli meat. The risk of foodborne illness is too high."),
        FoodItem(category: .meat, emoji: "🍖", name: "Ground Pork", details: "Pale grey and sticky", conditionHint: "Bacterial breakdown of pork fat and protein.", isKeep: false, explanation: "Sticky, grey pork has gone bad. Discard it immediately."),
        FoodItem(category: .meat, emoji: "🍖", name: "Pork Chops", details: "Sitting in bloody liquid", conditionHint: "Myoglobin purging from the meat fibers.", isKeep: true, explanation: "The red liquid is just water and myoglobin protein, not blood! Pat dry and cook safely."),
        FoodItem(category: .meat, emoji: "🍗", name: "Cooked Chicken", details: "Pink meat near the bone", conditionHint: "Hemoglobin in young chickens reacts to heat.", isKeep: true, explanation: "As long as a thermometer reads 165°F (74°C), pink meat near the bone is totally safe!"),

        // MARK: Pantry
        FoodItem(category: .pantry, emoji: "🍯", name: "Honey", details: "Crystallized & rock solid", conditionHint: "Glucose naturally separates from water over time.", isKeep: true, explanation: "Honey NEVER expires! Just place the jar in a bowl of warm water and it will turn liquid again."),
        FoodItem(category: .pantry, emoji: "🥫", name: "Canned Beans", details: "Can is bulging outwards", conditionHint: "Gas buildup inside a sealed vacuum.", isKeep: false, explanation: "A bulging can is a major warning sign of Botulism, a deadly bacteria. Throw it away immediately."),
        FoodItem(category: .pantry, emoji: "🥫", name: "Canned Corn", details: "Small dent on the side", conditionHint: "The seal and seams are fully intact.", isKeep: true, explanation: "As long as the dent isn't on a seam and the can isn't leaking, the food inside is completely sterile."),
        FoodItem(category: .pantry, emoji: "🥫", name: "Canned Soup", details: "Dent on the top seam", conditionHint: "A broken seam compromises the vacuum seal.", isKeep: false, explanation: "Dents on the seam let invisible bacteria into the can. It is unsafe to eat."),
        FoodItem(category: .pantry, emoji: "🥫", name: "Canned Tuna", details: "Expired 1 year ago", conditionHint: "Canning is a sterilization process.", isKeep: true, explanation: "Canned goods can last years past their date if the can is undamaged. It just might be mushy."),
        FoodItem(category: .pantry, emoji: "🍞", name: "Bread", details: "Hard & Stale", conditionHint: "Moisture has evaporated from the starches.", isKeep: true, explanation: "Stale bread is perfectly safe! Turn it into croutons, breadcrumbs, or french toast."),
        FoodItem(category: .pantry, emoji: "🍞", name: "Bread", details: "Tiny green fuzzy spot", conditionHint: "Bread is extremely porous, allowing deep mold roots.", isKeep: false, explanation: "Mold roots easily penetrate soft, porous bread. If you see one spot, the whole loaf is compromised."),
        FoodItem(category: .pantry, emoji: "🥜", name: "Peanut Butter", details: "Oil separated on top", conditionHint: "Natural peanut oils separate at room temperature.", isKeep: true, explanation: "Totally natural! Just stir the oil back in thoroughly before using."),
        FoodItem(category: .pantry, emoji: "🥜", name: "Peanut Butter", details: "Smells bitter and soapy", conditionHint: "Peanut oils go rancid when exposed to heat/oxygen.", isKeep: false, explanation: "Rancid oils won't necessarily kill you, but they taste terrible and can cause stomach cramps."),
        FoodItem(category: .pantry, emoji: "🍾", name: "Olive Oil", details: "Smells like crayons or putty", conditionHint: "Light and heat degrade the fragile fats.", isKeep: false, explanation: "Oil that smells like crayons is heavily rancid. Discard it."),
        FoodItem(category: .pantry, emoji: "🧂", name: "Brown Sugar", details: "Rock hard block", conditionHint: "Molasses moisture evaporated.", isKeep: true, explanation: "Sugar never goes bad! Microwave it with a damp paper towel for 20 seconds to soften it."),
        FoodItem(category: .pantry, emoji: "🍫", name: "White Chocolate", details: "Chalky white film", conditionHint: "Cocoa butter separating due to temperature changes.", isKeep: true, explanation: "This is 'chocolate bloom'. It looks weird but is 100% safe to eat or melt down!"),
        FoodItem(category: .pantry, emoji: "🍫", name: "Dark Chocolate", details: "White spots on surface", conditionHint: "Sugar or fat blooming from temperature shock.", isKeep: true, explanation: "Safe! It's just sugar or fat bloom. It won't hurt you at all."),
        FoodItem(category: .pantry, emoji: "🌶", name: "Spices", details: "Expired 2 years ago", conditionHint: "Dried spices contain zero moisture for bacteria.", isKeep: true, explanation: "Spices never become unsafe. They just lose their flavor and potency over time."),
        FoodItem(category: .pantry, emoji: "🌾", name: "Flour", details: "Smells like play-doh", conditionHint: "The trace fats in the wheat have oxidized.", isKeep: false, explanation: "Rancid flour will make your baked goods taste sour and chemical. Buy a fresh bag."),
        FoodItem(category: .pantry, emoji: "🌾", name: "Flour", details: "Tiny moving specs", conditionHint: "Pantry weevils hatched from microscopic eggs.", isKeep: false, explanation: "Weevils! Throw out the flour and check all other dry goods in your pantry immediately."),
        FoodItem(category: .pantry, emoji: "🥣", name: "Cereal", details: "Stale and chewy", conditionHint: "Absorbed ambient humidity from the air.", isKeep: true, explanation: "Stale cereal is safe. You can bake it at 250°F for 5 minutes to restore the crunch!"),
        FoodItem(category: .pantry, emoji: "🥔", name: "Potato Chips", details: "Stale, expired 3 months ago", conditionHint: "Oils going stale and starches absorbing moisture.", isKeep: true, explanation: "They might not taste great, but stale chips are perfectly safe to eat."),
        FoodItem(category: .pantry, emoji: "🍓", name: "Jar of Jam", details: "Watery on top", conditionHint: "Syneresis: liquid weeping from the fruit pectin.", isKeep: true, explanation: "Just give it a stir! It is perfectly safe."),
        FoodItem(category: .pantry, emoji: "🍓", name: "Jar of Jam", details: "Fuzzy mold on top", conditionHint: "Mold feeding on the sugars despite high acidity.", isKeep: false, explanation: "Mycotoxins from mold can spread through the watery jam. Throw the whole jar away."),
        FoodItem(category: .pantry, emoji: "🍾", name: "Soy Sauce", details: "Expired 1 year ago", conditionHint: "High sodium content prevents bacterial growth.", isKeep: true, explanation: "Soy sauce is heavily fermented and salted. It is safe basically indefinitely!"),
        FoodItem(category: .pantry, emoji: "🍁", name: "Maple Syrup", details: "Thin layer of mold on top", conditionHint: "Real maple syrup can grow harmless xerophilic mold.", isKeep: true, explanation: "Real syrup mold is safe! Skim it off, boil the syrup, and pour into a clean jar."),
        FoodItem(category: .pantry, emoji: "☕️", name: "Coffee Beans", details: "Expired 1 year ago", conditionHint: "Oils dry out, losing flavor.", isKeep: true, explanation: "Old coffee is completely safe. It just won't taste as robust or fresh as a new bag."),
        FoodItem(category: .pantry, emoji: "🥫", name: "Jar of Pasta Sauce", details: "Safety button is popped up", conditionHint: "The vacuum seal has been broken.", isKeep: false, explanation: "If the safety button clicks before you open it, air and bacteria got inside. Discard!"),
        FoodItem(category: .pantry, emoji: "🧂", name: "Salt", details: "Clumped into a hard rock", conditionHint: "Absorbed moisture from the air.", isKeep: true, explanation: "Salt literally cannot expire. Break the clumps up with a fork!"),

        // MARK: Leftovers
        FoodItem(category: .leftovers, emoji: "🍕", name: "Pizza", details: "Left on counter overnight", conditionHint: "Room temperature is the 'Danger Zone' for bacteria.", isKeep: false, explanation: "Perishable food left at room temp for over 2 hours grows rapid bacteria. Throw it out."),
        FoodItem(category: .leftovers, emoji: "🍕", name: "Pizza", details: "In fridge for 4 days", conditionHint: "Cold temperatures slow down bacterial growth.", isKeep: true, explanation: "Fridge pizza is generally safe for up to 4 days. Reheat it well!"),
        FoodItem(category: .leftovers, emoji: "🍚", name: "Cooked Rice", details: "Left on counter for 5 hours", conditionHint: "Bacillus cereus spores survive cooking and multiply.", isKeep: false, explanation: "Rice grows toxic Bacillus cereus rapidly at room temp. NEVER eat rice left out overnight."),
        FoodItem(category: .leftovers, emoji: "🍚", name: "Cooked Rice", details: "In fridge for 3 days", conditionHint: "Cold storage halts spore multiplication.", isKeep: true, explanation: "Properly refrigerated rice is safe for 3-4 days. Add a splash of water and microwave."),
        FoodItem(category: .leftovers, emoji: "🍝", name: "Cooked Pasta", details: "In fridge for 1 week", conditionHint: "Starches breakdown and grow mold/bacteria.", isKeep: false, explanation: "A week is too long for cooked pasta. It is likely growing unseen mold or bacteria."),
        FoodItem(category: .leftovers, emoji: "🍝", name: "Cooked Pasta", details: "Slightly slimy", conditionHint: "Bacterial biofilm forming on the starches.", isKeep: false, explanation: "Slime on leftovers means bacteria have taken over. Discard immediately."),
        FoodItem(category: .leftovers, emoji: "🍗", name: "Frozen Chicken", details: "Defrosted on the counter", conditionHint: "The outside reaches room temp while inside is frozen.", isKeep: false, explanation: "Defrosting meat on the counter allows the outside to reach dangerous bacterial temperatures."),
        FoodItem(category: .leftovers, emoji: "🍗", name: "Frozen Chicken", details: "Defrosted in the fridge", conditionHint: "Controlled, cold temperature thawing.", isKeep: true, explanation: "This is the safest way to thaw meat! It keeps the entire piece out of the Danger Zone."),
        FoodItem(category: .leftovers, emoji: "🥡", name: "Takeout Soup", details: "Container puffed up in fridge", conditionHint: "Bacteria producing gas as they multiply.", isKeep: false, explanation: "A puffy container means bacteria are fermenting and releasing gas. Throw it away unopened."),
        FoodItem(category: .leftovers, emoji: "🥡", name: "Takeout Soup", details: "In fridge for 3 days", conditionHint: "Standard safe window for refrigerated perishables.", isKeep: true, explanation: "Safe! Bring it to a rolling boil on the stove before eating to ensure safety."),
        FoodItem(category: .leftovers, emoji: "🥗", name: "Salad", details: "Dressed and soggy in fridge", conditionHint: "Acid and salt breaking down cell walls.", isKeep: true, explanation: "It's perfectly safe, just soggy and unpleasant. Best to dress salads right before eating!"),
        FoodItem(category: .leftovers, emoji: "🍣", name: "Sushi (Raw Fish)", details: "In fridge overnight", conditionHint: "Raw fish degrades rapidly even when cold.", isKeep: true, explanation: "Raw sushi is generally safe for 24 hours in the fridge, though the rice will be hard."),
        FoodItem(category: .leftovers, emoji: "🍣", name: "Sushi (Raw Fish)", details: "In fridge for 3 days", conditionHint: "High risk of parasitic and bacterial growth.", isKeep: false, explanation: "Do not eat 3-day old raw fish. The risk of severe food poisoning is way too high."),
        FoodItem(category: .leftovers, emoji: "🥩", name: "Cooked Steak", details: "In fridge for 4 days", conditionHint: "Refrigeration slows decay of cooked proteins.", isKeep: true, explanation: "Cooked meats are safe for 3-4 days in the fridge. Heat it up and enjoy!"),
        FoodItem(category: .leftovers, emoji: "🍟", name: "French Fries", details: "Soggy in fridge overnight", conditionHint: "Starches absorbed moisture and retrograded.", isKeep: true, explanation: "Safe! Just toss them in an air fryer or oven to make them crispy again."),
        FoodItem(category: .leftovers, emoji: "🥡", name: "Takeout Box", details: "Forgotten in fridge for 7 days", conditionHint: "Far beyond the safe window for cooked food.", isKeep: false, explanation: "7 days is deep into the danger zone for leftovers. When in doubt, throw it out.")
    ]
}

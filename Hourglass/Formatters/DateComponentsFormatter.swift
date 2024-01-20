import Foundation

class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
	
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }
        
        guard let formattedString = componentsFormatter.string(from: time) else { return nil }
        
        return formattedString
    }
}

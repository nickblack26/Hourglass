import Foundation

extension Date {
    func getFormattedDate() -> String {
        let today = Date()
        let calendar = Calendar.current
        let f = DateFormatter()
        
        let day = f.weekdaySymbols[calendar.component(.weekday, from: today) - 1]
        let month = f.monthSymbols[calendar.component(.month, from: today) - 1]
        let dayNum = calendar.component(.day, from: today)
        
        return "\(day), \(month) \(dayNum)"
    }
    
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
    
    func startOfMonth(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfMonth], from: self).date!
    }
}


extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

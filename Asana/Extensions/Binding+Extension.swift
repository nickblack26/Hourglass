import SwiftUI

extension Binding where Value == String {
    init(value: Binding<String?>) {
        self.init {
            value.wrappedValue ?? ""
        } set: { newValue in
            value.wrappedValue = newValue
        }
    }
}

extension Binding where Value == Int {
    init(value: Binding<Int?>) {
        self.init {
            value.wrappedValue ?? 0
        } set: { newValue in
            value.wrappedValue = newValue
        }
    }
}

extension Binding where Value == NSAttributedString {
    init(value: Binding<Data?>) {
        self.init {
            guard let attributedString = try? NSAttributedString(data: value.wrappedValue ?? Data(), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {
                return NSAttributedString(string: "")
            }
            
            return attributedString
        } set: { newValue in
            let data = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: true)
            return value.wrappedValue = data
        }
    }
}

extension NSAttributedString {
    convenience init(data: Data, documentType: DocumentType, encoding: String.Encoding = .utf8) throws {
        try self.init(attributedString: .init(data: data, options: [.documentType: documentType, .characterEncoding: encoding.rawValue], documentAttributes: nil))
    }

    func data(_ documentType: DocumentType) -> Data {
        // Discussion
        // Raises an rangeException if any part of range lies beyond the end of the receiver’s characters.
        // Therefore passing a valid range allow us to force unwrap the result
        try! data(from: .init(location: 0, length: length),
                  documentAttributes: [.documentType: documentType])
    }

    var text: Data { data(.plain) }
    var html: Data { data(.html)  }
    var rtf:  Data { data(.rtf)   }
    var rtfd: Data { data(.rtfd)  }
}

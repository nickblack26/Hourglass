import Foundation
import SwiftData
import CoreTransferable

@Model
class Widget: Hashable, Codable {
	var name: String = ""
	var image: String = ""
	var columns: Int = 0
    var type: Kind = Kind.myGoals
    var member: Member?
    var order: Int = 0
	
    init(name: String, image: String, columns: Int = 1, type: Kind, order: Int = 0) {
		self.name = name
		self.image = image
		self.columns = columns
        self.type = type
        self.order = order
	}
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
    }
    
    func encode(to encoder: Encoder) throws {
        let container = encoder.container(keyedBy: CodingKeys.self)
        
    }
}



extension Widget {
    enum Kind: Codable {
        case myTasks
        case people
        case projects
        case notepad
        case tasksAssigned
        case draftComments
        case forms
        case myGoals
    }
}

extension Widget: Transferable {
	static var transferRepresentation: some TransferRepresentation {
		CodableRepresentation(contentType: .data)
	}
}

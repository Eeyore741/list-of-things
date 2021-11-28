//
//  Document.swift
//  listofthings
//
//  Created by vitalii.kuznetsov on 2021-11-16.
//

import Foundation

struct Document {
    let key: String
    let subject: String
    let createdAt: Date
    let senderName: String
    let logo: String
}

extension Document: Equatable { }

extension Document: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case key = "key"
        case subject = "subject"
        case createdAt = "created_at"
        case senderName = "sender_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Document.CodingKeys.self)
        self.key = try container.decode(String.self, forKey: CodingKeys.key)
        self.subject = try container.decode(String.self, forKey: CodingKeys.subject)
        self.senderName = try container.decode(String.self, forKey: CodingKeys.senderName)
        self.logo = "📄"
        
        let dateString = try container.decode(String.self, forKey: CodingKeys.createdAt)
        var createdAt = Date()
        
        Self.Helper.dateFormats.forEach { (format: String) in
            Self.Helper.dateFormatter.dateFormat = format
            Self.Helper.dateFormatter.date(from: dateString).map { createdAt = $0 }
        }
        self.createdAt = createdAt
    }
}

private extension Document {
    
    enum Helper {
        
        static let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.timeZone = TimeZone.init(identifier: "UTC")
            return df
        }()
        
        static let dateFormats: Set<String> = {
            [
                "yyyy-MM-dd",
                "yyyy-MM-dd'T'HH:mm:ssZ"
            ]
        }()
    }
}

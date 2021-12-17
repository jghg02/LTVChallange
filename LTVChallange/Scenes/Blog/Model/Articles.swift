//
//  Articles.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 10-12-21.
//

struct Articles: Codable {
    let articles: [Article?]
    
    struct Article: Codable {
        let title: String?
        let description: String?
        let author: String?
        let image: String?
        let article_date: String?
        let link: String?
        let uuid: String?
    }
}

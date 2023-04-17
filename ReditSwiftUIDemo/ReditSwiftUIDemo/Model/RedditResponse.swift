//
//  RedditResponse.swift
//  ReditSwiftUIDemo
//
//  Created by M A Hossan on 17/04/2023.
//

import Foundation
typealias Story = RedditResponse.ResponseData.Child.Story

struct RedditResponse: Decodable {
    let data: ResponseData
    struct ResponseData: Decodable {
        let after: String
        let children: [Child]
        struct Child: Decodable {
            let data: Story
            struct Story: Decodable, Identifiable, Equatable {
                let id = UUID()
                let title: String
                let thumbnailHeight: Int?
                let thumbnailWidth: Int?
                let thumbnail: String?
                let numComments: Int
                let score: Int
            }
        }
    }
}



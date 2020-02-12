//
//  StoryModel.swift
//  CleansePlayground
//
//  Created by Tzatzo, Marsel, Vodafone Greece on 12/02/2020.
//  Copyright © 2020 Tzatzo, Marsel, Vodafone Greece. All rights reserved.
//

import Foundation

struct HNStory: Decodable {
    let by: String
    let descendants: Int?
    let kids: [Int]?
    let score: Int
    let time: Date
    let title: String
    let type: String
    let url: String?
}

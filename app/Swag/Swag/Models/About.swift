//
//  About.swift
//  Swag
//
//  Created by Kazim Ahmad on 15/01/2026.
//

import Foundation
// MARK: - About
struct About: Codable {
    let name, image, coverImage, description: String
    let industry, companySize, headquarters, myStory: String
    let socialMedia: SocialMedia

    enum CodingKeys: String, CodingKey {
        case name, image
        case coverImage = "cover_image"
        case description, industry
        case companySize = "company_size"
        case headquarters
        case myStory = "my_story"
        case socialMedia = "social_media"
    }
    
    static func fetch() async throws -> About {
        let aboutEndpoint = AboutEndpoint.about
        return try await SwiftServices.shared.request(endpoint: aboutEndpoint)
    }
}

// MARK: - SocialMedia
struct SocialMedia: Codable {
    let linkedIn, youTube, instagram: String
    let facebook: String
    let patreon: String
}

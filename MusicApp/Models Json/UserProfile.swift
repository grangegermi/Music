//
//  UserProfile.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

struct User:Decodable {
    
        var country: String
        var display_name: String
        var email: String
        var id: String
        var product: String
        var images: [APIImage] 
    }
    
struct APIImage: Decodable {
    var url:URL
}


//    country = BY;
//    "display_name" = "\U0414\U0430\U0448\U0430";
//    email = "dasha.voloshina.9883@gmail.com";
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/m43bbd0in1g5stwtvaul7dwbk";
//    };
//    followers =     {
//        href = "<null>";
//        total = 0;
//    };
//    href = "https://api.spotify.com/v1/users/m43bbd0in1g5stwtvaul7dwbk";
//    id = m43bbd0in1g5stwtvaul7dwbk;
//    images =     (
//    );
//    product = open;
//    type = user;
//    uri = "spotify:user:m43bbd0in1g5stwtvaul7dwbk";
//}

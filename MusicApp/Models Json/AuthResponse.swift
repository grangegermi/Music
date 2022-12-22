//
//  AuthResponse.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//


import Foundation

struct AuthResponse:Decodable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type:String
}

//{
//    "access_token" = "BQDpow6bGRvhkAVY6eAauT1k6R1Md8HwTLPW1xhirBgTle0ahBNncGeHtMTvv-ZqJpz_QgyqrwVXJlYSfxvp7fylANi4Pq4x7oOrKkJ0K0sxnPUlz17rFiQJxHD1p1spg76gNltqu1sH9HlGwiR_ZyZwyA3yFAIVxO-0v7v_cFCOiqPqOPycdfhsGQRgT4P5fjhsXomHiYeR_hk";
//    "expires_in" = 3600;
//    "refresh_token" = "AQCXC7xF-WOv82c48_lBxoZpR_Rd5Du-4bMH_NAkrrPNpF66k9TYcALa0MwraAG15VUha99qPrJqWqLwcQ9YfdoVmQZvxqX4l48nH_NnNQAQ5U3iK_-CFawy0jKrcbYz3O4";
//    scope = "user-read-private";
//    "token_type" = Bearer;
//}


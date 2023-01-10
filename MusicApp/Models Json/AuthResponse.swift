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

//AuthResponse(
//access_token: "BQAfeekVo0IstC-bcDN_XArHkfoDoIPLWs-w69Col7jS0Aew7F2wwuPbb2Q6Kf5sbwCMf7xXHItpBPr56oWRP8qeGsRPN1-KNeSS_-S2_DbnWvSU6-ZgevDlU6edJcX4oCi6z43eNUyBrTbMdt-8BjUPPUaQsaaSLb_k4Yrr_5SRzGeF2nUxKc3Hua7TTObVXu0IvW8_0lYLCQPto1QS8QCr6bWR6QM6agx65fcmT_7hxB1oRqBGc0SnhTU0L_6fezs83a3kVvk_PNIbahMm9Rk6l7iIA8OUX2t8kJhd-kDCB8-7Iw",
//expires_in: 3600,
//refresh_token:Optional("AQACR10DEPV14eBVMIfOx0RLliLwnSXiwoXlnkXhUm9iOYOLqgq-GLCiBqJpK-NjWBplhVLIL17kD09bRXsKd3Jsmx01dHODoHXTN6fu8gSqTl1RICUfCb7w_beykga6KQI"),
//scope: "playlist-read-private user-library-read user-follow-read user-library-modify playlist-modify-private playlist-modify-public user-read-email user-read-private",
//token_type: "Bearer")


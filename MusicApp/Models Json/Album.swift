//
//  Album.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

struct NewReleasesResponse: Decodable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Decodable{
    let items: [Album]
  
}

struct Album: Decodable {
    let album_type: String = ""
    let available_markets: [String] = []
    let id: String = ""
    var images: [APIImage]  = []
    let name: String = ""
    let release_date: String = ""
    let total_tracks: Int = 0
    let artists: [Artist] = []
  
}

struct Artist: Decodable {
    let id: String
    let name: String
    let type: String
//    let images: [APIImage]?
//    let external_urls: [String: String]
}

//{
//    albums =     {
//        href = "https://api.spotify.com/v1/browse/new-releases?country=BY&locale=ru&offset=0&limit=10";
//        items =         (
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0a3zDmrvmZcORfPeONPvfL";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0a3zDmrvmZcORfPeONPvfL";
//                        id = 0a3zDmrvmZcORfPeONPvfL;
//                        name = "Rauf & Faik";
//                        type = artist;
//                        uri = "spotify:artist:0a3zDmrvmZcORfPeONPvfL";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/35u3WfLl0hcDvs7pZknwro";
//                };
//                href = "https://api.spotify.com/v1/albums/35u3WfLl0hcDvs7pZknwro";
//                id = 35u3WfLl0hcDvs7pZknwro;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273d9a9e9a2a54924c3da3c0b8a";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02d9a9e9a2a54924c3da3c0b8a";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851d9a9e9a2a54924c3da3c0b8a";
//                        width = 64;
//                    }
//                );
//                name = Rubicon;
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:35u3WfLl0hcDvs7pZknwro";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/5q1NzLZwErZ9ujzqZKL0YZ";
//                        };
//                        href = "https://api.spotify.com/v1/artists/5q1NzLZwErZ9ujzqZKL0YZ";
//                        id = 5q1NzLZwErZ9ujzqZKL0YZ;
//                        name = "\U0422\U0440\U0438 \U0434\U043d\U044f \U0434\U043e\U0436\U0434\U044f";
//                        type = artist;
//                        uri = "spotify:artist:5q1NzLZwErZ9ujzqZKL0YZ";
//                    },
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/1pvmXh50KezixmCHnp9XvV";
//                        };
//                        href = "https://api.spotify.com/v1/artists/1pvmXh50KezixmCHnp9XvV";
//                        id = 1pvmXh50KezixmCHnp9XvV;
//                        name = Zivert;
//                        type = artist;
//                        uri = "spotify:artist:1pvmXh50KezixmCHnp9XvV";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/2nK6BeYpEba9gEIckO7hHR";
//                };
//                href = "https://api.spotify.com/v1/albums/2nK6BeYpEba9gEIckO7hHR";
//                id = 2nK6BeYpEba9gEIckO7hHR;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b2730c74c73c500a85b3c28656fe";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e020c74c73c500a85b3c28656fe";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d000048510c74c73c500a85b3c28656fe";
//                        width = 64;
//                    }
//                );
//                name = "\U0412\U044b\U0434\U044b\U0445\U0430\U0439";
//                "release_date" = "2022-03-22";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:2nK6BeYpEba9gEIckO7hHR";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/1F8usyx5PbYGWxf0bwdXwA";
//                        };
//                        href = "https://api.spotify.com/v1/artists/1F8usyx5PbYGWxf0bwdXwA";
//                        id = 1F8usyx5PbYGWxf0bwdXwA;
//                        name = PHARAOH;
//                        type = artist;
//                        uri = "spotify:artist:1F8usyx5PbYGWxf0bwdXwA";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/0mEvl65Cm91K1EAIjiGfOG";
//                };
//                href = "https://api.spotify.com/v1/albums/0mEvl65Cm91K1EAIjiGfOG";
//                id = 0mEvl65Cm91K1EAIjiGfOG;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273a55741d6d3077bace207d99a";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02a55741d6d3077bace207d99a";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851a55741d6d3077bace207d99a";
//                        width = 64;
//                    }
//                );
//                name = "\U0425\U0430\U043b\U043b\U0438\U0432\U0443\U0434 \U0425\U043e\U0443\U0441";
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:0mEvl65Cm91K1EAIjiGfOG";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/0L8ExT028jH3ddEcZwqJJ5";
//                        };
//                        href = "https://api.spotify.com/v1/artists/0L8ExT028jH3ddEcZwqJJ5";
//                        id = 0L8ExT028jH3ddEcZwqJJ5;
//                        name = "Red Hot Chili Peppers";
//                        type = artist;
//                        uri = "spotify:artist:0L8ExT028jH3ddEcZwqJJ5";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/6zBLkJVa4eSXgP7o7ta7IO";
//                };
//                href = "https://api.spotify.com/v1/albums/6zBLkJVa4eSXgP7o7ta7IO";
//                id = 6zBLkJVa4eSXgP7o7ta7IO;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273845937785d17cf265d678b60";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02845937785d17cf265d678b60";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851845937785d17cf265d678b60";
//                        width = 64;
//                    }
//                );
//                name = "Not the One";
//                "release_date" = "2022-03-24";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:6zBLkJVa4eSXgP7o7ta7IO";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/60d24wfXkVzDSfLS6hyCjZ";
//                        };
//                        href = "https://api.spotify.com/v1/artists/60d24wfXkVzDSfLS6hyCjZ";
//                        id = 60d24wfXkVzDSfLS6hyCjZ;
//                        name = "Martin Garrix";
//                        type = artist;
//                        uri = "spotify:artist:60d24wfXkVzDSfLS6hyCjZ";
//                    },
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/2qxJFvFYMEDqd7ui6kSAcq";
//                        };
//                        href = "https://api.spotify.com/v1/artists/2qxJFvFYMEDqd7ui6kSAcq";
//                        id = 2qxJFvFYMEDqd7ui6kSAcq;
//                        name = Zedd;
//                        type = artist;
//                        uri = "spotify:artist:2qxJFvFYMEDqd7ui6kSAcq";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/0mHq8oTwln3MA72n3uHscJ";
//                };
//                href = "https://api.spotify.com/v1/albums/0mHq8oTwln3MA72n3uHscJ";
//                id = 0mHq8oTwln3MA72n3uHscJ;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b27317358352e5cdfa08af5f2a08";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e0217358352e5cdfa08af5f2a08";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d0000485117358352e5cdfa08af5f2a08";
//                        width = 64;
//                    }
//                );
//                name = Follow;
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:0mHq8oTwln3MA72n3uHscJ";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/2SeRP5iAIhVec4azKHJzjX";
//                        };
//                        href = "https://api.spotify.com/v1/artists/2SeRP5iAIhVec4azKHJzjX";
//                        id = 2SeRP5iAIhVec4azKHJzjX;
//                        name = INSTASAMKA;
//                        type = artist;
//                        uri = "spotify:artist:2SeRP5iAIhVec4azKHJzjX";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/4e2veIO1fokCmMybLOcL8m";
//                };
//                href = "https://api.spotify.com/v1/albums/4e2veIO1fokCmMybLOcL8m";
//                id = 4e2veIO1fokCmMybLOcL8m;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b2730764bb04dbdafddf7186f706";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e020764bb04dbdafddf7186f706";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d000048510764bb04dbdafddf7186f706";
//                        width = 64;
//                    }
//                );
//                name = SHAKE;
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:4e2veIO1fokCmMybLOcL8m";
//            },
//                        {
//                "album_type" = album;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/6RZUqkomCmb8zCRqc9eznB";
//                        };
//                        href = "https://api.spotify.com/v1/artists/6RZUqkomCmb8zCRqc9eznB";
//                        id = 6RZUqkomCmb8zCRqc9eznB;
//                        name = Placebo;
//                        type = artist;
//                        uri = "spotify:artist:6RZUqkomCmb8zCRqc9eznB";
//                    }
//                );
//                "available_markets" =                 (
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/0HspPDRcmcs2zFC5hL9fmR";
//                };
//                href = "https://api.spotify.com/v1/albums/0HspPDRcmcs2zFC5hL9fmR";
//                id = 0HspPDRcmcs2zFC5hL9fmR;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273ba95f5e159d7d1065d636663";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02ba95f5e159d7d1065d636663";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851ba95f5e159d7d1065d636663";
//                        width = 64;
//                    }
//                );
//                name = "Never Let Me Go";
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 13;
//                type = album;
//                uri = "spotify:album:0HspPDRcmcs2zFC5hL9fmR";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/23fW0TaMYDKQiyuoIpq8Ds";
//                        };
//                        href = "https://api.spotify.com/v1/artists/23fW0TaMYDKQiyuoIpq8Ds";
//                        id = 23fW0TaMYDKQiyuoIpq8Ds;
//                        name = "\U0410\U0441\U0438\U044f";
//                        type = artist;
//                        uri = "spotify:artist:23fW0TaMYDKQiyuoIpq8Ds";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/5e461nzWDbS3gs5tF4V5Z1";
//                };
//                href = "https://api.spotify.com/v1/albums/5e461nzWDbS3gs5tF4V5Z1";
//                id = 5e461nzWDbS3gs5tF4V5Z1;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b273b42342c702b311e19246a08d";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e02b42342c702b311e19246a08d";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d00004851b42342c702b311e19246a08d";
//                        width = 64;
//                    }
//                );
//                name = "\U041a\U0440\U0435\U0441\U0442\U0438\U043a\U0438";
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:5e461nzWDbS3gs5tF4V5Z1";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/3MM8mtgFzaEJsqbjZBSsHJ";
//                        };
//                        href = "https://api.spotify.com/v1/artists/3MM8mtgFzaEJsqbjZBSsHJ";
//                        id = 3MM8mtgFzaEJsqbjZBSsHJ;
//                        name = "Bloc Party";
//                        type = artist;
//                        uri = "spotify:artist:3MM8mtgFzaEJsqbjZBSsHJ";
//                    }
//                );
//                "available_markets" =                 (
//                    IN
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/7xPbVSbgpvg055323cc8HD";
//                };
//                href = "https://api.spotify.com/v1/albums/7xPbVSbgpvg055323cc8HD";
//                id = 7xPbVSbgpvg055323cc8HD;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b2732e430d38961e619ca5655849";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e022e430d38961e619ca5655849";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d000048512e430d38961e619ca5655849";
//                        width = 64;
//                    }
//                );
//                name = "If We Get Caught";
//                "release_date" = "2022-03-24";
//                "release_date_precision" = day;
//                "total_tracks" = 4;
//                type = album;
//                uri = "spotify:album:7xPbVSbgpvg055323cc8HD";
//            },
//                        {
//                "album_type" = single;
//                artists =                 (
//                                        {
//                        "external_urls" =                         {
//                            spotify = "https://open.spotify.com/artist/774od4b04zDMQMGxrJDeuB";
//                        };
//                        href = "https://api.spotify.com/v1/artists/774od4b04zDMQMGxrJDeuB";
//                        id = 774od4b04zDMQMGxrJDeuB;
//                        name = Xcho;
//                        type = artist;
//                        uri = "spotify:artist:774od4b04zDMQMGxrJDeuB";
//                    }
//                );
//                "available_markets" =                 (
//                    AD,
//                    AE,
//                    AG,
//                    AL,
//                    AM,
//                    AO,
//                    AR,
//                    AT,
//                    AU,
//                    AZ,
//                    BA,
//                    BB,
//                    BD,
//                    BE,
//                    BF,
//                    BG,
//                    BH,
//                    BI,
//                    BJ,
//                    BN,
//                    BO,
//                    BR,
//                    BS,
//                    BT,
//                    BW,
//                    BY,
//                    BZ,
//                    CA,
//                    CD,
//                    CG,
//                    CH,
//                    CI,
//                    CL,
//                    CM,
//                    CO,
//                    CR,
//                    CV,
//                    CW,
//                    CY,
//                    CZ,
//                    DE,
//                    DJ,
//                    DK,
//                    DM,
//                    DO,
//                    DZ,
//                    EC,
//                    EE,
//                    EG,
//                    ES,
//                    FI,
//                    FJ,
//                    FM,
//                    FR,
//                    GA,
//                    GB,
//                    GD,
//                    GE,
//                    GH,
//                    GM,
//                    GN,
//                    GQ,
//                    GR,
//                    GT,
//                    GW,
//                    GY,
//                    HK,
//                    HN,
//                    HR,
//                    HT,
//                    HU,
//                    ID,
//                    IE,
//                    IL,
//                    IN,
//                    IQ,
//                    IS,
//                    IT,
//                    JM,
//                    JO,
//                    JP,
//                    KE,
//                    KG,
//                    KH,
//                    KI,
//                    KM,
//                    KN,
//                    KR,
//                    KW,
//                    KZ,
//                    LA,
//                    LB,
//                    LC,
//                    LI,
//                    LK,
//                    LR,
//                    LS,
//                    LT,
//                    LU,
//                    LV,
//                    LY,
//                    MA,
//                    MC,
//                    MD,
//                    ME,
//                    MG,
//                    MH,
//                    MK,
//                    ML,
//                    MN,
//                    MO,
//                    MR,
//                    MT,
//                    MU,
//                    MV,
//                    MW,
//                    MX,
//                    MY,
//                    MZ,
//                    NA,
//                    NE,
//                    NG,
//                    NI,
//                    NL,
//                    NO,
//                    NP,
//                    NR,
//                    NZ,
//                    OM,
//                    PA,
//                    PE,
//                    PG,
//                    PH,
//                    PK,
//                    PL,
//                    PS,
//                    PT,
//                    PW,
//                    PY,
//                    QA,
//                    RO,
//                    RS,
//                    RW,
//                    SA,
//                    SB,
//                    SC,
//                    SE,
//                    SG,
//                    SI,
//                    SK,
//                    SL,
//                    SM,
//                    SN,
//                    SR,
//                    ST,
//                    SV,
//                    SZ,
//                    TD,
//                    TG,
//                    TH,
//                    TJ,
//                    TL,
//                    TN,
//                    TO,
//                    TR,
//                    TT,
//                    TV,
//                    TW,
//                    TZ,
//                    UA,
//                    UG,
//                    US,
//                    UY,
//                    UZ,
//                    VC,
//                    VE,
//                    VN,
//                    VU,
//                    WS,
//                    XK,
//                    ZA,
//                    ZM,
//                    ZW
//                );
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/album/2GB5KYQlUVjyszd3IOACbg";
//                };
//                href = "https://api.spotify.com/v1/albums/2GB5KYQlUVjyszd3IOACbg";
//                id = 2GB5KYQlUVjyszd3IOACbg;
//                images =                 (
//                                        {
//                        height = 640;
//                        url = "https://i.scdn.co/image/ab67616d0000b2738265b15bc141dfe1a8cc91b9";
//                        width = 640;
//                    },
//                                        {
//                        height = 300;
//                        url = "https://i.scdn.co/image/ab67616d00001e028265b15bc141dfe1a8cc91b9";
//                        width = 300;
//                    },
//                                        {
//                        height = 64;
//                        url = "https://i.scdn.co/image/ab67616d000048518265b15bc141dfe1a8cc91b9";
//                        width = 64;
//                    }
//                );
//                name = "\U0422\U044b \U0438 \U042f";
//                "release_date" = "2022-03-25";
//                "release_date_precision" = day;
//                "total_tracks" = 1;
//                type = album;
//                uri = "spotify:album:2GB5KYQlUVjyszd3IOACbg";
//            }
//        );
//        limit = 10;
//        next = "https://api.spotify.com/v1/browse/new-releases?country=BY&locale=ru&offset=10&limit=10";
//        offset = 0;
//        previous = "<null>";
//        total = 55;
//    };
//}

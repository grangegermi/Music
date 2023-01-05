//
//  AlbumDatail.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import Foundation
struct AlbumDetail:Decodable{
    
    var album_type: String
    var artists: [Artist]
    var available_markets: [String]
    var external_urls: [String: String]
    var id: String
    var images: [APIImage]
    var label: String
    var name: String
    var tracks: TracksResponse
}

struct TracksResponse: Decodable {
    
    var items: [AudioTrack]
    
}

struct AudioTrack: Decodable{
    var album: Album?
    var artists: [Artist]
    var available_markets: [String]
    var disc_number: Int
    var duration_ms: TimeInterval
    var explicit: Bool
    var external_urls: [String: String]
    var id: String
    var name: String
    var preview_url:String?
}

//{
//    "album_type" = single;
//    artists =     (
//                {
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/artist/0a3zDmrvmZcORfPeONPvfL";
//            };
//            href = "https://api.spotify.com/v1/artists/0a3zDmrvmZcORfPeONPvfL";
//            id = 0a3zDmrvmZcORfPeONPvfL;
//            name = "Rauf & Faik";
//            type = artist;
//            uri = "spotify:artist:0a3zDmrvmZcORfPeONPvfL";
//        }
//    );
//    "available_markets" =     (
//        AD,
//        AE,
//        AG,
//        AL,
//        AM,
//        AO,
//        AR,
//        AT,
//        AU,
//        AZ,
//        BA,
//        BB,
//        BD,
//        BE,
//        BF,
//        BG,
//        BH,
//        BI,
//        BJ,
//        BN,
//        BO,
//        BR,
//        BS,
//        BT,
//        BW,
//        BY,
//        BZ,
//        CA,
//        CD,
//        CG,
//        CH,
//        CI,
//        CL,
//        CM,
//        CO,
//        CR,
//        CV,
//        CW,
//        CY,
//        CZ,
//        DE,
//        DJ,
//        DK,
//        DM,
//        DO,
//        DZ,
//        EC,
//        EE,
//        EG,
//        ES,
//        FI,
//        FJ,
//        FM,
//        FR,
//        GA,
//        GB,
//        GD,
//        GE,
//        GH,
//        GM,
//        GN,
//        GQ,
//        GR,
//        GT,
//        GW,
//        GY,
//        HK,
//        HN,
//        HR,
//        HT,
//        HU,
//        ID,
//        IE,
//        IL,
//        IN,
//        IQ,
//        IS,
//        IT,
//        JM,
//        JO,
//        JP,
//        KE,
//        KG,
//        KH,
//        KI,
//        KM,
//        KN,
//        KR,
//        KW,
//        KZ,
//        LA,
//        LB,
//        LC,
//        LI,
//        LK,
//        LR,
//        LS,
//        LT,
//        LU,
//        LV,
//        LY,
//        MA,
//        MC,
//        MD,
//        ME,
//        MG,
//        MH,
//        MK,
//        ML,
//        MN,
//        MO,
//        MR,
//        MT,
//        MU,
//        MV,
//        MW,
//        MX,
//        MY,
//        MZ,
//        NA,
//        NE,
//        NG,
//        NI,
//        NL,
//        NO,
//        NP,
//        NR,
//        NZ,
//        OM,
//        PA,
//        PE,
//        PG,
//        PH,
//        PK,
//        PL,
//        PS,
//        PT,
//        PW,
//        PY,
//        QA,
//        RO,
//        RS,
//        RW,
//        SA,
//        SB,
//        SC,
//        SE,
//        SG,
//        SI,
//        SK,
//        SL,
//        SM,
//        SN,
//        SR,
//        ST,
//        SV,
//        SZ,
//        TD,
//        TG,
//        TH,
//        TJ,
//        TL,
//        TN,
//        TO,
//        TR,
//        TT,
//        TV,
//        TW,
//        TZ,
//        UA,
//        UG,
//        US,
//        UY,
//        UZ,
//        VC,
//        VE,
//        VN,
//        VU,
//        WS,
//        XK,
//        ZA,
//        ZM,
//        ZW
//    );
//    copyrights =     (
//                {
//            text = "\U00a9 2022 Rauf & Faik";
//            type = C;
//        },
//                {
//            text = "\U2117 2022 Rauf & Faik";
//            type = P;
//        }
//    );
//    "external_ids" =     {
//        upc = 190296218620;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/album/35u3WfLl0hcDvs7pZknwro";
//    };
//    genres =     (
//    );
//    href = "https://api.spotify.com/v1/albums/35u3WfLl0hcDvs7pZknwro";
//    id = 35u3WfLl0hcDvs7pZknwro;
//    images =     (
//                {
//            height = 640;
//            url = "https://i.scdn.co/image/ab67616d0000b273d9a9e9a2a54924c3da3c0b8a";
//            width = 640;
//        },
//                {
//            height = 300;
//            url = "https://i.scdn.co/image/ab67616d00001e02d9a9e9a2a54924c3da3c0b8a";
//            width = 300;
//        },
//                {
//            height = 64;
//            url = "https://i.scdn.co/image/ab67616d00004851d9a9e9a2a54924c3da3c0b8a";
//            width = 64;
//        }
//    );
//    label = "Rauf & Faik";
//    name = Rubicon;
//    popularity = 34;
//    "release_date" = "2022-03-25";
//    "release_date_precision" = day;
//    "total_tracks" = 1;
//    tracks =     {
//        href = "https://api.spotify.com/v1/albums/35u3WfLl0hcDvs7pZknwro/tracks?offset=0&limit=50&locale=ru";
//        items =         (
//                        {
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
//                    ET,
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
//                "disc_number" = 1;
//                "duration_ms" = 182660;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/7FN9xGlDHHTdh7JLWg4C9z";
//                };
//                href = "https://api.spotify.com/v1/tracks/7FN9xGlDHHTdh7JLWg4C9z";
//                id = 7FN9xGlDHHTdh7JLWg4C9z;
//                "is_local" = 0;
//                name = Rubicon;
//                "preview_url" = "https://p.scdn.co/mp3-preview/7bc489b5d090e82f608a994493971c0298fc0969?cid=ce369415299e4fcd9a79f9086cc4f8e3";
//                "track_number" = 1;
//                type = track;
//                uri = "spotify:track:7FN9xGlDHHTdh7JLWg4C9z";
//            }
//        );
//        limit = 50;
//        next = "<null>";
//        offset = 0;
//        previous = "<null>";
//        total = 1;
//    };
//    type = album;
//    uri = "spotify:album:35u3WfLl0hcDvs7pZknwro";
//}
//{
//    "album_type" = single;
//    artists =     (
//                {
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/artist/5q1NzLZwErZ9ujzqZKL0YZ";
//            };
//            href = "https://api.spotify.com/v1/artists/5q1NzLZwErZ9ujzqZKL0YZ";
//            id = 5q1NzLZwErZ9ujzqZKL0YZ;
//            name = "\U0422\U0440\U0438 \U0434\U043d\U044f \U0434\U043e\U0436\U0434\U044f";
//            type = artist;
//            uri = "spotify:artist:5q1NzLZwErZ9ujzqZKL0YZ";
//        },
//                {
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/artist/1pvmXh50KezixmCHnp9XvV";
//            };
//            href = "https://api.spotify.com/v1/artists/1pvmXh50KezixmCHnp9XvV";
//            id = 1pvmXh50KezixmCHnp9XvV;
//            name = Zivert;
//            type = artist;
//            uri = "spotify:artist:1pvmXh50KezixmCHnp9XvV";
//        }
//    );
//    "available_markets" =     (
//        AD,
//        AE,
//        AG,
//        AL,
//        AM,
//        AO,
//        AR,
//        AT,
//        AU,
//        AZ,
//        BA,
//        BB,
//        BD,
//        BE,
//        BF,
//        BG,
//        BH,
//        BI,
//        BJ,
//        BN,
//        BO,
//        BR,
//        BS,
//        BT,
//        BW,
//        BY,
//        BZ,
//        CA,
//        CD,
//        CG,
//        CH,
//        CI,
//        CL,
//        CM,
//        CO,
//        CR,
//        CV,
//        CW,
//        CY,
//        CZ,
//        DE,
//        DJ,
//        DK,
//        DM,
//        DO,
//        DZ,
//        EC,
//        EE,
//        EG,
//        ES,
//        FI,
//        FJ,
//        FM,
//        FR,
//        GA,
//        GB,
//        GD,
//        GE,
//        GH,
//        GM,
//        GN,
//        GQ,
//        GR,
//        GT,
//        GW,
//        GY,
//        HK,
//        HN,
//        HR,
//        HT,
//        HU,
//        ID,
//        IE,
//        IL,
//        IN,
//        IQ,
//        IS,
//        IT,
//        JM,
//        JO,
//        JP,
//        KE,
//        KG,
//        KH,
//        KI,
//        KM,
//        KN,
//        KR,
//        KW,
//        KZ,
//        LA,
//        LB,
//        LC,
//        LI,
//        LK,
//        LR,
//        LS,
//        LT,
//        LU,
//        LV,
//        LY,
//        MA,
//        MC,
//        MD,
//        ME,
//        MG,
//        MH,
//        MK,
//        ML,
//        MN,
//        MO,
//        MR,
//        MT,
//        MU,
//        MV,
//        MW,
//        MX,
//        MY,
//        MZ,
//        NA,
//        NE,
//        NG,
//        NI,
//        NL,
//        NO,
//        NP,
//        NR,
//        NZ,
//        OM,
//        PA,
//        PE,
//        PG,
//        PH,
//        PK,
//        PL,
//        PS,
//        PT,
//        PW,
//        PY,
//        QA,
//        RO,
//        RS,
//        RW,
//        SA,
//        SB,
//        SC,
//        SE,
//        SG,
//        SI,
//        SK,
//        SL,
//        SM,
//        SN,
//        SR,
//        ST,
//        SV,
//        SZ,
//        TD,
//        TG,
//        TH,
//        TJ,
//        TL,
//        TN,
//        TO,
//        TR,
//        TT,
//        TV,
//        TW,
//        TZ,
//        UA,
//        UG,
//        US,
//        UY,
//        UZ,
//        VC,
//        VE,
//        VN,
//        VU,
//        WS,
//        XK,
//        ZA,
//        ZM,
//        ZW
//    );
//    copyrights =     (
//                {
//            text = "2022 \U041f\U0435\U0440\U0432\U043e\U0435 \U041c\U0443\U0437\U044b\U043a\U0430\U043b\U044c\U043d\U043e\U0435 / IZBA / \U0421\U0415\U041c\U042c\U042f";
//            type = C;
//        },
//                {
//            text = "2022 \U041f\U0435\U0440\U0432\U043e\U0435 \U041c\U0443\U0437\U044b\U043a\U0430\U043b\U044c\U043d\U043e\U0435 / IZBA / \U0421\U0415\U041c\U042c\U042f";
//            type = P;
//        }
//    );
//    "external_ids" =     {
//        upc = 5063018075274;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/album/2nK6BeYpEba9gEIckO7hHR";
//    };
//    genres =     (
//    );
//    href = "https://api.spotify.com/v1/albums/2nK6BeYpEba9gEIckO7hHR";
//    id = 2nK6BeYpEba9gEIckO7hHR;
//    images =     (
//                {
//            height = 640;
//            url = "https://i.scdn.co/image/ab67616d0000b2730c74c73c500a85b3c28656fe";
//            width = 640;
//        },
//                {
//            height = 300;
//            url = "https://i.scdn.co/image/ab67616d00001e020c74c73c500a85b3c28656fe";
//            width = 300;
//        },
//                {
//            height = 64;
//            url = "https://i.scdn.co/image/ab67616d000048510c74c73c500a85b3c28656fe";
//            width = 64;
//        }
//    );
//    label = "\U041f\U0435\U0440\U0432\U043e\U0435 \U041c\U0443\U0437\U044b\U043a\U0430\U043b\U044c\U043d\U043e\U0435 / IZBA / \U0421\U0415\U041c\U042c\U042f";
//    name = "\U0412\U044b\U0434\U044b\U0445\U0430\U0439";
//    popularity = 32;
//    "release_date" = "2022-03-22";
//    "release_date_precision" = day;
//    "total_tracks" = 1;
//    tracks =     {
//        href = "https://api.spotify.com/v1/albums/2nK6BeYpEba9gEIckO7hHR/tracks?offset=0&limit=50&locale=ru";
//        items =         (
//                        {
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
//                "disc_number" = 1;
//                "duration_ms" = 241935;
//                explicit = 0;
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/track/7bqrgUlzAB3BNDsoeMSPvh";
//                };
//                href = "https://api.spotify.com/v1/tracks/7bqrgUlzAB3BNDsoeMSPvh";
//                id = 7bqrgUlzAB3BNDsoeMSPvh;
//                "is_local" = 0;
//                name = "\U0412\U044b\U0434\U044b\U0445\U0430\U0439";
//                "preview_url" = "https://p.scdn.co/mp3-preview/56473cd96580e5fd548d02f3e27474d8de17d704?cid=ce369415299e4fcd9a79f9086cc4f8e3";
//                "track_number" = 1;
//                type = track;
//                uri = "spotify:track:7bqrgUlzAB3BNDsoeMSPvh";
//            }
//        );
//        limit = 50;
//        next = "<null>";
//        offset = 0;
//        previous = "<null>";
//        total = 1;
//    };
//    type = album;
//    uri = "spotify:album:2nK6BeYpEba9gEIckO7hHR";
//}
//

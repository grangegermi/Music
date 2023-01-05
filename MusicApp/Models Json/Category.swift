////
////  Category.swift
////  MusicApp
////
////  Created by Даша Волошина on 27.12.22.
////
//
import Foundation

struct Categories:Decodable{
    let categories: Category
}

struct Category:Decodable{
    
    let items:[ItemsCategory]
}

struct ItemsCategory:Decodable{
    let icons:[APIImage]
    let id:String
    let name:String
    init(icons: [APIImage], id: String, name: String) {
        self.icons = icons
        self.id = id
        self.name = name
    }
}

//{
//    categories =     {
//        href = "https://api.spotify.com/v1/browse/categories?country=BY&offset=0&limit=20";
//        items =         (
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/toplists";
//                icons =                 (
//                                        {
//                        height = 275;
//                        url = "https://t.scdn.co/media/derived/toplists_11160599e6a04ac5d6f2757f5511778f_0_0_275_275.jpg";
//                        width = 275;
//                    }
//                );
//                id = toplists;
//                name = "\U0425\U0438\U0442-\U043f\U0430\U0440\U0430\U0434\U044b";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFEC4WFtoNRpw";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/pop-274x274_447148649685019f5e2a03a39e78ba52_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFEC4WFtoNRpw;
//                name = "\U041f\U043e\U043f";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/russian_rap";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/f0dc661055614c47ade17bc69b9fef02";
//                        width = "<null>";
//                    }
//                );
//                id = "russian_rap";
//                name = "\U0420\U0443\U0441\U0441\U043a\U0438\U0439 \U0440\U044d\U043f";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFFzDl7qN9Apr";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/chill-274x274_4c46374f007813dd10b37e8d8fd35b4b_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFFzDl7qN9Apr;
//                name = "\U0420\U0435\U043b\U0430\U043a\U0441";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFDXXwE9BDJAr";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/rock_9ce79e0a4ef901bbd10494f5b855d3cc_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFDXXwE9BDJAr;
//                name = "\U0420\U043e\U043a";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFCbimwdOYlsl";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/original/genre-images-square-274x274_5e50d72b846a198fcd2ca9b3aef5f0c8_274x274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFCbimwdOYlsl;
//                name = "\U0424\U043e\U043a\U0443\U0441";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFCfObibaOZbv";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/0d39395309ba47838ef12ce987f19d16.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFCfObibaOZbv;
//                name = "\U0414\U043b\U044f \U0433\U0435\U0439\U043c\U0435\U0440\U043e\U0432";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFHOzuVTgTizF";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/edm-274x274_0ef612604200a9c14995432994455a6d_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFHOzuVTgTizF;
//                name = Dance;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFAXlCG6QvYQ4";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/media/links/workout-274x274.jpg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFAXlCG6QvYQ4;
//                name = "\U0422\U0440\U0435\U043d\U0438\U0440\U043e\U0432\U043a\U0430";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFOOxftoKZxod";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/c6677aa51acf4121b66b9d1f231bd427.png";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFOOxftoKZxod;
//                name = RADAR;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFCWjUTdzaG0e";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/fe06caf056474bc58862591cd60b57fc.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFCWjUTdzaG0e;
//                name = "\U0418\U043d\U0434\U0438";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFzHmL4tf05da";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/original/mood-274x274_976986a31ac8c49794cbdc7246fd5ad7_274x274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFzHmL4tf05da;
//                name = "\U041d\U0430\U0441\U0442\U0440\U043e\U0435\U043d\U0438\U0435";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFx0uLQR2okcc";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/04da469dd7be4dab96659aa1fa9f0ac9.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFx0uLQR2okcc;
//                name = "\U0414\U043b\U044f \U0434\U043e\U043c\U0430";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFPw634sFwguI";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/084155aeaa724ea1bd393a017d67b709";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFPw634sFwguI;
//                name = EQUAL;
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFIVNxQgRNSg0";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/b611cf5145764c64b80e91ccd5f357c8";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFIVNxQgRNSg0;
//                name = "\U042d\U043f\U043e\U0445\U0438";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFQ00XGBls6ym";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/original/hip-274_0a661854d61e29eace5fe63f73495e68_274x274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFQ00XGBls6ym;
//                name = "\U0425\U0438\U043f-\U0445\U043e\U043f";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFA6SOHvT3gck";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/fada056dcfd54cd28faf80d62b7059c6.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFA6SOHvT3gck;
//                name = "\U0412\U0435\U0447\U0435\U0440\U0438\U043d\U043a\U0430";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFFtlLYUHv8bT";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/ee9451b3ed474c82b1da8f9b5eafc88f.jpeg";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFFtlLYUHv8bT;
//                name = "\U0410\U043b\U044c\U0442\U0435\U0440\U043d\U0430\U0442\U0438\U0432\U0430";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFFoimhOqWzLB";
//                icons =                 (
//                                        {
//                        height = "<null>";
//                        url = "https://t.scdn.co/images/664bb84f7a774e1eadb7c227aed98f3c";
//                        width = "<null>";
//                    }
//                );
//                id = 0JQ5DAqbMKFFoimhOqWzLB;
//                name = "\U0414\U043b\U044f \U0432\U0441\U0435\U0439 \U0441\U0435\U043c\U044c\U0438";
//            },
//                        {
//                href = "https://api.spotify.com/v1/browse/categories/0JQ5DAqbMKFAQy4HL4XU2D";
//                icons =                 (
//                                        {
//                        height = 274;
//                        url = "https://t.scdn.co/media/derived/travel-274x274_1e89cd5b42cf8bd2ff8fc4fb26f2e955_0_0_274_274.jpg";
//                        width = 274;
//                    }
//                );
//                id = 0JQ5DAqbMKFAQy4HL4XU2D;
//                name = "\U0412 \U0434\U043e\U0440\U043e\U0433\U0443";
//            }
//        );
//        limit = 20;
//        next = "https://api.spotify.com/v1/browse/categories?country=BY&offset=20&limit=20";
//        offset = 0;
//        previous = "<null>";
//        total = 43;
//    };
//}
//

//
//  TrackDetails.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import Foundation

struct TrackDetails:Decodable {
    let album:Album
    let artists:Artist
    let id:String
    let name:String
    
}


//{
//    album =     {
//        "album_type" = single;
//        artists =         (
//                        {
//                "external_urls" =                 {
//                    spotify = "https://open.spotify.com/artist/5ChF3i92IPZHduM7jN3dpg";
//                };
//                href = "https://api.spotify.com/v1/artists/5ChF3i92IPZHduM7jN3dpg";
//                id = 5ChF3i92IPZHduM7jN3dpg;
//                name = "Nicky Romero";
//                type = artist;
//                uri = "spotify:artist:5ChF3i92IPZHduM7jN3dpg";
//            }
//        );
//        "available_markets" =         (
//        );
//        "external_urls" =         {
//            spotify = "https://open.spotify.com/album/6FypcAZhJmCJJB8yEajt71";
//        };
//        href = "https://api.spotify.com/v1/albums/6FypcAZhJmCJJB8yEajt71";
//        id = 6FypcAZhJmCJJB8yEajt71;
//        images =         (
//                        {
//                height = 640;
//                url = "https://i.scdn.co/image/ab67616d0000b2738c6e442582a660e4aa410de0";
//                width = 640;
//            },
//                        {
//                height = 300;
//                url = "https://i.scdn.co/image/ab67616d00001e028c6e442582a660e4aa410de0";
//                width = 300;
//            },
//                        {
//                height = 64;
//                url = "https://i.scdn.co/image/ab67616d000048518c6e442582a660e4aa410de0";
//                width = 64;
//            }
//        );
//        name = Toulouse;
//        "release_date" = "2012-01-02";
//        "release_date_precision" = day;
//        "total_tracks" = 1;
//        type = album;
//        uri = "spotify:album:6FypcAZhJmCJJB8yEajt71";
//    };
//    artists =     (
//                {
//            "external_urls" =             {
//                spotify = "https://open.spotify.com/artist/5ChF3i92IPZHduM7jN3dpg";
//            };
//            href = "https://api.spotify.com/v1/artists/5ChF3i92IPZHduM7jN3dpg";
//            id = 5ChF3i92IPZHduM7jN3dpg;
//            name = "Nicky Romero";
//            type = artist;
//            uri = "spotify:artist:5ChF3i92IPZHduM7jN3dpg";
//        }
//    );
//    "available_markets" =     (
//    );
//    "disc_number" = 1;
//    "duration_ms" = 365625;
//    explicit = 0;
//    "external_ids" =     {
//        isrc = NLC281112345;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/track/7sCIdsYQ8Nxoj6TjB1Eb7P";
//    };
//    href = "https://api.spotify.com/v1/tracks/7sCIdsYQ8Nxoj6TjB1Eb7P";
//    id = 7sCIdsYQ8Nxoj6TjB1Eb7P;
//    "is_local" = 0;
//    name = "Toulouse - Original Mix";
//    popularity = 0;
//    "preview_url" = "<null>";
//    "track_number" = 1;
//    type = track;
//    uri = "spotify:track:7sCIdsYQ8Nxoj6TjB1Eb7P";
//}

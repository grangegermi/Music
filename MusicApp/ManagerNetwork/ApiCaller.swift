//
//  ApiCaller.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

final class ApiCaller {
    
    static let sharedCaller = ApiCaller()
    
    private init(){}
    
    struct Constants {
        
        static let basicURlApi = "https://api.spotify.com/v1"
        
    }
    func getUser(completion:@escaping((Result<User, Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            switch token {
            case .success(let tokenRefresh):
                
                guard let url = URL(string: Constants.basicURlApi + "/me") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(tokenRefresh)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        let user = try JSONDecoder().decode(User.self, from: data)
                        completion(.success(user))
                        
                    }
                    
                    catch let error {
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure( let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNewReleases(completion: @escaping(Result<NewReleasesResponse, Error>) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success( let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/browse/new-releases?limit=20") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    do {
                        let album = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                        completion(.success(album))
                        
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getAlbumsDetail (album: Album, completion :@escaping((Result<AlbumDetail,Error>))-> Void){
        
        AuthManager.shared.getRefreshToken { token in
            switch token {
                
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi +  "/albums/" + album.id) else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        let albumDetails = try JSONDecoder().decode(AlbumDetail.self, from: data)
                        completion(.success(albumDetails))
                    }
                    catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getRecommendationsGenres(completion:@escaping((Result<GenresRecomendation, Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/recommendations/available-genre-seeds") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        let recommendations = try JSONDecoder().decode(GenresRecomendation.self, from: data)
                        completion(.success(recommendations))
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }

    func getRecommendations(completion:@escaping((Result<TracksRecomendation, Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/recommendations?limit=10&seed_genres=electro,deep-house,detroit-techno,techno,trance") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        let recomendationTrack = try JSONDecoder().decode(TracksRecomendation.self, from: data)
                        completion(.success(recomendationTrack))
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getRecommendationsTrack(track:Tracks, completion:@escaping((Result<TracksRecomendation, Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/tracks/" + track.id) else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        let track = try JSONDecoder().decode(TracksRecomendation.self, from: data)
                        print(track)
                        completion(.success(track))
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    } 
    
    func getFeaturedPlaylists(completion:@escaping((Result<Playlist, Error>)) -> Void) {
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/browse/featured-playlists?limit=20") else
                {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        let playlist = try JSONDecoder().decode(Playlist.self, from: data)
                        
                        completion(.success(playlist))
                        
                    }
                    catch let error {
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func getPlaylists(playlist:Item, comletion: @escaping ((Result<PlaylistDetails, Error>)) -> Void)   {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/playlists/" + playlist.id ) else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var audioPlaylist = try JSONDecoder().decode(PlaylistDetails.self, from: data)
//                        print(audioPlaylist)
                        comletion(.success(audioPlaylist))
                    }
                    catch let error {
                        print(error)
                        comletion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                comletion(.failure(error))
            }
        }
    }

    func getCategory(completion:@escaping ((Result<Categories,Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/browse/categories?limit=50" ) else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var category = try JSONDecoder().decode(Categories.self, from: data)
                        completion(.success(category))
                    }
                    catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    
    func getCategoryDetails(category:ItemsCategory, completion:@escaping ((Result<CategoryDetails,Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/browse/categories/\(category.id)/playlists?limit=50") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var category = try JSONDecoder().decode(CategoryDetails.self, from: data)
                        
                        completion(.success(category))
                    }
                    catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func search(query:String, completion: @escaping ((Result<Search,Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/search?limit=10&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var search = try JSONDecoder().decode(Search.self, from: data)
                        print(search)
                        completion(.success(search))
                    }
                    catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    func getPlaylistUser(completion: @escaping((Result<[Item],Error>)) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/me/playlists/?limit=50") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "GET"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var userPlaylist = try JSONDecoder().decode(LibraryPlaylist.self, from: data)
                        print(userPlaylist)
                        completion(.success(userPlaylist.items))
                        print(userPlaylist)
                    }
                    catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func createUsersPlaylist(name:String, completion:@escaping (Bool) -> Void) {
        getUser { user in
            switch user {
            case.success(let user):
                
                AuthManager.shared.getRefreshToken { token in
                    
                    switch token{
                    case .success(let refreshToken):
                        
                        guard let url = URL(string:Constants.basicURlApi + "/users/\(user.id)/playlists") else {return}
                        
                        var request = URLRequest(url: url)
                        
                        request.httpMethod = "POST"
                        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        let json = [
                            "name": name
                        ]
                        
                        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                        
                        let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                            
                            guard let data = data else {return}
                            
                            
                            do {
                                var result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                                
                                if let response = result as? [String: Any], response["id"] as? String != nil {
                                    completion(true)
                                }
                                
                                print("created")
                            }
                            
                            catch let error {
                                print(error)
                                completion(false)
                            }
                        }
                        
                        task.resume()
                    case .failure(let error):
                        print(error)
                        completion(false)
                    }
                }
                
            case.failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func deletePlaylist(name:String, completion:@escaping (Bool) -> Void) {
        getUser { user in
            switch user {
            case.success(let user):
                
                AuthManager.shared.getRefreshToken { token in
                    
                    switch token{
                    case .success(let refreshToken):
                        
                        guard let url = URL(string:Constants.basicURlApi + "/users/\(user.id)/playlists") else {return}
                        
                        var request = URLRequest(url: url)
                        
                        request.httpMethod = "DELETE"
                        request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                            
                            guard data != nil else {return}
                            completion(true)
                            
                        }
                        
                        task.resume()
                    case .failure(let error):
                        print(error)
                        completion(false)
                    }
                }
                
            case.failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func addTrackToPlaylist(track:AudioTrack, playlist:Item, completion:@escaping(Bool) -> Void) {
        
        AuthManager.shared.getRefreshToken { token in
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/playlists/\(playlist.id)/tracks") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "POST"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let json = [
                    "uris":["spotify:track:\(track.id)"]
                    
                ]
                print(json)
                request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print(result)
                        if let response = result as? [String: Any],
                           response["snapshot_id"] as? String != nil {
                            completion(true)
                        }
                    }
                    catch let error {
                        print(error)
                        completion(false)
                    }
                }
                
                task.resume()
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
    
    func deleteTrackFromPlaylist(track:AudioTrack,playlist:Item,completion: @escaping(Bool)-> Void) {
        AuthManager.shared.getRefreshToken { token in
            switch token{
            case .success(let refreshToken):
                
                guard let url = URL(string:Constants.basicURlApi + "/playlists/\(playlist.id)/tracks") else {return}
                
                var request = URLRequest(url: url)
                
                request.httpMethod = "DELETE"
                request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let json: [String:Any] = [
                    "tracks": [
                        [
                            "uri":"spotify:track:\(track.id)"
                        ]
                    ]
                ]
                request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                
                let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                    
                    guard let data = data else {return}
                    
                    do {
                        var result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        print(result)
                        if let response = result as? [String: Any],
                           response["snapshot_id"] as? String != nil {
                            completion(true)
                        }
                    }
                    catch let error {
                        print(error)
                        completion(false)
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}


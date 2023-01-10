//
//  ApiCaller.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

final class ApiCaller{
    
    static let sharedCaller = ApiCaller()
    
    private init(){
        
    }
    
    struct Constants {
        
        static let basicURlApi = "https://api.spotify.com/v1"
        
    }
    
    
    //    var result = User()
    //    var recommendations = GenresRecomendation()
    //    var album: [AlbumsResponse] = []
    //    var playlist = Playlist(playlists: ItemsPlaylist(items: []))
    //    var recomendationTrack = TracksRecomendation(tracks: [])
    //
    //    var group = DispatchGroup()
    
    
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
                        //                        print(user)
                        completion(.success(user))
                        
                    }
                    
                    catch let error {
                        completion(.failure(error))
                    }
                }
                
                task.resume()
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func getNewReleases(completion:@escaping((Result<NewReleasesResponse, Error>)) -> Void){
        
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
//                                                print(album)
                        completion(.success(album))
                        
                        
                    }catch let error {
                        completion(.failure(error))
                    }
                    
                }
                
                task.resume()
            case .failure(let error):
                print(error)
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
//                        let v = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                        print(v)
                        let albumDetails = try JSONDecoder().decode(AlbumDetail.self, from: data)
                        
//                        albumDetails.tracks.items.filter({ item in
//                            return item.preview_url != nil
//                        })
                        
                        print(albumDetails)
                        completion(.success(albumDetails))
                    }catch let error {
                        print(error)
                        completion(.failure(error))
                    }
                }
                task.resume()
                
                
            case .failure(let error):
                print(error)
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
                            //                    print(self.recommendations)
                            
                        }catch let error {
                            completion(.failure(error))
                        }
                    }
                    
                    task.resume()
                case .failure(let error):
                    print(error)
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
                            //                        print(recomendationTrack)
                            completion(.success(recomendationTrack))
                            
                            
                        } catch let error {
                            completion(.failure(error))
                        }
                    }
                    task.resume()
                case .failure(let error):
                    print(error)
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
                        let track = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                        let recomendationTrack = try JSONDecoder().decode(TracksRecomendation.self, from: data)
                            print(track)
//                        completion(.success(recomendationTrack))
                        
                        
                    } catch let error {
                        completion(.failure(error))
                    }
                }
                task.resume()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
        
        func getAlbum (completion:@escaping((Result<MyAlbum, Error>)) -> Void) {
            
            AuthManager.shared.getRefreshToken { token in
                
                switch token{
                case .success(let refreshToken):
                    guard let url = URL(string:Constants.basicURlApi + "/tracks?limit=10") else {return}
                    
                    var request = URLRequest(url: url)
                    
                    request.httpMethod = "GET"
                    request.setValue("Bearer \(refreshToken)", forHTTPHeaderField: "Authorization")
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    
                    let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                        
                        guard let data = data else {return}
                        print(String(data: data, encoding: .utf8))
                        do {
                            let album = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                            print(album)
//                            let album = try JSONDecoder().decode(MyAlbum.self, from: data)
//                            completion(.success(album))
                        } catch let error {
                            completion(.failure(error))
                        }
                    }
                    
                    task.resume()
                case .failure(let error):
                    print(error)
                }
            }
            
        }
        
        func getFeaturedPlaylists(completion:@escaping((Result<Playlist, Error>)) -> Void)   {
            
            AuthManager.shared.getRefreshToken { token in
                
                switch token{
                case .success(let refreshToken):
                    
                    guard let url = URL(string:Constants.basicURlApi + "/browse/featured-playlists?limit=30") else
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
//                            var audioPlaylist = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                            var audioPlaylist = try JSONDecoder().decode(PlaylistDetails.self, from: data)
                            print(audioPlaylist)
                            comletion(.success(audioPlaylist))
//                            print(audioPlaylist)
                            
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
//                            var category = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        var category = try JSONDecoder().decode(Categories.self, from: data)
                        completion(.success(category))
//                        comletion(.success(audioPlaylist))
//                        print(category)
                        
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
//                            var category = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        var category = try JSONDecoder().decode(CategoryDetails.self, from: data)
//                        print(category)
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
//                            var search = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
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
    
    
    }


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
    
   
    var result = User()
    var recommendations = GenresRecomendation()
    var playlist:Playlist = Playlist(playlists: Items(items: []))
  
//
    
    
    func getUser() {
        
        AuthManager.shared.getRefreshToken { _ in
            
            guard let url = URL(string: Constants.basicURlApi + "/me") else {return}
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                
                guard let data = data else {return}
                
                do {
                    self.result = try JSONDecoder().decode(User.self, from: data)

                }
                
                catch let error {
                    print(error)
                }
            }
            
            task.resume()
        }
    }

    func getNewReleases() {

        AuthManager.shared.getRefreshToken { _ in

            guard let url = URL(string:Constants.basicURlApi + "/browse/new-releases?limit=10") else {return}

            var request = URLRequest(url: url)

            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, error,  response in

                guard let data = data else {return}

                do {
                    let  finalData = try JSONDecoder().decode(NewReleasesResponse.self, from: data)

                }catch let error {

                    print(error)
                }
            }

            task.resume()
        }
    }

    
    func getRecommendationsGenres() {

        AuthManager.shared.getRefreshToken { _ in

            guard let url = URL(string:Constants.basicURlApi + "/recommendations/available-genre-seeds") else {return}

            var request = URLRequest(url: url)

            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, error,  response in

                guard let data = data else {return}

                do {
                    self.recommendations = try JSONDecoder().decode(GenresRecomendation.self, from: data)

                }catch let error {

                    print(error)
                }
            }

            task.resume()
        }
    }

    
    func getRecommendations() {

        AuthManager.shared.getRefreshToken { _ in

            guard let url = URL(string:Constants.basicURlApi + "/recommendations?limit=10&seed_genres=electro,deep-house,detroit-techno,techno,trance") else {return}

            var request = URLRequest(url: url)

            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, error,  response in

                guard let data = data else {return}

            do {
                    let recomendation = try JSONDecoder().decode(TracksRecomendation.self, from: data)
//                    print (recomendation)

                } catch let error {
                    print(error)
                }
            }
            task.resume()
        }
    }

    func getAlbum() {

        AuthManager.shared.getRefreshToken { _ in

            guard let url = URL(string:Constants.basicURlApi + "/me/albums") else {return}

            var request = URLRequest(url: url)

            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let task = URLSession.shared.dataTask(with: request) { data, error,  response in

                guard let data = data else {return}

                do {
                    
                    let album = try JSONDecoder().decode(MyAlbum.self, from: data)

                } catch let error {
                    print(error)
                }
            }

            task.resume()
        }
    }
 
    func getFeaturedPlaylists()   {
        
        AuthManager.shared.getRefreshToken { _ in
            
            guard let url = URL(string:Constants.basicURlApi + "/browse/featured-playlists?limit=20") else
            {return}
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          
            let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                
                guard let data = data else {return}
                
                do {
                    self.playlist = try JSONDecoder().decode(Playlist.self, from: data)
                    
                    
                    print(self.playlist)
                    
                }
                
                catch let error {
                    print(error)
                }

            }
            
            task.resume()
        }
        
    }
    
    func getPlaylists()   {
        
        AuthManager.shared.getRefreshToken { _ in
            
        guard let url = URL(string:Constants.basicURlApi + "/playlists/" ) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, error,  response in
            
            guard let data = data else {return}
         
            
            do {
                let audioPlaylist = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                   let audio = try JSONDecoder().decode(Playlist.self, from: data)
                
                print (audioPlaylist)
                
            }
            
            catch let error {
                print(error)
            }
        }
        
        task.resume()
    }
 
}
    
}



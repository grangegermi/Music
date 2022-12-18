//
//  ApiCaller.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

final class ApiCaller{
    
    static let sharedCaller = ApiCaller()
    
    private init(){}
    
    struct Constants {
        
        static let basicURlApi = "https://api.spotify.com/v1"
    }
    
    var result = User()
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
                  
                    print(self.result.email)
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
//                print(String(data: data, encoding: .utf8))
//
                do {
                    let finalData = try JSONDecoder().decode(NewReleasesResponse.self, from: data)

//                    print(finalData.albums.items.first?.name)
                }

                catch let error {
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
                    let recommendations = try JSONDecoder().decode(GenresRecomendation.self, from: data)
                    
                    print (recommendations.genres.first)
                    
                }

                catch let error {
                    print(error)
                }
            }
            
            task.resume()
        }
    }
    
    
    func getRecommendations(genres:Set<String>) {
       
        AuthManager.shared.getRefreshToken { _ in
            var seeds = genres.joined(separator: ",")
            while seeds.count < 5 {
            }
            guard let url = URL(string:Constants.basicURlApi + "/recommendations?limit=40&seed_genres=\(seeds)") else {return}
            //api.spotify.com/v1/recommendations
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.setValue("Bearer \(AuthManager.shared.token)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           
            let task = URLSession.shared.dataTask(with: request) { data, error,  response in
                
                guard let data = data else {return}
                
                do {
                    let recommendations = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    print (recommendations)
                    
                }

                catch let error {
                    print(error)
                }
            }
            
            task.resume()
        }
    }
    
}

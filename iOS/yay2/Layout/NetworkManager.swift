//
//  NetworkManager.swift
//  yay2
//
//  Created by Lillian Joyce on 4/30/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    /// Endpoint URL string
    /// NOTE: Remember to set "Allows arbitrary loads" to YES in your Info.plist in order
    /// to access API websites that are not HTTPS (not "secure" - you'll need this for your project)
    private static let endpoint = "https://mindylou.github.io/classes.json"
    private static let postEndpoint = "https://reqres.in/api/login"
    private static let dogEndpoint = "https://random.dog/woof.json"
    
    static func getClasses(completion: @escaping ([Course]) -> Void) {
            Alamofire.request(endpoint, method: .get).validate().responseData { response in
                switch response.result{
                case .success(let data):
                    let jsonDecoder = JSONDecoder()
                    if let courseResponse = try? jsonDecoder.decode(CourseResponse.self, from: data){
                        let classes = courseResponse.data.classes
                        completion(classes)
                    }else{
                        print("invalid response data")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        
    }
    
    static func deleteClasses(completion: @escaping ([Course]) -> Void) {
        Alamofire.request(endpoint, method: .delete).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let courseResponse = try? jsonDecoder.decode(CourseResponse.self, from: data){
                    let classes = courseResponse.data.classes
                    //let course = slided course from endpoint
                    completion(classes)
                }else{
                    print("invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    static func postClasses(completion: @escaping ([Course]) -> Void) {
        Alamofire.request(postEndpoint, method: .post).validate().responseData { response in
            switch response.result{
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let courseResponse = try? jsonDecoder.decode(CourseResponse.self, from: data){
                    let classes = courseResponse.data.classes
                    //let course = slided course from endpoint
                    completion(classes)
                }else{
                    print("invalid response data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    static func login(email: String, password: String) {
        // TODO
    }
    
    static func getRandomDog() {
        // TODO
    }
    
    static func fetchDogImage(imageURL: String, completion: @escaping (UIImage) -> Void) {
        // TODO
}
}

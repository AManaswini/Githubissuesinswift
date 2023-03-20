//
//  GitHubClient.swift
//  Github issues
//
//  Created by Manaswini Aitha on 22/01/23.
//

import Foundation
import UIKit

class GitHubClient {
    struct GithubIssue: Codable {
        let title: String?
        let createdAt: String
        let body: String?
        let state: String
        let user: GitHubUser
    }

    struct GitHubUser:Codable {
        let login: String
    }

  
    static func fetchIssues(state:String, completion: @escaping ([GithubIssue]?, Error?) -> Void) {
    
    // Set the URL
    let urlstr = "https://api.github.com/repos/Ranchero-Software/NetNewsWire/issues?state=\(state)"
    let url = URL(string: urlstr)!
    // Create a data task
    let task = URLSession.shared.dataTask(with: url) { data, _, error in
      guard let data = data, error == nil else {
        // If we are missing data, send back no data with an error
        DispatchQueue.main.async { completion(nil, error) }
        return
      }
      // Safely try to decode the JSON to our custom struct
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let issues = try decoder.decode([GithubIssue].self, from: data)
        // If we're successful, send back our issues with no error
        DispatchQueue.main.async { completion(issues, nil) }

      } catch (let parsingError) {
        DispatchQueue.main.async { completion(nil, parsingError) }
      }
    }
    
    // Start the task (it begins suspended)
    task.resume()
  }
}


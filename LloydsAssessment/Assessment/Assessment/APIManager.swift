//
//  APIManager.swift
//  TestAssessment
//
//  Created by Sreeshaj KP on 09/09/2022.
//

import Foundation
import UIKit

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    //MARK: - HTTPS Calls
    func getNoticeList(url: URL) async throws -> [ASTeam]? {
        let data = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([ASTeam].self,
                                            from: data.0)
            
        }
        catch {
            print(error)
        }
        return nil
    }
    
    func imageDownloader(url: URL) async throws -> UIImage? {
        let data = try await URLSession.shared.data(from: url)
        return UIImage(data: data.0,
                       scale:1)
    }
}

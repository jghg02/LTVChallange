//
//  BlogViewModel.swift
//  LTVChallange
//
//  Created by Josue German Hernandez Gonzalez on 10-12-21.
//

import Foundation

class BlogViewModel {
    
    let data: DataBiding<Articles?> = DataBiding(nil)
    
    func fetchArticlesData() {
            
            let queryParams = APIQueryParams()
            _ = ServicesRequest().getArticles(apiQueryModel: queryParams) { [weak self] data in
                DispatchQueue.main.async {
                    switch data {
                    case .success(let result):
                        self?.data.value = result
                    case  .failure(let error):
                        print("ERROR \(error)")
                        
                    }
                }
                
            }
        }
    
}

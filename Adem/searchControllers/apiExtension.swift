//
//  apiExtension.swift
//  Adem
//
//  Created by Coleman Coats on 7/9/20.
//  Copyright © 2020 Coleman Coats. All rights reserved.
//

import Foundation

extension ResultsTableController {
    
    func parseJSON() {
        //MARK: Wegmans
//        https://learning.postman.com/docs/sending-requests/generate-code-snippets/#supported-languagesframeworks
//      https://dev.wegmans.io/using-postman
        
        var semaphore = DispatchSemaphore (value: 0)
        var searchterm = listViewController().tableViewSearchController.searchBar.text
              
        var request = URLRequest(url: URL(string: "https://api.wegmans.io/products/search?query=\(searchterm)&api-version=2018-10-18")!,timeoutInterval: Double.infinity)
        
        request.addValue("c455d00cb0f64e238a5282d75921f27e", forHTTPHeaderField: "Subscription-Key")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
}

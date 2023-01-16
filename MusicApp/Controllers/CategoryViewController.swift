//
//  CategoryViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 28.12.22.
//

import UIKit

class CategoryViewController: UIViewController {

    var category = ItemsCategory(icons: [], id: "", name: "")
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .cyan
        ApiCaller.sharedCaller.getCategoryDetails(category: category) { result in
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

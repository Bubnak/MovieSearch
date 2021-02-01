//
//  ViewController.swift
//  MovieSearch
//
//  Created by Bubna Ratheesh on 30/01/2021.
//  Copyright © 2021 Bubna Kbubna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var isSearch : Bool = false
    var searchTxt : String = "movie"
    var cell = CollectionViewCell()
    
     var arrItems :[String] = []
      var arrUrl :[String] = []
    var arrImdbID :[String] = []
    var imdbIdIndex : Int = 0
    @IBOutlet weak var viewCollection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // let searchMovie = SearchMovieViewModal(delegate: self)
       // searchMovie.urlSessionVM(with: "")
    }


    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         cell = viewCollection.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath as IndexPath)as! CollectionViewCell
        cell.lblTitle.text = self.arrItems[indexPath.item]
      
        let strUrl =  URL(string: self.arrUrl[indexPath.item])
           //let service = Service()
         let searchMovie = SearchMovieViewModal(delegate: self)
           searchMovie.getImage(withURL:(strUrl)! ) { image in
                print ("SUCCESSFUL")
             self.cell.imgView.image = image
              
            }
               return cell
    }
    
   
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
                  
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                          if let movieDetailViewController = storyBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
                                              movieDetailViewController.imdbID = self.arrImdbID[indexPath.item]
                                             self.present(movieDetailViewController, animated: true, completion: nil)
        
        }
        
               print("You selected cell #\(indexPath.item)!")
        
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MovieDetailViewController {
           let imdbId = self.arrImdbID[imdbIdIndex]
            print("test" + imdbId)
            vc.imdbID = imdbId
        }
    }
    
    //MARK: UISearchbar delegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
        arrItems = []
        arrUrl = []
        arrImdbID = []
               DispatchQueue.main.async{
                  self.viewCollection.reloadData()
          }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
         
        let searchMovie = SearchMovieViewModal(delegate: self)
        searchMovie.urlSessionVM(with: searchTxt) 
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count == 0 {
            searchTxt = ""
        } else {
            searchTxt = searchText
        }
    }

    
}

// MARK: - SearchMovieViewModalDelegate
extension ViewController: SearchMovieViewModalDelegate {
    func onFetchCompleted(with title: [String], andUrl: [String], imdbID:[String]) {
        print ("successful")
        
        arrItems = title
        arrUrl = andUrl
        arrImdbID = imdbID
               DispatchQueue.main.async{
                  self.viewCollection.reloadData()
          }
    }
    
    func onFetchFailed(with reason: String) {
        
    
    }
    
    func onFetchImage() {
        DispatchQueue.main.async{
            self.viewCollection.reloadData()
            }
         }
    }
    


     
    
    
  
  
  



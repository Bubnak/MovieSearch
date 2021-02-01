//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Bubna Ratheesh on 31/01/2021.
//  Copyright © 2021 Bubna Kbubna. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var plotDescr: UILabel!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imdbRating: UILabel!
    @IBOutlet weak var imdbVote: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    // @IBOutlet weak var title: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var lblCastCrew: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    // @IBOutlet weak var plot: UILabel!
    var  imdbID:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imdbID)
       
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let movieDetail = MovieDetailViewModal(delegate: self)
        movieDetail.urlMovieDetail(with: imdbID)
        self.imgMovie.image = UIImage (named: "noImage.png")
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

extension MovieDetailViewController : MovieDetailViewModalDelegate{
    func onFetchImage(with Image: UIImage ) {
                    DispatchQueue.main.async{
                        self.imgMovie.image = Image
                        }
    }
    
    func onFetchCompleted(with movieDetail: MovieDetail) {
         DispatchQueue.main.async{
            self.plotDescr.text = movieDetail.Plot
            self.titleMovie.text = movieDetail.Title
            self.genre.text = movieDetail.Genre
            self.lblYear.text = movieDetail.Year
            self.imdbRating.text = "imdbRating : " + movieDetail.imdbRating
            self.imdbVote.text = "imdbVote : " + movieDetail.imdbVotes
            self.lblCastCrew.text = " Director : " + movieDetail.Director + "\n\n" + "Writer :" + movieDetail.Writer + "\n\n" + "Actor : " + movieDetail.Actors
            
            guard let url = URL(string: movieDetail.Poster) else { return }
            UIImage.loadFrom(url: url) { image in
                 DispatchQueue.main.async{
                self.imgMovie.image = image
                }
            }
        }
    }
    
    func onFetchFailed(with reason: String) {
        
    }
    
    
}


extension UIImage {

    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}

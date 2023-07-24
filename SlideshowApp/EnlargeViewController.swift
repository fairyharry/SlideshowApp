//
//  EnlargeViewController.swift
//  SlideshowApp
//
//  Created by ふぇありーはりぃ on 2023/07/18.
//

import UIKit

class EnlargeViewController: UIViewController {

    // IBOutletの接続
    @IBOutlet weak var EnlargePlanetImageView: UIImageView!
    
    // PlanetImageView の配列に使用するIndex番号を宣言
    var EnlargePlanetChangeImgNo = 0
    
    // PlanetImageView に表示させる画像の配列を宣言
    var EnlargePlanetImageArray:[UIImage] = [
        UIImage(named: "saturn")!,
        UIImage(named: "jupiter")!,
        UIImage(named: "mars")!,
        UIImage(named: "sun")!,
        UIImage(named: "venus")!,
        UIImage(named: "mercury")!,
        UIImage(named: "moon")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        EnlargePlanetImageView.image = EnlargePlanetImageArray[EnlargePlanetChangeImgNo]
    }

}

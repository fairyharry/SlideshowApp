//
//  ViewController.swift
//  SlideshowApp
//
//  Created by ふぇありーはりぃ on 2023/07/17.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutletの接続
    @IBOutlet weak var Label01: UILabel!
    @IBOutlet weak var BackImage: UIButton!
    @IBOutlet weak var ForwardImage: UIButton!
    @IBOutlet weak var PlayStopButton: UIButton!
    @IBOutlet weak var PlanetImageView: UIImageView!
    @IBOutlet weak var PlanetTime: UILabel!
    
    // PlanetImageView の配列に使用するIndex番号を宣言
    var PlanetChangeImgNo = 0
    
    // スライドショーに使用するタイマーの宣言
    var timer: Timer!
    
    // タイマーが再生中に画面遷移したか否かを判定する変数の宣言
    var TimerRunning = 0
    
    // PlanetImageView に表示させる画像の配列を宣言
    var PlanetImageArray:[UIImage] = [
        UIImage(named: "saturn")!,
        UIImage(named: "jupiter")!,
        UIImage(named: "mars")!,
        UIImage(named: "sun")!,
        UIImage(named: "venus")!,
        UIImage(named: "mercury")!,
        UIImage(named: "moon")!
    ]
    
    // PlanetTime に表示させる文字列の配列を宣言
    var PlanetTimeArray:[String] = ["Saturn Time", "Jupiter Time", "Mars Time", "Sun Time", "Venus Time", "Mercury Time", "Moon Time"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PlanetImageView.image = PlanetImageArray[PlanetChangeImgNo]
        PlanetTime.text = PlanetTimeArray[PlanetChangeImgNo]
    }

    
    // selector: #selector(ChangeImage) で指定された関数の設定
    // timeInterval: 2.0, repeats: true で指定された通り、2秒毎に呼び出され続ける
    @objc func ChangeImage() {
        // 指定時間毎に1つ先の画像を表示
        if PlanetChangeImgNo == 6 {
            PlanetChangeImgNo = 0
        } else {
            PlanetChangeImgNo += 1
        }
        PlanetImageView.image = PlanetImageArray[PlanetChangeImgNo]
        PlanetTime.text = PlanetTimeArray[PlanetChangeImgNo]
    }
    
    
    // 戻るボタンのIBActionの設定
    @IBAction func BackImage(_ sender: Any) {
        // 戻るボタンを押すと1つ前の画像を表示
        if (PlanetChangeImgNo == 0) {
            PlanetChangeImgNo = 6
        } else {
            PlanetChangeImgNo -= 1
        }
        PlanetImageView.image = PlanetImageArray[PlanetChangeImgNo]
        PlanetTime.text = PlanetTimeArray[PlanetChangeImgNo]
    }
    
    // 進むボタンのIBActionの設定
    @IBAction func ForwardImage(_ sender: Any) {
        // 進むボタンを押すと1つ先の画像を表示
        if (PlanetChangeImgNo == 6) {
            PlanetChangeImgNo = 0
        } else {
            PlanetChangeImgNo += 1
        }
        PlanetImageView.image = PlanetImageArray[PlanetChangeImgNo]
        PlanetTime.text = PlanetTimeArray[PlanetChangeImgNo]
    }
    
    // 再生/停止ボタンのIBActionの設定
    @IBAction func PlayStopButton(_ sender: Any) {
        // 再生中か停止しているかを判定
        if (timer == nil) {
            // 再生時の処理を設定
            // タイマーをセットする
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ChangeImage), userInfo: nil, repeats: true)
            // タイマーが再生中である旨の変数の設定
            TimerRunning = 1
            // ボタンの名前を停止に変更する
            PlayStopButton.setTitle("停止", for: .normal)
            // 戻るボタンと進むボタンを無効化する
            BackImage.isEnabled = false
            ForwardImage.isEnabled = false
        } else {
            // 停止時の処理を設定
            // タイマーを停止する
            timer.invalidate()
            // タイマーを削除しておく
            timer = nil
            // タイマーが停止している旨の変数の設定
            TimerRunning = 0
            // ボタンの名前を再生に変更する
            PlayStopButton.setTitle("再生", for: .normal)
            // 戻るボタンと進むボタンを有効化する
            BackImage.isEnabled = true
            ForwardImage.isEnabled = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 画面遷移の際に再生中の場合に、タイマーを一旦中断する旨の設定
        if (TimerRunning == 1) {
            // タイマーを停止する
            timer.invalidate()
            // タイマーを削除しておく
            timer = nil
        }
        // segueから遷移先のEnlargeViewControllerを取得する
        let EnlargeViewController:EnlargeViewController = segue.destination as! EnlargeViewController
        // 遷移先のEnlargeViewControllerで宣言しているimageの情報を渡す
        EnlargeViewController.EnlargePlanetChangeImgNo = PlanetChangeImgNo
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
        // 画面遷移の際に再生中だった場合に、タイマーの再生を再開する旨の設定
        if (TimerRunning == 1) {
            // タイマーをセットする
            timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ChangeImage), userInfo: nil, repeats: true)
        }
    }

    
}


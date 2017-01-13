//
//  ViewController.swift
//  LifeGame
//
//  Created by Takashi Hatakeyama on 2016/11/30.
//  Copyright © 2016年 esm. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var lifegame: LifeGame!

    @IBOutlet var lifegameView: LifeGameView!

    @IBAction func randomButtonDidPress(_ sender: Any) {
        lifegame.random()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // init lifegame
        let n = 8
        lifegame = LifeGame(width: n, height: n)
        lifegame.random()
        self.lifegameView.lifegame = lifegame

        // タイマーをセット
        let interval: TimeInterval = 1 / 2
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(nextGeneration), userInfo: nil, repeats: true)
    }

    func nextGeneration() {
        lifegame.next()
        self.lifegameView.needsDisplay = true

        if let window = self.lifegameView.window {
            window.title = "LifeGame (\(self.lifegame.generation))"
        }
    }
}

//
//  LifeGameView.swift
//  LifeGame
//
//  Created by Takashi Hatakeyama on 2016/11/30.
//  Copyright © 2016年 esm. All rights reserved.
//

import Foundation
import Cocoa

class LifeGameView: NSView {
    var lifegame: LifeGame?

    override func draw(_ dirtyRect: NSRect) {
        if let lifegame = self.lifegame {
            // 枠だけ描画
            for w in 0..<lifegame.width {
                for h in 0..<lifegame.height {
                    NSColor.black.set()
                    let x = w * 11 + 10
                    let y = Int(self.bounds.height) - (h * 11) - 20
                    let rect = NSRect(x: x, y: y, width: 10, height: 10)
                    NSFrameRect(rect)
                }
            }

            // 生きてるセルを塗る
            for w in 0..<lifegame.width {
                for h in 0..<lifegame.height {
                    // if lifegame.cells[h][w] {
                    if lifegame.isAlive(x: w, y: h) {
                        NSColor.black.set()
                        let x = w * 11 + 10
                        let y = Int(self.bounds.height) - (h * 11) - 20
                        let rect = NSRect(x: x, y: y, width: 10, height: 10)
                        NSRectFill(rect)
                    }
                }
            }
        }
    }
}

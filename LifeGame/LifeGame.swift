//
//  LifeGame.swift
//  LifeGame
//
//  Created by Takashi Hatakeyama on 2016/12/01.
//  Copyright © 2016年 esm. All rights reserved.
//

import Foundation

class LifeGame {
    var cells: [[Bool]] = [[]]
    var generation: Int = 0

    var width: Int
    var height: Int

    var last: Int {
        get {
            return (width * height) - 1
        }
    }

    init(width: Int, height: Int) {
        self.width = width
        self.height = height

        let row = [Bool](repeating: false, count: width)
        self.cells = [[Bool]](repeating: row, count: height)
    }

    // セルに適当なデータをランダムに割りふる
    func random() {
        for y in 0..<self.height {
            for x in 0..<self.width {
                cells[y][x] = arc4random() % 2 == 0
            }
        }
    }

    func next() {
        let row = [Bool](repeating: false, count: width)
        var newCells = [[Bool]](repeating: row, count: height)

        for y in 0..<self.height {
            for x in 0..<self.width {
                newCells[y][x] = self.nextGeneration(x: x, y: y)
            }
        }

        self.cells = newCells
        self.generation = self.generation + 1
    }

    // MARK: - Private

    func nextGeneration(x: Int, y: Int) -> Bool {
        if self.isAlive(x: x, y: y) {
            if self.neighbors(x: x, y: y) < 2 || self.neighbors(x: x, y: y) >= 4 {
                // 2未満、4以上の場合は死
                return false
            } else {
                // それ以外はそのまま
                return self.isAlive(x: x, y: y)
            }
        } else {
            if self.neighbors(x: x, y: y) == 3 {
                // 3の場合は誕生
                return true
            } else {
                // それ以外はそのまま
                return self.isAlive(x: x, y: y)
            }
        }
    }

    func isAlive(x: Int, y: Int) -> Bool {
        return cells[y][x]
    }

    func isTop(_ y: Int) -> Bool {
        return y == 0
    }

    func isBottom(_ y: Int) -> Bool {
        return y == (self.height - 1)
    }

    func isLeftEdge(_ x: Int) -> Bool {
        return x == 0
    }

    func isRightEdge(_ x: Int) -> Bool {
        return x == (self.width - 1)
    }

    func neighbors(x: Int, y: Int) -> Int {
        var n = 0

        if leftCellVal(x: x, y: y) {
            n += 1
        }
        if rightCellVal(x: x, y: y) {
            n += 1
        }
        if upCellVal(x: x, y: y) {
            n += 1
        }
        if downCellVal(x: x, y: y) {
            n += 1
        }
        if upLeftCellVal(x: x, y: y) {
            n += 1
        }
        if upRightCellVal(x: x, y: y) {
            n += 1
        }
        if downLeftCellVal(x: x, y: y) {
            n += 1
        }
        if downRightCellVal(x: x, y: y) {
            n += 1
        }

        return n
    }

    func leftCellVal(x: Int, y: Int) -> Bool {
        let _x = isLeftEdge(x) ? (self.width - 1) : x - 1
        let _y = y
        return isAlive(x: _x, y: _y)
    }

    func rightCellVal(x: Int, y: Int) -> Bool {
        let _x = isRightEdge(x) ? 0 : x + 1
        let _y = y
        return isAlive(x: _x, y: _y)
    }

    func upCellVal(x: Int, y: Int) -> Bool {
        let _x = x
        let _y = isTop(y) ? (self.height - 1) : y - 1
        return isAlive(x: _x, y: _y)
    }

    func downCellVal(x: Int, y: Int) -> Bool {
        let _x = x
        let _y = isBottom(y) ? 0 : y + 1
        return isAlive(x: _x, y: _y)
    }

    func upLeftCellVal(x: Int, y: Int) -> Bool {
        let _x = isLeftEdge(x) ? (self.width - 1) : x - 1
        let _y = isTop(y) ? (self.height - 1) : y - 1
        return isAlive(x: _x, y: _y)
    }

    func upRightCellVal(x: Int, y: Int) -> Bool {
        let _x = isRightEdge(x) ? 0 : x + 1
        let _y = isTop(y) ? (self.height - 1) : y - 1
        return isAlive(x: _x, y: _y)
    }

    func downLeftCellVal(x: Int, y: Int) -> Bool {
        let _x = isLeftEdge(x) ? (self.width - 1) : x - 1
        let _y = isBottom(y) ? 0 : y + 1
        return isAlive(x: _x, y: _y)
    }

    func downRightCellVal(x: Int, y: Int) -> Bool {
        let _x = isRightEdge(x) ? 0 : x + 1
        let _y = isBottom(y) ? 0 : y + 1
        return isAlive(x: _x, y: _y)
    }
}

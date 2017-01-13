//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

class LifeGame {
    var cells: [Bool] = []
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
        self.cells = [Bool](repeating: false, count: width * height)
    }

    // セルに適当なデータをランダムに割りふる
    func random() {
        for i in 0..<(self.width * self.height) {
            cells[i] = arc4random() % 2 == 0
        }
    }

    func next() {
        var newCells: [Bool] = []
        for i in 0..<(self.cells.count) {
            newCells.append(self.nextGeneration(i))
        }
        self.cells = newCells
    }


    // MARK: - Private

    func nextGeneration(_ index: Int) -> Bool {
        if lifegame.isAlive(index) {
            if lifegame.neighbors(index) < 2 || lifegame.neighbors(index) >= 4 {
                // 2未満、4以上の場合は死
                return false
            } else {
                // それ以外はそのまま
                return lifegame.isAlive(index)
            }
        } else {
            if lifegame.neighbors(index) == 3 {
                // 3の場合は誕生
                return true
            } else {
                // それ以外はそのまま
                return lifegame.isAlive(index)
            }
        }
    }

    func isAlive(_ index: Int) -> Bool {
        return cells[index]
    }

    func isTop(_ index: Int) -> Bool {
        return index < width
    }

    func isBottom(_ index: Int) -> Bool {
        let last = width * height - 1
        return index > last - width
    }

    func isLeftEdge(_ index: Int) -> Bool {
        let mod = index % width
        return mod == 0
    }

    func isRightEdge(_ index: Int) -> Bool {
        let mod = index % width
        return mod == (width - 1)
    }

    func neighbors(_ index: Int) -> Int {
        return self.neighborCellIndexes(index).map { self.isAlive($0) }.filter { $0 == true }.count
    }

    func neighborCellIndexes(_ index: Int) -> [Int] {
        let results = [
            leftCellIndex(index),
            rightCellIndex(index),
            upCellIndex(index),
            downCellIndex(index),
            upLeftCellIndex(index),
            upRightCellIndex(index),
            downLeftCellIndex(index),
            downRightCellIndex(index)
        ]

        return Array(Set(results)).sorted()
    }

    // 左のセルのインデックス値
    func leftCellIndex(_ index: Int) -> Int {
        if isLeftEdge(index) {
            return index + self.width - 1
        } else {
            return index - 1
        }
    }

    func rightCellIndex(_ index: Int) -> Int {
        if isRightEdge(index) {
            return index - self.width + 1
        } else {
            return index + 1
        }
    }

    func upCellIndex(_ index: Int) -> Int {
        if isTop(index) {
            return last + index + 1 - self.width
        } else {
            return index - self.width
        }
    }

    func downCellIndex(_ index: Int) -> Int {
        if isBottom(index) {
            return index + self.width - last - 1
        } else {
            return index + self.width
        }
    }

    func upLeftCellIndex(_ index: Int) -> Int {
        let up = upCellIndex(index)
        if isLeftEdge(up) {
            return up + self.width - 1
        } else {
            return up - 1
        }
    }

    func upRightCellIndex(_ index: Int) -> Int {
        let up = upCellIndex(index)
        if isRightEdge(up) {
            return up - (self.width - 1)
        } else {
            return up + 1
        }
    }

    func downLeftCellIndex(_ index: Int) -> Int {
        let down = downCellIndex(index)
        if isLeftEdge(down) {
            return down + (self.width - 1)
        } else {
            return down - 1
        }
    }

    func downRightCellIndex(_ index: Int) -> Int {
        let down = downCellIndex(index)
        if isRightEdge(down) {
            return down - (self.width - 1)
        } else {
            return down + 1
        }
    }
}

//var cells: [[Bool]] = [[false, false], [false, false]]
// var row = [Bool](repeating: false, count: 5)
// var cells = [[Bool]](repeating: row, count: 5)
var cells = [[0, 1, 2], [3, 4, 5]]
cells[0]


var lifegame = LifeGame(width: 4, height: 4)

//var ng = false
//if lifegame.isAlive(0) {
//    if lifegame.neihbors(index) < 2 || lifegame.nighbors(index) > 3 {
//        ng = false
//    } else {
//        ng = true
//    }
//} else {
//    if lifegame.neighbors(index) == 3 {
//        ng = true
//    } else {
//        ng = false
//    }
//}


lifegame.downRightCellIndex(9)
lifegame.downRightCellIndex(10)
lifegame.downRightCellIndex(11)
lifegame.downRightCellIndex(15)

lifegame.downLeftCellIndex(9)
lifegame.downLeftCellIndex(8)
lifegame.downLeftCellIndex(12)

lifegame.upRightCellIndex(10)
lifegame.upRightCellIndex(15)
lifegame.upRightCellIndex(3)

lifegame.upLeftCellIndex(0)
lifegame.upLeftCellIndex(1)
lifegame.upLeftCellIndex(4)
lifegame.upLeftCellIndex(9)







lifegame.neighborCellIndexes(5) == [0, 1, 2, 4, 6, 8, 9, 10]
lifegame.neighborCellIndexes(6) == [1, 2, 3, 5, 7, 9, 10, 11]
lifegame.neighborCellIndexes(8) == [4, 5, 7, 9, 11, 12, 13, 15]
lifegame.neighborCellIndexes(15) == [0, 2, 3, 8, 10, 11, 12, 14]
lifegame.neighborCellIndexes(0) == [1, 3, 4, 5, 7, 12, 13, 15]
lifegame.neighborCellIndexes(3) == [0, 2, 4, 6, 7, 12, 14, 15]





lifegame = LifeGame(width: 3, height: 3)
lifegame.cells = [
    true, false, true,
    false, false, true,
    false, false, false
]
lifegame.nextGeneration(0)
lifegame.nextGeneration(1)
lifegame.nextGeneration(2)
lifegame.nextGeneration(3)
lifegame.nextGeneration(4)
lifegame.next()
lifegame.cells
lifegame.next()
lifegame.cells










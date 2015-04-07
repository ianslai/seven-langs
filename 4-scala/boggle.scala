
class Coords(_row: Int, _col: Int) {
    def row : Int = _row
    def col : Int = _col

    override def toString : String = "(" + row + "," + col + ")"
}

class Board(_size: Int, board: Seq[Seq[Char]]) {

    def size : Int = _size

    def neighbors(coord: Coords) : Seq[Coords] = {
        var result = List[Coords]()
        val valid = (0 until size)
        (-1 to 1).foreach { r =>
            (-1 to 1).foreach { c =>
                val row = r + coord.row
                val col = c + coord.col
                if (valid.contains(row) && valid.contains(col) &&
                    (r != 0 || c != 0)) {
                    result = new Coords(row, col) +: result
                }
            }
        }
        return result
    }

    def letterAt(coord: Coords) : Char = {
        return board(coord.row)(coord.col)
    }

    override def toString : String = board.flatten.mkString("")
}

object Path {
    val EMPTY = new Path(List[Coords]())
}

class Path(_path: List[Coords]) {

    def head : Coords = _path.head
    def size : Int = _path.size

    def contains(coord: Coords) : Boolean = {
        return _path.contains(coord)
    }

    def append(coord: Coords) : Path = {
        return new Path(coord +: _path)
    }

    override def toString : String = "Path(" + _path.mkString(",") + ")"
}

object BoardFactory {
    def create(board: String) : Board = {
        val size = Math.sqrt(board.length).toInt
        if (size * size != board.length) {
            throw new IllegalArgumentException("Board must be square")
        }
        val letters = board.toSeq
        return new Board(size, (0 until size).map(i => letters.slice(i * size, i * size + size)))
    }
}

class WordSearcher(board: Board) {
    def search(word: String): Seq[Path]  = {
        var results = List[Path]()
        (0 until board.size).foreach { row =>
            (0 until board.size).foreach { col =>
                results = results ++ search(new Path(List(new Coords(row, col))), word)
            }
        }
        return results.filter(_ != Path.EMPTY)
    }

    private def search(path: Path, word: String): Seq[Path] = {
        val head = path.head
        if (word(0) != board.letterAt(head)) {
            return List(Path.EMPTY)
        }
        if (word.length == 1) {
            return List(path)
        }

        val restOfWord = word.slice(1, word.length)
        val results = board.neighbors(head).filter(!path.contains(_)).map { neighbor =>
            search(path.append(neighbor), restOfWord)
        }.flatten.filter(_ != Path.EMPTY)

        return results
    }
}

val board = BoardFactory.create("ABCDABAZAOGGAAEL")
val searcher = new WordSearcher(board)

println(searcher.search("BOGGLE"))

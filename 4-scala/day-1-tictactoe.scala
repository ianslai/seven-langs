
object TicTacToeMarkers {
    val noWinner = " "
    val ex = "X"
    val oh = "O"

    val validMarkers = Set(noWinner, ex, oh)
}

class TicTacToeBoard(board: List[String]) {
    val size = 3
    val noWinner = " "

    def this(boardStr: String) {
        this(boardStr.split("").toList)
        val expectedLength = size * size
        if (board.length != expectedLength) {
            throw new IllegalArgumentException("Board must be of length " + expectedLength)
        }
        if (board.toSet != TicTacToeMarkers.validMarkers) {
            throw new IllegalArgumentException("Board must have only valid markers " + TicTacToeMarkers.validMarkers)
        }
    }

    def winner() : String = {
        val rows = (0 until size).map(r => row(r))
        val cols = (0 until size).map(c => col(c))
        val slices = rows ++ cols ++ Seq(diag1(), diag2())
        val sliceWinners = slices.map(slice => sliceWinner(slice))
        val uniqueWinners = sliceWinners.toSet.diff(Set(" "))

        return if (uniqueWinners.size == 1) uniqueWinners.head else noWinner
    }

    // Methods for getting various different slices of the board

    def row(index: Int) : Seq[String] = board.slice(index * size, index * size + size)
    def col(index: Int) : Seq[String] = (0 until size).map(row => board(index + row * size))
    def diag1() : Seq[String] = (0 until size).map(row => board(row * size + row))
    def diag2() : Seq[String] = (0 until size).map(row => board(row * size + (size - 1 - row)))

    // Given a slice, figure out if it has a unique winner
    def sliceWinner(slice : Seq[String]) : String = {
        val set = slice.toSet
        return if (set.size == 1) set.head else noWinner
    }
}

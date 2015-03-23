
// Exercise 1

val stringList = List("alpha", "beta", "gamma", "delta", "epsilon")
val totalSize = stringList.foldLeft(0)((sum, string) => sum + string.length)

println("Total size: " + totalSize)

// Exercise 2

trait Censor {
    def curses(): Map[String, String]

    def censor(string: String): String = {
        var result = string
        curses.foreach { mapping =>
            // Only replace full words
            val curseRegex = ("\\b" + mapping._1 + "\\b").r
            val repl = mapping._2
            result = curseRegex.replaceAllIn(result, repl)
        }
        return result
    }
}

class PuckyBeans extends Censor {

    def curses(): Map[String, String] = {
        return Map("shoot" -> "pucky", "darn" -> "beans")
    }
}

// Exercise 3
import scala.io.Source

object FileMapReader {
    def read(path: String): Map[String, String] = {
        val tuples = Source.fromFile(path).getLines.map { line =>
            val words = line.split("\\s*,\\s*")
            words(0) -> words(1)
        }
        return tuples.toMap
    }
}

class FileCensor(mapping: Map[String, String]) extends Censor {
    def this(path: String) {
        this(FileMapReader.read(path))
    }

    def curses(): Map[String, String] = mapping
}

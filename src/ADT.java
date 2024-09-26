/* 
This Examples shows the encoding of sum types in Java.
Even pattern matching on records in switch expressions is supported. 

Run directly as source file using:
java --enable-preview --source 21 src/ADT.java
*/

/* A sum type, where all values have the same structure.  */
enum Paradigm { Imperative, Declarative }

/* A `sum type` where the values can differ in structure. 
`sealed` means that no other than the explicitly 
permitted implementations are allowed. */
sealed interface Language permits Java, Haskell {}
record Java(int version, boolean openLicense) implements Language {}
record Haskell(String ghcVersion) implements Language {}

void main() { 
    Language l = new Haskell("8.2.8");
    var res = switch (l) {
        case Java(var v, _) -> "Java: " + v;
        case Haskell(var h) -> "Haskell: " + h;
    };
    System.out.println(res);
}

/* Commenting out `case Haskell` leads to the following error:
 src/ADT.java:11: error: the switch expression does not cover all possible input values
    var res = switch (l) {
              ^
*/
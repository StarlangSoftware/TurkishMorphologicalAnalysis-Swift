import XCTest
@testable import MorphologicalAnalysis
@testable import DataStructure

final class MorphologicalParseTest: XCTestCase {
    
    var parse1: MorphologicalParse = MorphologicalParse()
    var parse2: MorphologicalParse = MorphologicalParse()
    var parse3: MorphologicalParse = MorphologicalParse()
    var parse4: MorphologicalParse = MorphologicalParse()
    var parse5: MorphologicalParse = MorphologicalParse()
    var parse6: MorphologicalParse = MorphologicalParse()
    var parse7: MorphologicalParse = MorphologicalParse()
    var parse8: MorphologicalParse = MorphologicalParse()
    var parse9: MorphologicalParse = MorphologicalParse()

    override func setUp() {
        parse1 = MorphologicalParse(parse: "bayan+NOUN+A3SG+PNON+NOM")
        parse2 = MorphologicalParse(parse: "yaşa+VERB+POS^DB+ADJ+PRESPART")
        parse3 = MorphologicalParse(parse: "serbest+ADJ")
        parse4 = MorphologicalParse(parse: "et+VERB^DB+VERB+PASS^DB+VERB+ABLE+NEG+AOR+A3SG")
        parse5 = MorphologicalParse(parse: "sür+VERB^DB+VERB+CAUS^DB+VERB+PASS+POS^DB+NOUN+INF2+A3SG+P3SG+NOM")
        parse6 = MorphologicalParse(parse: "değiş+VERB^DB+VERB+CAUS^DB+VERB+PASS+POS^DB+VERB+ABLE+AOR^DB+ADJ+ZERO")
        parse7 = MorphologicalParse(parse: "iyi+ADJ^DB+VERB+BECOME^DB+VERB+CAUS^DB+VERB+PASS+POS^DB+VERB+ABLE^DB+NOUN+INF2+A3PL+P3PL+ABL")
        parse8 = MorphologicalParse(parse: "değil+ADJ^DB+VERB+ZERO+PAST+A3SG")
        parse9 = MorphologicalParse(parse: "hazır+ADJ^DB+VERB+ZERO+PAST+A3SG")
    }
    
    func testGetTransitionList() {
        XCTAssertEqual("NOUN+A3SG+PNON+NOM", parse1.getTransitionList())
        XCTAssertEqual("VERB+POS+ADJ+PRESPART", parse2.getTransitionList())
        XCTAssertEqual("ADJ", parse3.getTransitionList())
        XCTAssertEqual("VERB+VERB+PASS+VERB+ABLE+NEG+AOR+A3SG", parse4.getTransitionList())
        XCTAssertEqual("VERB+VERB+CAUS+VERB+PASS+POS+NOUN+INF2+A3SG+P3SG+NOM", parse5.getTransitionList())
        XCTAssertEqual("VERB+VERB+CAUS+VERB+PASS+POS+VERB+ABLE+AOR+ADJ+ZERO", parse6.getTransitionList())
        XCTAssertEqual("ADJ+VERB+BECOME+VERB+CAUS+VERB+PASS+POS+VERB+ABLE+NOUN+INF2+A3PL+P3PL+ABL", parse7.getTransitionList())
        XCTAssertEqual("ADJ+VERB+ZERO+PAST+A3SG", parse8.getTransitionList())
    }

    func testGetTag() {
        XCTAssertEqual("A3SG", parse1.getTag(index: 2))
        XCTAssertEqual("PRESPART", parse2.getTag(index: 4))
        XCTAssertEqual("serbest", parse3.getTag(index: 0))
        XCTAssertEqual("AOR", parse4.getTag(index: 7))
        XCTAssertEqual("P3SG", parse5.getTag(index: 10))
        XCTAssertEqual("ABLE", parse6.getTag(index: 8))
        XCTAssertEqual("ABL", parse7.getTag(index: 15))
    }

    func testGetTagSize() {
        XCTAssertEqual(5, parse1.tagSize())
        XCTAssertEqual(5, parse2.tagSize())
        XCTAssertEqual(2, parse3.tagSize())
        XCTAssertEqual(9, parse4.tagSize())
        XCTAssertEqual(12, parse5.tagSize())
        XCTAssertEqual(12, parse6.tagSize())
        XCTAssertEqual(16, parse7.tagSize())
        XCTAssertEqual(6, parse8.tagSize())
    }

    func testSize() {
        XCTAssertEqual(1, parse1.size())
        XCTAssertEqual(2, parse2.size())
        XCTAssertEqual(1, parse3.size())
        XCTAssertEqual(3, parse4.size())
        XCTAssertEqual(4, parse5.size())
        XCTAssertEqual(5, parse6.size())
        XCTAssertEqual(6, parse7.size())
        XCTAssertEqual(2, parse8.size())
    }

    func testGetRootPos() {
        XCTAssertEqual("NOUN", parse1.getRootPos())
        XCTAssertEqual("VERB", parse2.getRootPos())
        XCTAssertEqual("ADJ", parse3.getRootPos())
        XCTAssertEqual("VERB", parse4.getRootPos())
        XCTAssertEqual("VERB", parse5.getRootPos())
        XCTAssertEqual("VERB", parse6.getRootPos())
        XCTAssertEqual("ADJ", parse7.getRootPos())
        XCTAssertEqual("ADJ", parse8.getRootPos())
    }

    func testGetPos() {
        XCTAssertEqual("NOUN", parse1.getPos())
        XCTAssertEqual("ADJ", parse2.getPos())
        XCTAssertEqual("ADJ", parse3.getPos())
        XCTAssertEqual("VERB", parse4.getPos())
        XCTAssertEqual("NOUN", parse5.getPos())
        XCTAssertEqual("ADJ", parse6.getPos())
        XCTAssertEqual("NOUN", parse7.getPos())
        XCTAssertEqual("VERB", parse8.getPos())
    }

    func testGetWordWithPos() {
        XCTAssertEqual("bayan+NOUN", parse1.getWordWithPos().getName())
        XCTAssertEqual("yaşa+VERB", parse2.getWordWithPos().getName())
        XCTAssertEqual("serbest+ADJ", parse3.getWordWithPos().getName())
        XCTAssertEqual("et+VERB", parse4.getWordWithPos().getName())
        XCTAssertEqual("sür+VERB", parse5.getWordWithPos().getName())
        XCTAssertEqual("değiş+VERB", parse6.getWordWithPos().getName())
        XCTAssertEqual("iyi+ADJ", parse7.getWordWithPos().getName())
        XCTAssertEqual("değil+ADJ", parse8.getWordWithPos().getName())
    }

    func testLastIGContainsCase() {
        XCTAssertEqual("NOM", parse1.lastIGContainsCase())
        XCTAssertEqual("NULL", parse2.lastIGContainsCase())
        XCTAssertEqual("NULL", parse3.lastIGContainsCase())
        XCTAssertEqual("NULL", parse4.lastIGContainsCase())
        XCTAssertEqual("NOM", parse5.lastIGContainsCase())
        XCTAssertEqual("NULL", parse6.lastIGContainsCase())
        XCTAssertEqual("ABL", parse7.lastIGContainsCase())
    }

    func testLastIGContainsPossessive() {
        XCTAssertFalse(parse1.lastIGContainsPossessive())
        XCTAssertFalse(parse2.lastIGContainsPossessive())
        XCTAssertFalse(parse3.lastIGContainsPossessive())
        XCTAssertFalse(parse4.lastIGContainsPossessive())
        XCTAssertTrue(parse5.lastIGContainsPossessive())
        XCTAssertFalse(parse6.lastIGContainsPossessive())
        XCTAssertTrue(parse7.lastIGContainsPossessive())
    }

    func testIsPlural() {
        XCTAssertFalse(parse1.isPlural())
        XCTAssertFalse(parse2.isPlural())
        XCTAssertFalse(parse3.isPlural())
        XCTAssertFalse(parse4.isPlural())
        XCTAssertFalse(parse5.isPlural())
        XCTAssertFalse(parse6.isPlural())
        XCTAssertTrue(parse7.isPlural())
    }

    func testIsAuxiliary() {
        XCTAssertFalse(parse1.isAuxiliary())
        XCTAssertFalse(parse2.isAuxiliary())
        XCTAssertFalse(parse3.isAuxiliary())
        XCTAssertTrue(parse4.isAuxiliary())
        XCTAssertFalse(parse5.isAuxiliary())
        XCTAssertFalse(parse6.isAuxiliary())
        XCTAssertFalse(parse7.isAuxiliary())
    }

    func testIsNoun() {
        XCTAssertTrue(parse1.isNoun())
        XCTAssertTrue(parse5.isNoun())
        XCTAssertTrue(parse7.isNoun())
    }

    func testIsAdjective() {
        XCTAssertTrue(parse2.isAdjective())
        XCTAssertTrue(parse3.isAdjective())
        XCTAssertTrue(parse6.isAdjective())
    }

    func testIsVerb() {
        XCTAssertTrue(parse4.isVerb())
        XCTAssertTrue(parse8.isVerb())
    }

    func testIsRootVerb() {
        XCTAssertTrue(parse2.isRootVerb())
        XCTAssertTrue(parse4.isRootVerb())
        XCTAssertTrue(parse5.isRootVerb())
        XCTAssertTrue(parse6.isRootVerb())
    }

    func testGetTreePos() {
        XCTAssertEqual("NP", parse1.getTreePos())
        XCTAssertEqual("ADJP", parse2.getTreePos())
        XCTAssertEqual("ADJP", parse3.getTreePos())
        XCTAssertEqual("VP", parse4.getTreePos())
        XCTAssertEqual("NP", parse5.getTreePos())
        XCTAssertEqual("ADJP", parse6.getTreePos())
        XCTAssertEqual("NP", parse7.getTreePos())
        XCTAssertEqual("NEG", parse8.getTreePos())
        XCTAssertEqual("NOMP", parse9.getTreePos())
    }

    static var allTests = [
        ("testExample1", testGetTransitionList),
        ("testExample2", testGetTag),
        ("testExample3", testGetTagSize),
        ("testExample4", testSize),
        ("testExample5", testGetRootPos),
        ("testExample6", testGetPos),
        ("testExample7", testGetWordWithPos),
        ("testExample8", testLastIGContainsCase),
        ("testExample9", testLastIGContainsPossessive),
        ("testExample10", testIsPlural),
        ("testExample11", testIsAuxiliary),
        ("testExample12", testIsNoun),
        ("testExample13", testIsAdjective),
        ("testExample14", testIsVerb),
        ("testExample15", testIsRootVerb),
        ("testExample16", testGetTreePos),
    ]
}

import XCTest
@testable import MorphologicalAnalysis
@testable import Dictionary

final class FsmParseListTest: XCTestCase {

    var fsm: FsmMorphologicalAnalyzer = FsmMorphologicalAnalyzer()
    var parse1: FsmParseList = FsmParseList(fsmParses: [])
    var parse2: FsmParseList = FsmParseList(fsmParses: [])
    var parse3: FsmParseList = FsmParseList(fsmParses: [])
    var parse4: FsmParseList = FsmParseList(fsmParses: [])
    var parse5: FsmParseList = FsmParseList(fsmParses: [])
    var parse6: FsmParseList = FsmParseList(fsmParses: [])
    var parse7: FsmParseList = FsmParseList(fsmParses: [])
    var parse8: FsmParseList = FsmParseList(fsmParses: [])
    var parse9: FsmParseList = FsmParseList(fsmParses: [])
    var parse10: FsmParseList = FsmParseList(fsmParses: [])
    var parse11: FsmParseList = FsmParseList(fsmParses: [])
    var parse12: FsmParseList = FsmParseList(fsmParses: [])
    var parse13: FsmParseList = FsmParseList(fsmParses: [])
    var parse14: FsmParseList = FsmParseList(fsmParses: [])

    override func setUp(){
        parse1 = fsm.morphologicalAnalysis(surfaceForm: "açılır")
        parse2 = fsm.morphologicalAnalysis(surfaceForm: "koparılarak")
        parse3 = fsm.morphologicalAnalysis(surfaceForm: "toplama")
        parse4 = fsm.morphologicalAnalysis(surfaceForm: "değerlendirmede")
        parse5 = fsm.morphologicalAnalysis(surfaceForm: "soruşturmasının")
        parse6 = fsm.morphologicalAnalysis(surfaceForm: "karşılaştırmalı")
        parse7 = fsm.morphologicalAnalysis(surfaceForm: "esaslarını")
        parse8 = fsm.morphologicalAnalysis(surfaceForm: "güçleriyle")
        parse9 = fsm.morphologicalAnalysis(surfaceForm: "bulmayacakları")
        parse10 = fsm.morphologicalAnalysis(surfaceForm: "kitabı")
        parse11 = fsm.morphologicalAnalysis(surfaceForm: "kitapları")
        parse12 = fsm.morphologicalAnalysis(surfaceForm: "o")
        parse13 = fsm.morphologicalAnalysis(surfaceForm: "arabası")
        parse14 = fsm.morphologicalAnalysis(surfaceForm: "sana")
    }
    
    func testSize() {
        XCTAssertEqual(2, parse1.size())
        XCTAssertEqual(2, parse2.size())
        XCTAssertEqual(6, parse3.size())
        XCTAssertEqual(4, parse4.size())
        XCTAssertEqual(5, parse5.size())
        XCTAssertEqual(12, parse6.size())
        XCTAssertEqual(8, parse7.size())
        XCTAssertEqual(6, parse8.size())
        XCTAssertEqual(5, parse9.size())
        XCTAssertEqual(4, parse14.size())
    }

    func testRootWords() {
        XCTAssertEqual("aç", parse1.rootWords())
        XCTAssertEqual("kop$kopar", parse2.rootWords())
        XCTAssertEqual("topla$toplam$toplama", parse3.rootWords())
        XCTAssertEqual("değer$değerlen$değerlendir$değerlendirme", parse4.rootWords())
        XCTAssertEqual("sor$soru$soruş$soruştur$soruşturma", parse5.rootWords())
        XCTAssertEqual("karşı$karşıla$karşılaş$karşılaştır$karşılaştırma$karşılaştırmalı", parse6.rootWords())
        XCTAssertEqual("esas", parse7.rootWords())
        XCTAssertEqual("güç", parse8.rootWords())
        XCTAssertEqual("bul", parse9.rootWords())
    }

    func testGetParseWithLongestRootWord() {
        XCTAssertEqual("kopar", parse2.getParseWithLongestRootWord().root.getName())
        XCTAssertEqual("toplama", parse3.getParseWithLongestRootWord().root.getName())
        XCTAssertEqual("değerlendirme", parse4.getParseWithLongestRootWord().root.getName())
        XCTAssertEqual("soruşturma", parse5.getParseWithLongestRootWord().root.getName())
        XCTAssertEqual("karşılaştırmalı", parse6.getParseWithLongestRootWord().root.getName())
    }

    func testReduceToParsesWithSameRootAndPos() {
        parse2.reduceToParsesWithSameRootAndPos(currentWithPos: Word(name: "kop+VERB"))
        XCTAssertEqual(1, parse2.size())
        parse3.reduceToParsesWithSameRootAndPos(currentWithPos: Word(name: "topla+VERB"))
        XCTAssertEqual(2, parse3.size())
        parse6.reduceToParsesWithSameRootAndPos(currentWithPos: Word(name: "karşıla+VERB"))
        XCTAssertEqual(2, parse6.size())
    }

    func testReduceToParsesWithSameRoot() {
        parse2.reduceToParsesWithSameRoot(currentRoot: "kop")
        XCTAssertEqual(1, parse2.size())
        parse3.reduceToParsesWithSameRoot(currentRoot: "topla")
        XCTAssertEqual(3, parse3.size())
        parse6.reduceToParsesWithSameRoot(currentRoot: "karşı")
        XCTAssertEqual(4, parse6.size())
        parse7.reduceToParsesWithSameRoot(currentRoot: "esas")
        XCTAssertEqual(8, parse7.size())
        parse8.reduceToParsesWithSameRoot(currentRoot: "güç")
        XCTAssertEqual(6, parse8.size())
    }

    func testConstructParseListForDifferentRootWithPos() {
        XCTAssertEqual(1, parse1.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(2, parse2.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(5, parse3.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(4, parse4.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(5, parse5.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(7, parse6.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(2, parse7.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(2, parse8.constructParseListForDifferentRootWithPos().count)
        XCTAssertEqual(1, parse9.constructParseListForDifferentRootWithPos().count)
    }

    func testParsesWithoutPrefixAndSuffix() {
        XCTAssertEqual("P3SG+NOM$PNON+ACC", parse10.parsesWithoutPrefixAndSuffix())
        XCTAssertEqual("A3PL+P3PL+NOM$A3PL+P3SG+NOM$A3PL+PNON+ACC$A3SG+P3PL+NOM", parse11.parsesWithoutPrefixAndSuffix())
        XCTAssertEqual("DET$PRON+DEMONSP+A3SG+PNON+NOM$PRON+PERS+A3SG+PNON+NOM", parse12.parsesWithoutPrefixAndSuffix())
        XCTAssertEqual("NOUN+A3SG+P3SG+NOM$NOUN^DB+ADJ+ALMOST", parse13.parsesWithoutPrefixAndSuffix())
    }

    static var allTests = [
        ("testExample1", testSize),
        ("testExample2", testRootWords),
        ("testExample3", testGetParseWithLongestRootWord),
        ("testExample4", testReduceToParsesWithSameRootAndPos),
        ("testExample5", testReduceToParsesWithSameRoot),
        ("testExample6", testConstructParseListForDifferentRootWithPos),
        ("testExample7", testParsesWithoutPrefixAndSuffix),
    ]
}

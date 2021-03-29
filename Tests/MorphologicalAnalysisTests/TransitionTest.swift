import XCTest
@testable import MorphologicalAnalysis
@testable import DataStructure

final class TransitionTest: XCTestCase {
    
    var fsm: FsmMorphologicalAnalyzer = FsmMorphologicalAnalyzer()

    func testNumberWithAccusative() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "2'yi").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "2'i").size())
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "5'i").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "9'u").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "10'u").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "30'u").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "3'ü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "4'ü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "100'ü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "6'yı").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "6'ı").size())
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "40'ı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "60'ı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "90'ı").size() != 0)
    }

    func testNumberWithDative() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "6'ya").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "6'a").size())
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "9'a").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "10'a").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "30'a").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "40'a").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "60'a").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "90'a").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "2'ye").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "2'e").size())
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "8'e").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "5'e").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "4'e").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "1'e").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "3'e").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "7'ye").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "7'e").size())
    }

    func testPresentTense() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "büyülüyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "bölümlüyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "buğuluyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "bulguluyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "açıklıyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "çalkalıyor").size() != 0)
    }

    func testA() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "alkole").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "anormale").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "sakala").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kabala").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "faika").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "halika").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kediye").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "eve").size() != 0)
    }

    func testC() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "gripçi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "güllaççı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "gülütçü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "gülükçü").size() != 0)
    }

    func testSH() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "altışar").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "yedişer").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "üçer").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "beşer").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "dörder").size() != 0)
    }

    func testNumberWithD() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "1'di").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "2'ydi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "3'tü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "4'tü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "5'ti").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "6'ydı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "7'ydi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "8'di").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "9'du").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "30'du").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "40'tı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "60'tı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "70'ti").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "50'ydi").size() != 0)
    }

    func testD() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "koştu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kitaptı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kaçtı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "evdi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "fraktı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "sattı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "aftı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kesti").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ahtı").size() != 0)
    }

    func testExceptions() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "bununla").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "buyla").size())
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "onunla").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "şununla").size() != 0)
        XCTAssertEqual(0, fsm.morphologicalAnalysis(surfaceForm: "şuyla").size())
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "bana").size() != 0)
    }

    func testVowelEChangesToIDuringYSuffixation() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "diyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "yiyor").size() != 0)
    }

    func testLastIdropsDuringPassiveSuffixation() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "yoğruldu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "buyruldu").size() != 0)
    }

    func testShowsSuRegularities() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "karasuyu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "suyu").size() != 0)
    }

    func testDuplicatesDuringSuffixation() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "tıbbı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ceddi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "zıddı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "serhaddi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "fenni").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "haddi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "hazzı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "şakkı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "şakı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "halli").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "hali").size() != 0)
    }

    func testLastIdropsDuringSuffixation() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "hizbi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kaybı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ahdi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "nesci").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "zehri").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "zikri").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "metni").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "metini").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "katli").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "katili").size() != 0)
    }

    func testNounSoftenDuringSuffixation() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "adabı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "amibi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "armudu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ağacı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "akacı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "arkeoloğu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "filoloğu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ahengi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "küngü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "kitaplığı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "küllüğü").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "adedi").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "adeti").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ağıdı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ağıtı").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "anotu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "anodu").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Kuzguncuk'u").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Leylak'ı").size() != 0)
    }

    func testVerbSoftenDuringSuffixation() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "cezbediyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "ediyor").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "bahsediyor").size() != 0)
    }

    static var allTests = [
        ("testExample1", testNumberWithAccusative),
        ("testExample2", testNumberWithDative),
        ("testExample3", testPresentTense),
        ("testExample4", testA),
        ("testExample5", testC),
        ("testExample6", testSH),
        ("testExample7", testNumberWithD),
        ("testExample8", testD),
        ("testExample9", testExceptions),
        ("testExample10", testVowelEChangesToIDuringYSuffixation),
        ("testExample11", testLastIdropsDuringPassiveSuffixation),
        ("testExample12", testShowsSuRegularities),
        ("testExample13", testDuplicatesDuringSuffixation),
        ("testExample14", testLastIdropsDuringSuffixation),
        ("testExample15", testNounSoftenDuringSuffixation),
        ("testExample16", testVerbSoftenDuringSuffixation),
    ]
}

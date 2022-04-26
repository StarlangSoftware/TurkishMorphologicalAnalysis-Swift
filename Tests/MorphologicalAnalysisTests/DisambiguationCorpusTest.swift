import XCTest
@testable import MorphologicalAnalysis

final class DisambiguationCorpusTest: XCTestCase {
    
    func testCorpus() {
        let corpus : DisambiguationCorpus = DisambiguationCorpus(fileName: "penntreebank")
        XCTAssertEqual(19109, corpus.sentenceCount())
        XCTAssertEqual(170211, corpus.numberOfWords())
    }

    static var allTests = [
        ("testExample1", testCorpus),
    ]
}

import XCTest
@testable import MorphologicalAnalysis
@testable import DataStructure

final class InflectionalGroupTest: XCTestCase {
    
    func testGetMorphologicalTag() {
        XCTAssertEqual(InflectionalGroup.getMorphologicalTag(tag: "noun"), MorphologicalTag.NOUN)
        XCTAssertEqual(InflectionalGroup.getMorphologicalTag(tag: "without"), MorphologicalTag.WITHOUT)
        XCTAssertEqual(InflectionalGroup.getMorphologicalTag(tag: "interj"), MorphologicalTag.INTERJECTION)
        XCTAssertEqual(InflectionalGroup.getMorphologicalTag(tag: "inf2"), MorphologicalTag.INFINITIVE2)
    }

    func testSize() {
        let inflectionalGroup1: InflectionalGroup = InflectionalGroup(IG: "ADJ")
        XCTAssertEqual(1, inflectionalGroup1.size())
        let inflectionalGroup2: InflectionalGroup = InflectionalGroup(IG: "ADJ+JUSTLIKE")
        XCTAssertEqual(2, inflectionalGroup2.size())
        let inflectionalGroup3: InflectionalGroup = InflectionalGroup(IG: "ADJ+FUTPART+P1PL")
        XCTAssertEqual(3, inflectionalGroup3.size())
        let inflectionalGroup4: InflectionalGroup = InflectionalGroup(IG: "NOUN+A3PL+P1PL+ABL")
        XCTAssertEqual(4, inflectionalGroup4.size())
        let inflectionalGroup5: InflectionalGroup = InflectionalGroup(IG: "ADJ+WITH+A3SG+P3SG+ABL")
        XCTAssertEqual(5, inflectionalGroup5.size())
        let inflectionalGroup6: InflectionalGroup = InflectionalGroup(IG: "VERB+ABLE+NEG+FUT+A3PL+COP")
        XCTAssertEqual(6, inflectionalGroup6.size())
        let inflectionalGroup7: InflectionalGroup = InflectionalGroup(IG: "VERB+ABLE+NEG+AOR+A3SG+COND+A1SG")
        XCTAssertEqual(7, inflectionalGroup7.size())
    }

    func testContainsCase() {
        let inflectionalGroup1: InflectionalGroup = InflectionalGroup(IG: "NOUN+ACTOF+A3PL+P1PL+NOM")
        XCTAssertNotNil(inflectionalGroup1.containsCase())
        let inflectionalGroup2: InflectionalGroup = InflectionalGroup(IG: "NOUN+A3PL+P1PL+ACC")
        XCTAssertNotNil(inflectionalGroup2.containsCase())
        let inflectionalGroup3: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P3PL+DAT")
        XCTAssertNotNil(inflectionalGroup3.containsCase())
        let inflectionalGroup4: InflectionalGroup = InflectionalGroup(IG: "PRON+QUANTP+A1PL+P1PL+LOC")
        XCTAssertNotNil(inflectionalGroup4.containsCase())
        let inflectionalGroup5: InflectionalGroup = InflectionalGroup(IG: "NOUN+AGT+A3SG+P2SG+ABL")
        XCTAssertNotNil(inflectionalGroup5.containsCase())
    }

    func testContainsPlural() {
        let inflectionalGroup1: InflectionalGroup = InflectionalGroup(IG: "VERB+NEG+NECES+A1PL")
        XCTAssertTrue(inflectionalGroup1.containsPlural())
        let inflectionalGroup2: InflectionalGroup = InflectionalGroup(IG: "PRON+PERS+A2PL+PNON+NOM")
        XCTAssertTrue(inflectionalGroup2.containsPlural())
        let inflectionalGroup3: InflectionalGroup = InflectionalGroup(IG: "NOUN+DIM+A3PL+P2SG+GEN")
        XCTAssertTrue(inflectionalGroup3.containsPlural())
        let inflectionalGroup4: InflectionalGroup = InflectionalGroup(IG: "NOUN+A3PL+P1PL+GEN")
        XCTAssertTrue(inflectionalGroup4.containsPlural())
        let inflectionalGroup5: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P2PL+INS")
        XCTAssertTrue(inflectionalGroup5.containsPlural())
        let inflectionalGroup6: InflectionalGroup = InflectionalGroup(IG: "PRON+QUANTP+A3PL+P3PL+LOC")
        XCTAssertTrue(inflectionalGroup6.containsPlural())
    }

    func testContainsTag() {
        let inflectionalGroup1: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P1SG+NOM")
        XCTAssertTrue(inflectionalGroup1.containsTag(tag: MorphologicalTag.NOUN))
        let inflectionalGroup2: InflectionalGroup = InflectionalGroup(IG: "NOUN+AGT+A3PL+P2SG+ABL")
        XCTAssertTrue(inflectionalGroup2.containsTag(tag: MorphologicalTag.AGENT))
        let inflectionalGroup3: InflectionalGroup = InflectionalGroup(IG: "NOUN+INF2+A3PL+P3SG+NOM")
        XCTAssertTrue(inflectionalGroup3.containsTag(tag: MorphologicalTag.NOMINATIVE))
        let inflectionalGroup4: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P1PL+ACC")
        XCTAssertTrue(inflectionalGroup4.containsTag(tag: MorphologicalTag.ZERO))
        let inflectionalGroup5: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P2PL+INS")
        XCTAssertTrue(inflectionalGroup5.containsTag(tag: MorphologicalTag.P2PL))
        let inflectionalGroup6: InflectionalGroup = InflectionalGroup(IG: "PRON+QUANTP+A3PL+P3PL+LOC")
        XCTAssertTrue(inflectionalGroup6.containsTag(tag: MorphologicalTag.QUANTITATIVEPRONOUN))
    }

    func testContainsPossessive() {
        let inflectionalGroup1: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P1SG+NOM")
        XCTAssertTrue(inflectionalGroup1.containsPossessive())
        let inflectionalGroup2: InflectionalGroup = InflectionalGroup(IG: "NOUN+AGT+A3PL+P2SG+ABL")
        XCTAssertTrue(inflectionalGroup2.containsPossessive())
        let inflectionalGroup3: InflectionalGroup = InflectionalGroup(IG: "NOUN+INF2+A3PL+P3SG+NOM")
        XCTAssertTrue(inflectionalGroup3.containsPossessive())
        let inflectionalGroup4: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P1PL+ACC")
        XCTAssertTrue(inflectionalGroup4.containsPossessive())
        let inflectionalGroup5: InflectionalGroup = InflectionalGroup(IG: "NOUN+ZERO+A3SG+P2PL+INS")
        XCTAssertTrue(inflectionalGroup5.containsPossessive())
        let inflectionalGroup6: InflectionalGroup = InflectionalGroup(IG: "PRON+QUANTP+A3PL+P3PL+LOC")
        XCTAssertTrue(inflectionalGroup6.containsPossessive())
    }

    static var allTests = [
        ("testExample1", testGetMorphologicalTag),
        ("testExample2", testSize),
        ("testExample3", testContainsCase),
        ("testExample4", testContainsPlural),
        ("testExample5", testContainsTag),
        ("testExample6", testContainsPossessive),
    ]
}

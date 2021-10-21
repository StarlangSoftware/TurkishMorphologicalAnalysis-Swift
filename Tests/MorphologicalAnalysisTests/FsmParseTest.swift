import XCTest
@testable import MorphologicalAnalysis
@testable import Dictionary

final class FsmParseTest: XCTestCase {

    var fsm: FsmMorphologicalAnalyzer = FsmMorphologicalAnalyzer()
    var parse1: FsmParse = FsmParse(root: Word(name: ""))
    var parse2: FsmParse = FsmParse(root: Word(name: ""))
    var parse3: FsmParse = FsmParse(root: Word(name: ""))
    var parse4: FsmParse = FsmParse(root: Word(name: ""))
    var parse5: FsmParse = FsmParse(root: Word(name: ""))
    var parse6: FsmParse = FsmParse(root: Word(name: ""))
    var parse7: FsmParse = FsmParse(root: Word(name: ""))
    var parse8: FsmParse = FsmParse(root: Word(name: ""))
    var parse9: FsmParse = FsmParse(root: Word(name: ""))
    var parse10: FsmParse = FsmParse(root: Word(name: ""))

    override func setUp(){
        parse1 = fsm.morphologicalAnalysis(surfaceForm: "açılır").getFsmParse(index: 0)
        parse2 = fsm.morphologicalAnalysis(surfaceForm: "koparılarak").getFsmParse(index: 0)
        parse3 = fsm.morphologicalAnalysis(surfaceForm: "toplama").getFsmParse(index: 0)
        parse4 = fsm.morphologicalAnalysis(surfaceForm: "değerlendirmede").getFsmParse(index: 0)
        parse5 = fsm.morphologicalAnalysis(surfaceForm: "soruşturmasının").getFsmParse(index: 0)
        parse6 = fsm.morphologicalAnalysis(surfaceForm: "karşılaştırmalı").getFsmParse(index: 0)
        parse7 = fsm.morphologicalAnalysis(surfaceForm: "esaslarını").getFsmParse(index: 0)
        parse8 = fsm.morphologicalAnalysis(surfaceForm: "güçleriyle").getFsmParse(index: 0)
        parse9 = fsm.morphologicalAnalysis(surfaceForm: "bulmayacakları").getFsmParse(index: 0)
        parse10 = fsm.morphologicalAnalysis(surfaceForm: "mü").getFsmParse(index: 0)
    }
    
    func testGetLastLemmaWithTag() {
        XCTAssertEqual("açıl", parse1.getLastLemmaWithTag(pos: "VERB"))
        XCTAssertEqual("koparıl", parse2.getLastLemmaWithTag(pos: "VERB"))
        XCTAssertEqual("değerlendir", parse4.getLastLemmaWithTag(pos: "VERB"))
        XCTAssertEqual("soruştur", parse5.getLastLemmaWithTag(pos: "VERB"))
        XCTAssertEqual("karşı", parse6.getLastLemmaWithTag(pos: "ADJ"))
    }

    func testGetLastLemma() {
        XCTAssertEqual("açıl", parse1.getLastLemma())
        XCTAssertEqual("koparılarak", parse2.getLastLemma())
        XCTAssertEqual("değerlendirme", parse4.getLastLemma())
        XCTAssertEqual("soruşturma", parse5.getLastLemma())
        XCTAssertEqual("karşılaştır", parse6.getLastLemma())
    }

    func testGetTransitionList() {
        XCTAssertEqual("aç+VERB^DB+VERB+PASS+POS+AOR+A3SG", parse1.description())
        XCTAssertEqual("kop+VERB^DB+VERB+CAUS^DB+VERB+PASS+POS^DB+ADV+BYDOINGSO", parse2.description())
        XCTAssertEqual("topla+NOUN+A3SG+P1SG+DAT", parse3.description())
        XCTAssertEqual("değer+NOUN+A3SG+PNON+NOM^DB+VERB+ACQUIRE^DB+VERB+CAUS+POS^DB+NOUN+INF2+A3SG+PNON+LOC", parse4.description())
        XCTAssertEqual("sor+VERB+RECIP^DB+VERB+CAUS+POS^DB+NOUN+INF2+A3SG+P3SG+GEN", parse5.description())
        XCTAssertEqual("karşı+ADJ^DB+VERB+BECOME^DB+VERB+CAUS+POS+NECES+A3SG", parse6.description())
        XCTAssertEqual("esas+ADJ^DB+NOUN+ZERO+A3PL+P2SG+ACC", parse7.description())
        XCTAssertEqual("güç+ADJ^DB+NOUN+ZERO+A3PL+P3PL+INS", parse8.description())
        XCTAssertEqual("bul+VERB+NEG^DB+ADJ+FUTPART+P3PL", parse9.description())
        XCTAssertEqual("mi+QUES+PRES+A3SG", parse10.description())
    }

    func testWithList() {
        XCTAssertEqual("aç+Hl+Hr", parse1.withList())
        XCTAssertEqual("kop+Ar+Hl+yArAk", parse2.withList())
        XCTAssertEqual("topla+Hm+yA", parse3.withList())
        XCTAssertEqual("değer+lAn+DHr+mA+DA", parse4.withList())
        XCTAssertEqual("sor+Hs+DHr+mA+sH+nHn", parse5.withList())
        XCTAssertEqual("karşı+lAs+DHr+mAlH", parse6.withList())
        XCTAssertEqual("esas+lAr+Hn+yH", parse7.withList())
        XCTAssertEqual("güç+lArH+ylA", parse8.withList())
        XCTAssertEqual("bul+mA+yAcAk+lArH", parse9.withList())
    }

    func testSuffixList() {
        XCTAssertEqual("VerbalRoot(F5PR)(aç)+PassiveHl(açıl)+OtherTense2(açılır)", parse1.suffixList())
        XCTAssertEqual("VerbalRoot(F1P1)(kop)+CausativeAr(kopar)+PassiveHl(koparıl)+Adverb1(koparılarak)", parse2.suffixList())
        XCTAssertEqual("NominalRoot(topla)+Possessive(toplam)+Case1(toplama)", parse3.suffixList())
        XCTAssertEqual("NominalRoot(değer)+VerbalRoot(F5PR)(değerlen)+CausativeDHr(değerlendir)+NominalRoot(değerlendirme)+Case1(değerlendirmede)", parse4.suffixList())
        XCTAssertEqual("VerbalRoot(F5PR)(sor)+Reciprocal(soruş)+CausativeDHr(soruştur)+NominalRoot(soruşturma)+Possessive3(soruşturması)+Case1(soruşturmasının)", parse5.suffixList())
        XCTAssertEqual("AdjectiveRoot(karşı)+VerbalRoot(F5PR)(karşılaş)+CausativeDHr(karşılaştır)+OtherTense(karşılaştırmalı)", parse6.suffixList())
        XCTAssertEqual("AdjectiveRoot(esas)+Plural(esaslar)+Possessive(esasların)+AccusativeNoun(esaslarını)", parse7.suffixList())
        XCTAssertEqual("AdjectiveRoot(güç)+Possesive3(güçleri)+Case1(güçleriyle)", parse8.suffixList())
        XCTAssertEqual("VerbalRoot(F5PW)(bul)+Negativema(bulma)+AdjectiveParticiple(bulmayacak)+Adjective(bulmayacakları)", parse9.suffixList())
    }


    static var allTests = [
        ("testExample1", testGetLastLemmaWithTag),
        ("testExample2", testGetLastLemma),
        ("testExample3", testGetTransitionList),
        ("testExample4", testWithList),
        ("testExample5", testSuffixList),
    ]
}

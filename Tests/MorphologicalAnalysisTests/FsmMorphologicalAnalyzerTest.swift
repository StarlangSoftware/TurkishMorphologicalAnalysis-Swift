import XCTest
@testable import MorphologicalAnalysis
@testable import Dictionary

final class FsmMorphologicalAnalyzerTest: XCTestCase {

    var fsm: FsmMorphologicalAnalyzer = FsmMorphologicalAnalyzer()

    func testGenerateAllParses() {
        let testWords = ["göç", "açıkla", "yıldönümü",
                         "resim", "hal", "emlak", "git",
                         "kavur", "ye", "yemek", "ak",
                         "sıska", "yıka", "bul", "cevapla",
                         "coş", "böl", "del", "giy",
                         "kaydol", "anla", "çök", "çık",
                         "doldur", "azal", "göster", "aksa", "cenk", "kalp"]
        for testWord in testWords {
            let word = self.fsm.getDictionary().getWord(name: testWord) as! TxtWord
            var parsesExpected : [String] = []
            let thisSourceFile = URL(fileURLWithPath: #file)
            let thisDirectory = thisSourceFile.deletingLastPathComponent()
            let url = thisDirectory.appendingPathComponent("/parses/" + word.getName() + ".txt")
            do{
                let fileContent = try String(contentsOf: url, encoding: .utf8)
                let lines = fileContent.split(whereSeparator: \.isNewline)
                for line in lines{
                    let items = line.components(separatedBy: " ")
                    parsesExpected.append(items[1])
                }
            } catch {
            }
            let parsesGenerated = self.fsm.generateAllParses(root: word, maxLength: word.getName().count + 5)
            XCTAssertTrue(parsesExpected.count == parsesGenerated.count)
            for parseGenerated in parsesGenerated{
                XCTAssertTrue(parsesExpected.contains(parseGenerated.description()))
            }
        }
    }

    func testMorphologicalAnalysisSpecialProperNoun() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Times'ın").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Times'tır").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Times'mış").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Twitter'ın").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Twitter'dır").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "Twitter'mış").size() != 0)
    }
    
    func testMorphologicalAnalysisDataTimeNumber() {
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "3/4").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "3\\/4").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "4/2/1973").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "14/2/1993").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "14/12/1933").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "6/12/1903").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "%34.5").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "%3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "%56").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "2:3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "12:3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "4:23").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "11:56").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "1:2:3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "3:12:3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "5:4:23").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "7:11:56").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "12:2:3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "10:12:3").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "11:4:23").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "22:11:56").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "45").size() != 0)
        XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: "34.23").size() != 0)
    }

    func testMorphologicalAnalysisProperNoun() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if word.isProperNoun(){
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: Word.uppercase(s: word.getName())).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisNounSoftenDuringSuffixation() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if word.isNominal() && word.nounSoftenDuringSuffixation(){
                let transitionState = State(name: "Possessive", startState: false, endState: false)
                let startState = State(name: "NominalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "yH", withName: "ACC")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisVowelAChangesToIDuringYSuffixation() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if (word.isVerb() && word.vowelAChangesToIDuringYSuffixation()){
                let transitionState = State(name: "VerbalStem", startState: false, endState: false)
                let startState = State(name: "VerbalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "Hyor", withName: "PROG1")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisIsPortmanteau() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if (word.isNominal() && word.isPortmanteau() && !word.isPlural() && !word.isPortmanteauFacedVowelEllipsis()){
                let transitionState = State(name: "CompoundNounRoot", startState: true, endState: false)
                let startState = State(name: "CompoundNounRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "lArH", withName: "A3PL+P3PL")
                let exceptLast2 = word.getName().prefix(word.getName().count - 2)
                let exceptLast = word.getName().prefix(word.getName().count - 1)
                var rootForm : String
                if word.isPortmanteauFacedSoftening(){
                    switch Word.charAt(s: word.getName(), i: word.getName().count - 2) {
                    case "b":
                            rootForm = exceptLast2 + "p"
                            break
                    case "c":
                            rootForm = exceptLast2 + "ç"
                            break
                    case "d":
                        rootForm = exceptLast2 + "t"
                            break
                    case "ğ":
                            rootForm = exceptLast2 + "k"
                            break
                        default:
                            rootForm = String(exceptLast)
                    }
                } else {
                    if word.isPortmanteauEndingWithSI(){
                        rootForm = String(exceptLast2)
                    } else {
                        rootForm = String(exceptLast)
                    }
                }
                let surfaceForm = transition.makeTransition(root: word, stem: rootForm, startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }
    
    func testMorphologicalAnalysisNotObeysVowelHarmonyDuringAgglutination() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if word.isNominal() && word.notObeysVowelHarmonyDuringAgglutination(){
                let transitionState = State(name: "Possessive", startState: false, endState: false)
                let startState = State(name: "NominalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "yH", withName: "ACC")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisLastIdropsDuringSuffixation() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if word.isNominal() && word.lastIdropsDuringSuffixation(){
                let transitionState = State(name: "Possessive", startState: false, endState: false)
                let startState = State(name: "NominalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "yH", withName: "ACC")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisVerbSoftenDuringSuffixation() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if word.isVerb() && word.verbSoftenDuringSuffixation(){
                let transitionState = State(name: "VerbalStem", startState: false, endState: false)
                let startState = State(name: "VerbalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "Hyor", withName: "PROG1")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisDuplicatesDuringSuffixation() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if (word.isNominal() && word.duplicatesDuringSuffixation()){
                let transitionState = State(name: "Possessive", startState: false, endState: false)
                let startState = State(name: "NominalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "yH", withName: "ACC")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisEndingKChangesIntoG() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if (word.isNominal() && word.endingKChangesIntoG()){
                let transitionState = State(name: "Possessive", startState: false, endState: false)
                let startState = State(name: "NominalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "yH", withName: "ACC")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    func testMorphologicalAnalysisLastIdropsDuringPassiveSuffixation() {
        let dictionary = fsm.getDictionary()
        for i in 0..<dictionary.size(){
            let word = dictionary.getWordWithIndex(index: i) as! TxtWord
            if (word.isVerb() && word.lastIdropsDuringPassiveSuffixation()){
                let transitionState = State(name: "VerbalStem", startState: false, endState: false)
                let startState = State(name: "VerbalRoot", startState: true, endState: false)
                let transition = Transition(toState: transitionState,with: "Hl", withName: "^DB+VERB+PASS")
                let surfaceForm = transition.makeTransition(root: word, stem: word.getName(), startState: startState)
                XCTAssertTrue(fsm.morphologicalAnalysis(surfaceForm: surfaceForm).size() != 0)
            }
        }
    }

    static var allTests = [
        ("testExample1", testMorphologicalAnalysisDataTimeNumber),
        ("testExample2", testMorphologicalAnalysisProperNoun),
        ("testExample3", testMorphologicalAnalysisNounSoftenDuringSuffixation),
        ("testExample4", testMorphologicalAnalysisVowelAChangesToIDuringYSuffixation),
        ("testExample5", testMorphologicalAnalysisIsPortmanteau),
        ("testExample6", testMorphologicalAnalysisNotObeysVowelHarmonyDuringAgglutination),
        ("testExample7", testMorphologicalAnalysisLastIdropsDuringSuffixation),
        ("testExample8", testMorphologicalAnalysisVerbSoftenDuringSuffixation),
        ("testExample9", testMorphologicalAnalysisDuplicatesDuringSuffixation),
        ("testExample10", testMorphologicalAnalysisEndingKChangesIntoG),
        ("testExample11", testMorphologicalAnalysisLastIdropsDuringPassiveSuffixation),
    ]
}

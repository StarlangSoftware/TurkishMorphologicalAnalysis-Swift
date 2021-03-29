import XCTest
@testable import MorphologicalAnalysis
@testable import DataStructure

final class FiniteStateMachineTest: XCTestCase {
    
    var fsm: FiniteStateMachine = FiniteStateMachine()
    var stateList: [State] = []

    override func setUp(){
        fsm = FiniteStateMachine(fileName: "turkish_finite_state_machine.xml")
        stateList = fsm.getStates()
    }

    func testStateCount() {
        XCTAssertEqual(139, stateList.count)
    }

    func testStartEndStates() {
        var endStateCount : Int = 0
        for state in stateList {
            if state.isEndState() {
                endStateCount += 1
            }
        }
        XCTAssertEqual(35, endStateCount)
        let posCounts : CounterHashMap<String> = CounterHashMap<String>()
        for state in stateList {
            if state.getPos() != nil{
                posCounts.put(key: state.getPos()!)
            }
        }
        XCTAssertEqual(1, posCounts.count(key: "HEAD"))
        XCTAssertEqual(6, posCounts.count(key: "PRON"))
        XCTAssertEqual(1, posCounts.count(key: "PROP"))
        XCTAssertEqual(8, posCounts.count(key: "NUM"))
        XCTAssertEqual(7, posCounts.count(key: "ADJ"))
        XCTAssertEqual(1, posCounts.count(key: "INTERJ"))
        XCTAssertEqual(1, posCounts.count(key: "DET"))
        XCTAssertEqual(1, posCounts.count(key: "ADVERB"))
        XCTAssertEqual(1, posCounts.count(key: "QUES"))
        XCTAssertEqual(1, posCounts.count(key: "CONJ"))
        XCTAssertEqual(26, posCounts.count(key: "VERB"))
        XCTAssertEqual(1, posCounts.count(key: "POSTP"))
        XCTAssertEqual(1, posCounts.count(key: "DUP"))
        XCTAssertEqual(11, posCounts.count(key: "NOUN"))
    }
    
    func testTransitionCount() {
        var transitionCount : Int = 0
        for state in stateList {
            transitionCount += fsm.getTransitions(state: state).count
        }
        XCTAssertEqual(779, transitionCount)
    }
    
    func testTransitionWith() {
        let transitionCounts : CounterHashMap<String> = CounterHashMap<String>()
        for state in stateList {
            let transitions : [Transition] = fsm.getTransitions(state: state)
            for transition in transitions{
                transitionCounts.put(key: transition.description())
            }
        }
        let topList : Array<(item:String, count:Int)> = transitionCounts.topN(N: 5)
        XCTAssertEqual("0", topList[0].item)
        XCTAssertEqual(111, topList[0].count)
        XCTAssertEqual("lAr", topList[1].item)
        XCTAssertEqual(37, topList[1].count)
        XCTAssertEqual("DHr", topList[2].item)
        XCTAssertEqual(28, topList[2].count)
        XCTAssertEqual("Hn", topList[3].item)
        XCTAssertEqual(24, topList[3].count)
        XCTAssertEqual("lArH", topList[4].item)
        XCTAssertEqual(23, topList[4].count)
    }

    func testTransitionWithName() {
        let transitionCounts : CounterHashMap<String> = CounterHashMap<String>()
        for state in stateList {
            let transitions : [Transition] = fsm.getTransitions(state: state)
            for transition in transitions{
                if transition.with() != nil{
                    transitionCounts.put(key: transition.with()!)
                }
            }
        }
        let topList : Array<(item:String, count:Int)> = transitionCounts.topN(N: 5)
        XCTAssertEqual("^DB+VERB+CAUS", topList[0].item)
        XCTAssertEqual(33, topList[0].count)
        XCTAssertEqual("^DB+VERB+PASS", topList[1].item)
        XCTAssertEqual(31, topList[1].count)
        XCTAssertEqual("A3PL", topList[2].item)
        XCTAssertEqual(28, topList[2].count)
        XCTAssertEqual("LOC", topList[3].item)
        XCTAssertEqual(24, topList[3].count)
        XCTAssertEqual("GEN", topList[4].item)
        XCTAssertEqual(23, topList[4].count)
    }

    static var allTests = [
        ("testExample1", testStateCount),
        ("testExample2", testStartEndStates),
        ("testExample3", testTransitionCount),
        ("testExample4", testTransitionWith),
        ("testExample5", testTransitionWithName),
    ]
}

//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 15.03.2021.
//

import Foundation

public class FiniteStateMachine: NSObject, XMLParserDelegate{
    
    private var states : [State] = []
    private var transitions : Dictionary<State, [Transition]> = [:]
    private var value: String = ""
    private var state: State? = nil
    private var withName: String? = nil
    private var rootToPos: String? = nil
    private var toPos: String? = nil
    private var toState: State? = nil
    private var first: Bool = true
    
    public override init(){
        super.init()
        let url = Bundle.module.url(forResource: "turkish_finite_state_machine", withExtension: "xml")
        var parser : XMLParser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
        first = false
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
    }
    
    public init(fileName: String){
        super.init()
        let url = Bundle.module.url(forResource: fileName, withExtension: "xml")
        var parser : XMLParser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
        first = false
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        var name, originalpos: String
        var start, end: Bool
        if elementName == "state" {
            if first{
                name = attributeDict["name"]!
                start = attributeDict["start"]! == "yes"
                end = attributeDict["end"]! == "yes"
                if start{
                    originalpos = attributeDict["originalpos"]!
                    state = State(name: name, startState: true, endState: end, pos: originalpos)
                } else {
                    state = State(name: name, startState: false, endState: end)
                }
            } else {
                name = attributeDict["name"]!
                for state1 in states{
                    if state1.getName() == name{
                        state = state1
                        break
                    }
                }
            }
        } else {
            if elementName == "to"{
                if !first{
                    toState = getState(name: attributeDict["name"]!)!
                    if attributeDict["transitionname"] != nil{
                        withName = attributeDict["transitionname"]
                    } else {
                        withName = nil
                    }
                    if attributeDict["topos"] != nil{
                        rootToPos = attributeDict["topos"]
                    } else {
                        rootToPos = nil
                    }
                }
            } else {
                if elementName == "with"{
                    if !first{
                        value = ""
                        if attributeDict["name"] != nil{
                            withName = attributeDict["name"]
                        }
                        if attributeDict["topos"] != nil{
                            toPos = attributeDict["topos"]
                        } else {
                            toPos = nil
                        }
                    }
                }
            }
        }
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if elementName == "state" && first{
            states.append(state!)
            value = ""
        } else {
            if elementName == "with"{
                if !first{
                    if toPos == nil{
                        if rootToPos == nil{
                            addTransition(fromState: state!, toState: toState!, with: value, withName: withName)
                        } else {
                            addTransition(fromState: state!, toState: toState!, with: value, withName: withName, toPos: rootToPos!)
                        }
                    } else {
                        addTransition(fromState: state!, toState: toState!, with: value, withName: withName!, toPos: toPos!)
                    }
                    value = ""
                }
            }
        }
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String){
        if string != "\n"{
            value = value + string
        }
    }

    /**
     * The isValidTransition loops through states ArrayList and checks transitions between states. If the actual transition
     * equals to the given transition input, method returns true otherwise returns false.
        - Parameters:
            - transition: is used to compare with the actual transition of a state.
        - Returns: true when the actual transition equals to the transition input, false otherwise.
     */
    public func isValidTransition(transition: String) -> Bool{
        for state in transitions.keys {
            let transitionList : [Transition] = transitions[state]!
            for transition1 in transitionList {
                if transition1.description() == transition {
                    return true
                }
            }
        }
        return false
    }
    
    /**
     * the getStates method returns the states in the FiniteStateMachine.
        - Returns: StateList.
     */
    public func getStates() -> [State]{
        return states
    }
    
    /**
     * The getState method is used to loop through the states {@link ArrayList} and return the state whose name equal
     * to the given input name.
        - Parameters:
            - name: is used to compare with the state's actual name.
        - Returns: state if found any, null otherwise.
     */
    public func getState(name: String) -> State?{
        for state in states {
            if state.getName() == name {
                return state
            }
        }
        return nil
    }
    
    /**
     * The addTransition method creates a new {@link Transition} with given input parameters and adds the transition to
     * transitions {@link ArrayList}.
        - Parameters:
            - fromState:  State type input indicating the from state.
            - toState:  State type input indicating the next state.
            - with:     String input indicating with what the transition will be made.
            - withName: String input.
     */
    public func addTransition(fromState: State, toState: State, with: String, withName: String?){
        var transitionList: [Transition] = []
        let newTransition : Transition = Transition(toState: toState, with: with, withName: withName)
        if transitions[fromState] != nil {
            transitionList = transitions[fromState]!
        } else {
            transitionList = []
        }
        transitionList.append(newTransition)
        transitions[fromState] = transitionList
    }
    
    /**
     * Another addTransition method which takes additional argument; toPos and. It creates a new {@link Transition}
     * with given input parameters and adds the transition to transitions {@link ArrayList}.
        - Parameters:
            - fromState:  State type input indicating the from state.
            - toState:  State type input indicating the next state.
            - with:     String input indicating with what the transition will be made.
            - withName: String input.
            - toPos:    String input.
     */
    public func addTransition(fromState: State, toState: State, with: String, withName: String?, toPos: String){
        var transitionList: [Transition] = []
        let newTransition : Transition = Transition(toState: toState, with: with, withName: withName, toPos: toPos)
        if transitions[fromState] != nil {
            transitionList = transitions[fromState]!
        } else {
            transitionList = []
        }
        transitionList.append(newTransition)
        transitions[fromState] = transitionList
    }
    
    /**
     * The getTransitions method returns the transitions at the given state.
        - Parameters:
            - state: State input.
        - Returns: transitions at given state.
     */
    public func getTransitions(state: State) -> [Transition]{
        if transitions[state] != nil{
            return transitions[state]!
        } else {
            return []
        }
    }
}

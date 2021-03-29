//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 9.03.2021.
//

import Foundation
import Dictionary

public class FsmParseList{
    
    private var fsmParses: [FsmParse] = []
    
    /**
     * A constructor of {@link FsmParseList} class which takes an {@link ArrayList} fsmParses as an input. First it sorts
     * the items of the {@link ArrayList} then loops through it, if the current item's transitions equal to the next item's
     * transitions, it removes the latter item. At the end, it assigns this {@link ArrayList} to the fsmParses variable.
        - Parameters:
            - fsmParses: {@link FsmParse} type{@link ArrayList} input.
     */
    public init(fsmParses: [FsmParse]){
        self.fsmParses = fsmParses
        self.fsmParses.sort{$0.transitionList() < $1.transitionList()}
        var i : Int = 0
        while i < self.fsmParses.count - 1 {
            let parse1 = self.fsmParses[i].transitionList()
            let parse2 = self.fsmParses[i + 1].transitionList()
            if parse1 == parse2 {
                self.fsmParses.remove(at: i + 1)
                i -= 1
            }
            i += 1
        }
    }
    
    /**
     * The size method returns the size of fsmParses {@link ArrayList}.
        - Returns: The size of fsmParses {@link ArrayList}.
     */
    public func size() -> Int{
        return fsmParses.count
    }
    
    /**
     * The getFsmParse method takes an integer index as an input and returns the item of fsmParses {@link ArrayList} at given index.
        - Parameters:
            - index: Integer input.
        - Returns: Tthe item of fsmParses {@link ArrayList} at given index.
     */
    public func getFsmParse(index: Int) -> FsmParse{
        return fsmParses[index]
    }
    
    /**
     * The rootWords method gets the first item's root of fsmParses {@link ArrayList} and uses it as currentRoot. Then loops through
     * the fsmParses, if the current item's root does not equal to the currentRoot, it then assigns it as the currentRoot and
     * accumulates root words in a {@link String} result.
     - Returns: String result that has root words.
     */
    public func rootWords() -> String{
        var result: String = fsmParses[0].getWord().getName()
        var currentRoot: String = result
        for i in 1..<fsmParses.count {
            if fsmParses[i].getWord().getName() != currentRoot {
                currentRoot = fsmParses[i].getWord().getName()
                result = result + "$" + currentRoot
            }
        }
        return result
    }
    
    /**
     * The reduceToParsesWithSameRootAndPos method takes a {@link Word} currentWithPos as an input and loops i times till
     * i equals to the size of the fsmParses {@link ArrayList}. If the given currentWithPos does not equal to the ith item's
     * root and the MorphologicalTag of the first inflectional of fsmParses, it removes the ith item from the {@link ArrayList}.
        - Parameters:
            - currentWithPos {@link Word} input.
     */
    public func reduceToParsesWithSameRootAndPos(currentWithPos: Word){
        var i : Int = 0
        while i < fsmParses.count {
            if fsmParses[i].getWordWithPos() != currentWithPos {
                fsmParses.remove(at: i)
            } else {
                i += 1
            }
        }
    }
    
    /**
     * The getParseWithLongestRootWord method returns the parse with the longest root word. If more than one parse has the
     * longest root word, the first parse with that root is returned.
        - Returns: FsmParse Parse with the longest root word.
     */
    public func getParseWithLongestRootWord() -> FsmParse{
        var maxLength: Int = -1
        var bestParse : FsmParse? = nil
        for currentParse in fsmParses {
            if currentParse.getWord().getName().count > maxLength {
                maxLength = currentParse.getWord().getName().count
                bestParse = currentParse
            }
        }
        return bestParse!
    }
    
    /**
     * The reduceToParsesWithSameRoot method takes a {@link String} currentWithPos as an input and loops i times till
     * i equals to the size of the fsmParses {@link ArrayList}. If the given currentRoot does not equal to the root of ith item of
     * fsmParses, it removes the ith item from the {@link ArrayList}.
        - Parameters:
            - currentRoot: {@link String} input.
     */
    public func reduceToParsesWithSameRoot(currentRoot: String){
        var i : Int = 0
        while i < fsmParses.count {
            if fsmParses[i].getWord().getName() != currentRoot {
                fsmParses.remove(at: i)
            } else {
                i += 1
            }
        }
    }
    
    /**
     * The constructParseListForDifferentRootWithPos method initially creates a result {@link ArrayList} then loops through the
     * fsmParses {@link ArrayList}. For the first iteration, it creates new {@link ArrayList} as initial, then adds the
     * first item od fsmParses to initial and also add this initial {@link ArrayList} to the result {@link ArrayList}.
     * For the following iterations, it checks whether the current item's root with the MorphologicalTag of the first inflectional
     * equal to the previous item's  root with the MorphologicalTag of the first inflectional. If so, it adds that item
     * to the result {@link ArrayList}, if not it creates new {@link ArrayList} as initial and adds the first item od fsmParses
     * to initial and also add this initial {@link ArrayList} to the result {@link ArrayList}.
     - Returns: result {@link ArrayList} type of {@link FsmParseList}.
     */
    public func constructParseListForDifferentRootWithPos() -> [FsmParseList]{
        var result : [FsmParseList] = []
        var i : Int = 0
        while i < fsmParses.count {
            if i == 0 {
                var initial : [FsmParse] = []
                initial.append(fsmParses[i])
                result.append(FsmParseList(fsmParses: initial))
            } else {
                if fsmParses[i].getWordWithPos() == fsmParses[i - 1].getWordWithPos() {
                    result.last!.fsmParses.append(fsmParses[i])
                } else {
                    var initial : [FsmParse] = []
                    initial.append(fsmParses[i])
                    result.append(FsmParseList(fsmParses: initial))
                }
            }
            i += 1
        }
        return result
    }
    
    /**
     * The parsesWithoutPrefixAndSuffix method first creates a {@link String} array named analyses with the size of fsmParses {@link ArrayList}'s size.
     * <p>
     * If the size is just 1, it then returns the first item's transitionList, if it is greater than 1, loops through the fsmParses and
     * puts the transitionList of each item to the analyses array.
     * <p>
     * If the removePrefix condition holds, it loops through the analyses array and takes each item's substring after the first + sign and updates that
     * item of analyses array with that substring.
     * <p>
     * If the removeSuffix condition holds, it loops through the analyses array and takes each item's substring till the last + sign and updates that
     * item of analyses array with that substring.
     * <p>
     * It then removes the duplicate items of analyses array and returns a result {@link String} that has the accumulated items of analyses array.
        - Returns: Result {@link String} that has the accumulated items of analyses array.
     */
    public func parsesWithoutPrefixAndSuffix() -> String{
        var analyses : [String] = []
        var removePrefix : Bool = true
        var removeSuffix :Bool = true
        if fsmParses.count == 1 {
            let st = fsmParses[0].transitionList()
            return String(st[st.index(after: st.firstIndex(of: "+")!)...])
        }
        for i in 0..<fsmParses.count {
            analyses.append(fsmParses[i].transitionList())
        }
        while removePrefix {
            removePrefix = true
            for i in 0..<fsmParses.count - 1 {
                if !analyses[i].contains("+") || !analyses[i + 1].contains("+") || String(analyses[i][...analyses[i].firstIndex(of: "+")!]) != String(analyses[i + 1][...analyses[i + 1].firstIndex(of: "+")!]) {
                    removePrefix = false
                    break
                }
            }
            if removePrefix {
                for i in 0..<fsmParses.count {
                    analyses[i] = String(analyses[i][analyses[i].index(after: analyses[i].firstIndex(of: "+")!)...])
                }
            }
        }
        while removeSuffix {
            removeSuffix = true
            for i in 0..<fsmParses.count - 1 {
                if !analyses[i].contains("+") || !analyses[i + 1].contains("+") || String(analyses[i][analyses[i].index(after: analyses[i].lastIndex(of: "+")!)...]) != String(analyses[i + 1][analyses[i + 1].index(after: analyses[i + 1].lastIndex(of: "+")!)...]) {
                    removeSuffix = false
                    break
                }
            }
            if removeSuffix {
                for i in 0..<fsmParses.count {
                    analyses[i] = String(analyses[i][..<analyses[i].lastIndex(of: "+")!])
                }
            }
        }
        for i in 0..<analyses.count {
            for j in i + 1..<analyses.count {
                if analyses[i] > analyses[j] {
                    let tmp : String = analyses[i]
                    analyses[i] = analyses[j]
                    analyses[j] = tmp
                }
            }
        }
        var result : String = analyses[0]
        for i in 1..<analyses.count {
            result = result + "$" + analyses[i]
        }
        return result
    }
    
    /**
     * The overridden description method loops through the fsmParses {@link ArrayList} and accumulates the items to a result {@link String}.
        - Returns: Result {@link String} that has the items of fsmParses {@link ArrayList}.
     */
    public func description() -> String{
        var result : String = ""
        for i in 0..<fsmParses.count {
            result = result + fsmParses[i].description() + "\n"
        }
        return result
    }
}

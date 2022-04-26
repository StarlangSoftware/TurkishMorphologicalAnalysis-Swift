//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 26.04.2022.
//

import Foundation
import Corpus
import Dictionary

public class DisambiguationCorpus : Corpus{
    
    /**
     * Constructor which creates an {@link ArrayList} of sentences and a {@link CounterHashMap} of wordList.
     */
    public override init() {
        super.init()
    }
    
    public override init(fileName: String){
        super.init()
        var newSentence : Sentence? = nil
        let url = Bundle.module.url(forResource: fileName, withExtension: "txt")
        do{
            let fileContent = try String(contentsOf: url!, encoding: .utf8)
            let lines = fileContent.split(whereSeparator: \.isNewline)
            for line in lines{
                let word = Word.substringUntil(s: String(line), ch: "\t")
                let parse = Word.substringFrom(s: String(line), ch: "\t")
                if word.count > 0 && parse.count > 0{
                    let newWord = DisambiguatedWord(name: word, parse: MorphologicalParse(parse: parse))
                    if word == "<S>"{
                        newSentence = Sentence()
                    } else {
                        if word == "</S>"{
                            addSentence(s: newSentence!)
                        } else {
                            if word == "<DOC>" || word == "</DOC>" || word == "<TITLE>" || word == "</TITLE>"{
                                
                            } else {
                                if newSentence != nil{
                                    newSentence?.addWord(word: newWord)
                                }
                            }
                        }
                    }
                }
            }
        } catch {
        }
    }
    
}

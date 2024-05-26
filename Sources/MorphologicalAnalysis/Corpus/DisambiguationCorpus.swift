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
    
    /// Constructor which takes a file name {@link String} as an input and reads the file line by line. It takes each word of the line,
    /// and creates a new {@link DisambiguatedWord} with current word and its {@link MorphologicalParse}. It also creates a new {@link Sentence}
    /// when a new sentence starts, and adds each word to this sentence till the end of that sentence.
    /// - Parameter fileName: File which will be read and parsed.
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

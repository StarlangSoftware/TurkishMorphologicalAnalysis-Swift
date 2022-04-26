//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 26.04.2022.
//

import Foundation
import Dictionary

public class DisambiguatedWord : Word{
    
    private var parse: MorphologicalParse
    
    /**
     * The constructor of {@link DisambiguatedWord} class which takes a {@link String} and a {@link MorphologicalParse}
     * as inputs. It creates a new {@link MorphologicalParse} with given MorphologicalParse. It generates a new instance with
     * given {@link String}.
    - Parameters:
        - name  Instances that will be a DisambiguatedWord.
        - parse {@link MorphologicalParse} of the {@link DisambiguatedWord}.
     */
    public init(name: String, parse: MorphologicalParse){
        self.parse = parse
        super.init(name: name)
    }
    
    /**
     * Accessor for the {@link MorphologicalParse}.
     *
        - Returns: MorphologicalParse.
     */
    public func getParse() -> MorphologicalParse{
        return parse
    }
}

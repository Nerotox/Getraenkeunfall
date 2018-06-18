//
//  File.swift
//  Getraenkeunfall
//
//  Created by Peter Jedinger on 15.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import Foundation
import Speech

class GU_Speech{

    enum SpeechSetting{
        case lowPitched, normal, highPitched
    }
    
    static func getSpeechUtterance(text: String, setting: SpeechSetting) -> AVSpeechUtterance{
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
        
        if setting == SpeechSetting.lowPitched {
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 0.8
        }else if setting == SpeechSetting.normal{
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 1.15
        }else if setting == SpeechSetting.highPitched {
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 2.0
        }
        return speechUtterance
    }
    
    static func getSpeechUtterance(text: String, setting: SpeechSetting, preUtteranceDelay: TimeInterval) -> AVSpeechUtterance{
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
        
        speechUtterance.preUtteranceDelay = preUtteranceDelay
        if setting == SpeechSetting.lowPitched {
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 0.8
        }else if setting == SpeechSetting.normal{
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 1.15
        }else if setting == SpeechSetting.highPitched {
            speechUtterance.rate = 0.5
            speechUtterance.pitchMultiplier = 2.0
        }
        return speechUtterance
    }
}


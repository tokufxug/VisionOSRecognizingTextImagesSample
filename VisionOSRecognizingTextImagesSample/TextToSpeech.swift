//
//  TextToSpeech.swift
//  VisionOSRecognizingTextImagesSample
//
//  Created by Sadao Tokuyama on 3/30/24.
//

import Foundation
import AVFoundation

class TextToSpeech {
    let speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    func speech(text: String, lang: String = "en-US", pitch: Float = 1.0, volume: Float = 1.0, rate: Float = 0.5) {
        let speechSynthesisVoice = AVSpeechSynthesisVoice.init(language: lang)
        let speechUtterance = AVSpeechUtterance.init(string: text)
        speechUtterance.voice = speechSynthesisVoice
        speechUtterance.pitchMultiplier = pitch
        speechUtterance.volume = volume
        speechUtterance.rate = rate
        
        self.speechSynthesizer.speak(speechUtterance)
    }
}

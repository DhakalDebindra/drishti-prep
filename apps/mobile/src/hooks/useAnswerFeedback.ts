import { useCallback, useEffect, useRef } from 'react'
import { Platform } from 'react-native'
import * as Haptics from 'expo-haptics'
import { usePreferences } from '../providers/PreferencesProvider'

let Audio: any = null
try {
  Audio = require('expo-audio')
} catch {
  Audio = null
}

// Fire haptics without ever crashing the JS thread.
function safeNotify(type: Haptics.NotificationFeedbackType) {
  if (Platform.OS === 'web') return
  try {
    void Haptics.notificationAsync(type).catch(() => {})
  } catch {
    // native module missing entirely — ignore
  }
}

export function useAnswerFeedback() {
  const { answerSound, haptics } = usePreferences()
  const lastPlayedRef = useRef(0)
  
  const correctSoundRef = useRef<any>(null)
  const incorrectSoundRef = useRef<any>(null)

  useEffect(() => {
    if (!Audio) return
    
    try {
      correctSoundRef.current = Audio.createAudioPlayer(require('../../assets/sounds/correct.wav'))
      incorrectSoundRef.current = Audio.createAudioPlayer(require('../../assets/sounds/incorrect.wav'))
    } catch (err) {
      console.warn('Failed to initialize audio players', err)
    }

    return () => {
      try {
        correctSoundRef.current?.release()
        incorrectSoundRef.current?.release()
      } catch (err) {
        console.warn('Failed to release audio players', err)
      }
    }
  }, [])

  const playCorrect = useCallback(() => {
    const now = Date.now()
    if (now - lastPlayedRef.current < 300) return
    lastPlayedRef.current = now

    if (haptics) {
      safeNotify(Haptics.NotificationFeedbackType.Success)
    }
    
    if (answerSound && correctSoundRef.current) {
      try {
        correctSoundRef.current.seekTo(0)
        correctSoundRef.current.play()
      } catch (err) {
        console.warn('Failed to play correct sound', err)
      }
    }
  }, [answerSound, haptics])

  const playIncorrect = useCallback(() => {
    const now = Date.now()
    if (now - lastPlayedRef.current < 300) return
    lastPlayedRef.current = now

    if (haptics) {
      safeNotify(Haptics.NotificationFeedbackType.Error)
    }
    
    if (answerSound && incorrectSoundRef.current) {
      try {
        incorrectSoundRef.current.seekTo(0)
        incorrectSoundRef.current.play()
      } catch (err) {
        console.warn('Failed to play incorrect sound', err)
      }
    }
  }, [answerSound, haptics])

  return { playCorrect, playIncorrect }
}

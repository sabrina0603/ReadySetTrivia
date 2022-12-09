//
//  ContentView.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/7/22.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @StateObject var gameManager = GameManager()
    @State var audioPlayer: AVAudioPlayer!
    @State var soundIsOn = true
    
    var body: some View {
        NavigationStack {
            VStack (spacing: 40) {
                HStack{
                    Spacer()
                    Image(systemName: soundIsOn ? "speaker.wave.2.fill": "speaker.slash.fill")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.minimum(40, 40))
                        .foregroundColor(.white)
                        .onTapGesture {
                            soundIsOn.toggle()
                        }
                        .onChange(of: soundIsOn) { _ in
                            if audioPlayer != nil && audioPlayer.isPlaying {
                                audioPlayer.stop()
                            }else {
                                audioPlayer.play()
                            }
                        }
                }
                VStack (spacing: 20) {
                    Image("think")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding(.bottom)
                    Text("Ready, Set, Trivia!")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("yellowy"))
                    Text("Time to use that noggin of yours!")
                        .foregroundColor(Color("yellowy"))
                }
                NavigationLink {
                    EndView()
                } label: {
                    Text("Play")
                        .foregroundColor(.black)
                        .padding()
                        .padding(.horizontal)
                        .background(Color("yellowy"))
                        .cornerRadius(30)
                        .font(.title2)
                        .bold()
                }
                Spacer()
            }
            .onAppear {
                playSound(soundName: "music")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .background(Color("darkBlue"))
            .statusBarHidden()
        }
    }
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioplayer.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameManager())
    }
}

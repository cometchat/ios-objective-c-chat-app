//
//  CometChatMeetingView.swift
//  CometChatSwift
//
//  Created by Pushpsen Airekar on 06/01/21.
//  Copyright © 2021 MacMini-03. All rights reserved.
//

import UIKit
import CometChatPro

class CometChatMeetingView: UIViewController {

    
    @IBOutlet weak var customView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
    }
    
    override func loadView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CometChatMeetingView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view  = view
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeFromParent()
    }
    
    
    public func performCall(with sessionID: String, type: CometChatPro.CometChat.CallType){

        switch type {
        case .audio:
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }

                let callSettings = CallSettings.CallSettingsBuilder(callView: strongSelf.customView, sessionId: sessionID).setAudioOnlyCall(audioOnly: false).startWithAudioMuted(audioMuted: false).build()
                
                CometChat.startCall(callSettings: callSettings, onUserJoined: { (userJoined) in
                    DispatchQueue.main.async {
                        if let name = userJoined?.name {
                            let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: "\(name) " + "JOINED".localized(), duration: .short)
                            snackbar.show()
                        }
                    }
                }, onUserLeft: { (userLeft) in
                    DispatchQueue.main.async {
                        if let name = userLeft?.name {
                            let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: "\(name) " + "LEFT_THE_CALL".localized(), duration: .short)
                            snackbar.show()
                        }
                    }
                    
                },onUserListUpdated: {(userListUpdated) in
                    
                }, onAudioModesUpdated: {(userListUpdated) in
                    
                }, onError: { (error) in

                    DispatchQueue.main.async {
                        if let error = error {
                            CometChatSnackBoard.showErrorMessage(for: error)
                        }
                    }

                }) { (ended) in
                    DispatchQueue.main.async {
                        strongSelf.dismiss(animated: true) {
                            CometChatSnackBoard.display(message: "CALL_ENDED".localized(), mode: .info, duration: .short)
                        }
                    }
                }
            }
        case .video:
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                
                let callSettings = CallSettings.CallSettingsBuilder(callView: strongSelf.customView, sessionId: sessionID).setAudioOnlyCall(audioOnly: false).startWithVideoMuted(videoMuted: false).startWithAudioMuted(audioMuted: false).build()
                
                CometChat.startCall(callSettings: callSettings, onUserJoined: { (userJoined) in
                    DispatchQueue.main.async {
                        if let name = userJoined?.name {
                            let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: "\(name) " + "JOINED".localized(), duration: .short)
                            snackbar.show()
                        }
                    }
                }, onUserLeft: { (userLeft) in
                    DispatchQueue.main.async {
                        if let name = userLeft?.name {
                            let snackbar: CometChatSnackbar = CometChatSnackbar.init(message: "\(name) " + "LEFT_THE_CALL".localized(), duration: .short)
                            snackbar.show()
                        }
                    }
                }, onUserListUpdated: {(userListUpdated) in
                    
                    
                }, onAudioModesUpdated: {(audioModesUpdated) in

                
                }, onError: { (error) in

                    DispatchQueue.main.async {
                        strongSelf.view.removeFromSuperview()
                        strongSelf.dismiss(animated: true, completion: nil)
                        if let error = error {
                            CometChatSnackBoard.showErrorMessage(for: error)
                        }
                    }
                }) { (callEnded) in
                    DispatchQueue.main.async {
                       
                        strongSelf.view.removeFromSuperview()
                        
                            strongSelf.dismiss(animated: true) {
                                CometChatSnackBoard.display(message: "CALL_ENDED".localized(), mode: .info, duration: .short)
                            }
                    }
                }
            }
        @unknown default:
            break
        }
       
        
    }
}

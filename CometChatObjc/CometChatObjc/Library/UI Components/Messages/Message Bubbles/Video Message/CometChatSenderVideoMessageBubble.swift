
//  CometChatSenderVideoMessageBubble.swift
//  CometChatUIKit
//  Created by CometChat Inc. on 20/09/19.
//  Copyright ©  2019 CometChat Inc. All rights reserved.

// MARK: - Importing Frameworks.

import UIKit
import CometChatPro
import AVFoundation
import CoreMedia

/*  ----------------------------------------------------------------------------------------- */

class CometChatSenderVideoMessageBubble: UITableViewCell {
    
     // MARK: - Declaration of IBInspectable
    
    @IBOutlet weak var reactionView: CometChatMessageReactions!
    @IBOutlet weak var replybutton: UIButton!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var imageMessage: UIImageView!
    @IBOutlet weak var activityIndicator: CCActivityIndicator!
    @IBOutlet weak var receipt: UIImageView!
    @IBOutlet weak var receiptStack: UIStackView!
    @IBOutlet weak var videoView: UIView!
    
    
    // MARK: - Declaration of Variables
    var indexPath: IndexPath?
    private var imageRequest: Cancellable?
    private lazy var imageService = ImageService()
    weak var mediaDelegate: MediaDelegate?
    var selectionColor: UIColor {
        set {
            let view = UIView()
            view.backgroundColor = newValue
            self.selectedBackgroundView = view
        }
        get {
            return self.selectedBackgroundView?.backgroundColor ?? UIColor.clear
        }
    }
    
    var mediaMessage: MediaMessage! {
        didSet {
                self.reactionView.parseMessageReactionForMessage(message: mediaMessage) { (success) in
                    if success == true {
                        self.reactionView.isHidden = false
                    }else{
                        self.reactionView.isHidden = true
                    }
                }
            receiptStack.isHidden = true
            if mediaMessage.sentAt == 0 {
                timeStamp.text = "SENDING".localized()
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
            }else{
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                timeStamp.text = String().setMessageTime(time: mediaMessage.sentAt)
            }
            if mediaMessage.readAt > 0 {
            receipt.image = UIImage(named: "message-read", in: UIKitSettings.bundle, compatibleWith: nil)
            timeStamp.text = String().setMessageTime(time: Int(mediaMessage?.readAt ?? 0))
            }else if mediaMessage.deliveredAt > 0 {
            receipt.image = UIImage(named: "message-delivered", in: UIKitSettings.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
            timeStamp.text = String().setMessageTime(time: Int(mediaMessage?.deliveredAt ?? 0))
            }else if mediaMessage.sentAt > 0 {
            receipt.image = UIImage(named: "message-sent", in: UIKitSettings.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
            timeStamp.text = String().setMessageTime(time: Int(mediaMessage?.sentAt ?? 0))
            }else if mediaMessage.sentAt == 0 {
               receipt.image = UIImage(named: "messages-wait", in: UIKitSettings.bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
               timeStamp.text = "SENDING".localized()
            }
            parseThumbnailForVideo(forMessage: mediaMessage)
           
            FeatureRestriction.isThreadedMessagesEnabled { (success) in
                switch success {
                case .enabled where self.mediaMessage.replyCount != 0 :
                    self.replybutton.isHidden = false
                    if self.mediaMessage.replyCount == 1 {
                        self.replybutton.setTitle("ONE_REPLY".localized(), for: .normal)
                    }else{
                        if let replies = self.mediaMessage.replyCount as? Int {
                            self.replybutton.setTitle("\(replies) replies", for: .normal)
                        }
                    }
                case .disabled, .enabled : self.replybutton.isHidden = true
                }
            }
            replybutton.tintColor = UIKitSettings.primaryColor
            FeatureRestriction.isDeliveryReceiptsEnabled { (success) in
                switch success {
                case .enabled: self.receipt.isHidden = false
                case .disabled: self.receipt.isHidden = true
                }
            }
            let tapOnVideoMessage = UITapGestureRecognizer(target: self, action: #selector(self.didVideoMessagePressed(tapGestureRecognizer:)))
            self.imageMessage.isUserInteractionEnabled = true
            self.imageMessage.addGestureRecognizer(tapOnVideoMessage)
            self.videoView.isUserInteractionEnabled = true
            self.videoView.addGestureRecognizer(tapOnVideoMessage)
        }
    }
    
     // MARK: - Initialization of required Methods
    @IBAction func didReplyButtonPressed(_ sender: Any) {
        
        if let message = mediaMessage, let indexpath = indexPath {
            CometChatThreadedMessageList.threadDelegate?.startThread(forMessage: message, indexPath: indexpath)
        }

    }
    
    @IBAction func didPlayButtonPressed(_ sender: Any) {
        mediaDelegate?.didOpenMedia(forMessage: mediaMessage, cell: self)
    }
    
    @objc func didVideoMessagePressed(tapGestureRecognizer: UITapGestureRecognizer)
    {
        mediaDelegate?.didOpenMedia(forMessage: mediaMessage, cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(iOS 13.0, *) {
            selectionColor = .systemBackground
        } else {
            selectionColor = .white
        }
        
    }
    
     override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           
       }

    
    override func prepareForReuse() {
        imageRequest?.cancel()
    }

    private func parseThumbnailForVideo(forMessage: MediaMessage?) {
           imageMessage.image = nil
           if let metaData = forMessage?.metaData , let injected = metaData["@injected"] as? [String : Any], let cometChatExtension =  injected["extensions"] as? [String : Any], let thumbnailGenerationDictionary = cometChatExtension["thumbnail-generation"] as? [String : Any] {
               if let url = URL(string: thumbnailGenerationDictionary["url_medium"] as? String ?? "") {
                   imageRequest = imageService.image(for: url) { [weak self] image in
                       guard let strongSelf = self else { return }
                       // Update Thumbnail Image View
                       if let image = image {
                           strongSelf.imageMessage.image = image
                       }else{
                           strongSelf.imageMessage.image = UIImage(named: "default-image.png", in: UIKitSettings.bundle, compatibleWith: nil)
                       }
                   }
               }
           }else{
            imageMessage.image = UIImage(color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
           }
       }
}

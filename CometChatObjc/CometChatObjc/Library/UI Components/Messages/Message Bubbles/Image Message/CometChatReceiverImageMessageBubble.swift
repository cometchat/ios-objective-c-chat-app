//
//  CometChatReceiverImageMessageBubble.swift
//  CometChatUIKit
//  Created by CometChat Inc. on 20/09/19.
//  Copyright ©  2020 CometChat Inc. All rights reserved.

// MARK: - Importing Frameworks.

import UIKit
import CometChatPro


/*  ----------------------------------------------------------------------------------------- */

class CometChatReceiverImageMessageBubble: UITableViewCell {
    
    
    // MARK: - Declaration of IBInspectable
    
    @IBOutlet weak var reactionView: CometChatMessageReactions!
    @IBOutlet weak var replybutton: UIButton!
    @IBOutlet weak var avatar: CometChatAvatar!
    @IBOutlet weak var imageMessage: UIImageView!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var receiptStack: UIStackView!
    @IBOutlet weak var imageModerationView: UIView!
    @IBOutlet weak var unsafeContentView: UIImageView!
    
    // MARK: - Declaration of Variables
    private var imageRequest: Cancellable?
    private lazy var imageService = ImageService()
    
    var indexPath: IndexPath?
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
    
    var mediaMessage: MediaMessage!{
        didSet {
            
            imageMessage.layer.cornerRadius = 12
            imageMessage.layer.borderWidth = 1
            if #available(iOS 13.0, *) {
                imageMessage.layer.borderColor = UIColor.systemFill.cgColor
            } else {
                imageMessage.layer.borderColor = UIColor.lightText.cgColor
            }
            imageMessage.clipsToBounds = true
            
                self.reactionView.parseMessageReactionForMessage(message: mediaMessage) { (success) in
                    if success == true {
                        self.reactionView.isHidden = false
                    }else{
                        self.reactionView.isHidden = true
                    }
                }
            if let userName = mediaMessage.sender?.name {
                name.text = userName + ":"
            }
            if mediaMessage.receiverType == .group {
                nameView.isHidden = false
            }else {
                nameView.isHidden = true
            }
            self.receiptStack.isHidden = true
            timeStamp.text = String().setMessageTime(time: mediaMessage.sentAt)
            if let avatarURL = mediaMessage.sender?.avatar  {
                avatar.set(image: avatarURL, with: mediaMessage.sender?.name ?? "")
            }else{
                avatar.set(image: "", with: mediaMessage.sender?.name ?? "")
            }
            if let mediaURL = mediaMessage.metaData, let imageUrl = mediaURL["fileURL"] as? String {
                let url = URL(string: imageUrl)
                if (url?.checkFileExist())! {
                    do {
                        let imageData = try Data(contentsOf: url!)
                        let image = UIImage(data: imageData as Data)
                        imageMessage.image = image
                    } catch {
                        
                    }
                }else{
                    parseThumbnailForImage(forMessage: mediaMessage)
                }
            }else{
                parseThumbnailForImage(forMessage: mediaMessage)
            }
              parseImageForModeration(forMessage: mediaMessage)
            replybutton.tintColor = UIKitSettings.primaryColor
            let tapOnImageMessage = UITapGestureRecognizer(target: self, action: #selector(self.didImageMessagePressed(tapGestureRecognizer:)))
            let tapOnImageMessage1 = UITapGestureRecognizer(target: self, action: #selector(self.didImageMessagePressed(tapGestureRecognizer:)))
            let tapOnImageMessage2 = UITapGestureRecognizer(target: self, action: #selector(self.didImageMessagePressed(tapGestureRecognizer:)))
            self.imageModerationView.isUserInteractionEnabled = true
            self.imageModerationView.addGestureRecognizer(tapOnImageMessage)
            self.unsafeContentView.isUserInteractionEnabled = true
            self.unsafeContentView.addGestureRecognizer(tapOnImageMessage1)
            self.imageMessage.isUserInteractionEnabled = true
            self.imageMessage.addGestureRecognizer(tapOnImageMessage2)
            
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
        }
    }
    
    var mediaMessageInThread: MediaMessage! {
        didSet {
            receiptStack.isHidden = true
            self.reactionView.parseMessageReactionForMessage(message: mediaMessageInThread) { (success) in
                if success == true {
                    self.reactionView.isHidden = false
                }else{
                    self.reactionView.isHidden = true
                }
            }
            if mediaMessageInThread.sentAt == 0 {
                timeStamp.text = "SENDING".localized()
            }else{
                timeStamp.text = String().setMessageTime(time: mediaMessageInThread.sentAt)
            }
             nameView.isHidden = false
            if let mediaURL = mediaMessageInThread.metaData, let imageUrl = mediaURL["fileURL"] as? String {
                let url = URL(string: imageUrl)
                if (url?.checkFileExist())! {
                    do {
                        let imageData = try Data(contentsOf: url!)
                        let image = UIImage(data: imageData as Data)
                        imageMessage.image = image
                    } catch {
                     
                    }
                }else{
                    parseThumbnailForImage(forMessage: mediaMessageInThread)
                }
            }else{
                parseThumbnailForImage(forMessage: mediaMessageInThread)
            }
            parseImageForModeration(forMessage: mediaMessageInThread)
            if mediaMessageInThread.readAt > 0 {
            timeStamp.text = String().setMessageTime(time: Int(mediaMessageInThread?.readAt ?? 0))
            }else if mediaMessageInThread.deliveredAt > 0 {
            timeStamp.text = String().setMessageTime(time: Int(mediaMessageInThread?.deliveredAt ?? 0))
            }else if mediaMessageInThread.sentAt > 0 {
            timeStamp.text = String().setMessageTime(time: Int(mediaMessageInThread?.sentAt ?? 0))
            }else if mediaMessageInThread.sentAt == 0 {
               timeStamp.text = "SENDING".localized()
                 name.text = LoggedInUser.name.capitalized + ":"
            }
            if let avatarURL = mediaMessageInThread.sender?.avatar  {
                avatar.set(image: avatarURL, with: mediaMessageInThread.sender?.name ?? "")
            }else{
                avatar.set(image: "", with: mediaMessageInThread.sender?.name ?? "")
            }
           replybutton.isHidden = true
        }
    }
    
    @objc func didImageMessagePressed(tapGestureRecognizer: UITapGestureRecognizer)
    {
        mediaDelegate?.didOpenMedia(forMessage: mediaMessage, cell: self)
    }
    
    // MARK: - Initialization of required Methods
    @IBAction func didReplyButtonPressed(_ sender: Any) {
             if let message = mediaMessage, let indexpath = indexPath {
                 CometChatThreadedMessageList.threadDelegate?.startThread(forMessage: message, indexPath: indexpath)
             }

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
    
    
    private func parseThumbnailForImage(forMessage: MediaMessage?) {
         imageMessage.image = nil
         if let metaData = forMessage?.metaData , let injected = metaData["@injected"] as? [String : Any], let cometChatExtension =  injected["extensions"] as? [String : Any], let thumbnailGenerationDictionary = cometChatExtension["thumbnail-generation"] as? [String : Any] {
             if let url = URL(string: thumbnailGenerationDictionary["url_medium"] as? String ?? "") {
                 self.imageMessage.image = UIImage(named: "default-image.png", in: UIKitSettings.bundle, compatibleWith: nil)
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
             if let url = URL(string: mediaMessage.attachment?.fileUrl ?? "") {
                 self.imageMessage.image = UIImage(named: "default-image.png", in: UIKitSettings.bundle, compatibleWith: nil)
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
         }
     }
     
     private func parseImageForModeration(forMessage: MediaMessage?) {
         if let metaData = forMessage?.metaData , let injected = metaData["@injected"] as? [String : Any], let cometChatExtension =  injected["extensions"] as? [String : Any], let imageModerationDictionary = cometChatExtension["image-moderation"] as? [String : Any] {
             if let unsafeContent = imageModerationDictionary["unsafe"] as? String {
                 if unsafeContent == "yes" {
                     imageModerationView.addBlur()
                     imageModerationView.roundViewCorners([.layerMaxXMaxYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMinXMinYCorner], radius: 15)
                     imageModerationView.isHidden = false
                     unsafeContentView.isHidden = false
                 }else{
                     imageModerationView.isHidden = true
                     unsafeContentView.isHidden = true
                 }
                
             }
         }
     }
    
    override func prepareForReuse() {
            imageRequest?.cancel()
    }
    
}

/*  ----------------------------------------------------------------------------------------- */

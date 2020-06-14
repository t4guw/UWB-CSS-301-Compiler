//
//  ViewController.swift
//  CSS301_Compiler
//
//  Created by Sam Wolf on 4/10/20.
//  Copyright © 2020 Sam Wolf. All rights reserved.
//

import Cocoa
import Vision

class ViewController: NSViewController {

    @IBOutlet weak var imageCell: NSImageCell!
    @IBOutlet weak var statusImageCell: NSImageCell!
    @IBOutlet weak var classificationLabel: NSTextField!
    var documentImage: NSImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    let model = CSS301MemoClassifier()
    let regionModel = PaperRegionDetector()
    
    @IBAction func chooseButtonClicked(_ sender: NSButtonCell) {
        let dialog = NSOpenPanel();
        dialog.title                   = "Choose an image or pdf";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["png", "jpeg", "pdf"];

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                let image = NSImage(byReferencing: URL(fileURLWithPath: path))
                self.imageCell.image = image
            }
        } else {
            // User clicked on "Cancel"
            return
        }

    }
    
    
    @IBAction func scanButtonClicked(_ sender: NSButtonCell) {
        
        if let image = self.imageCell.image {
            if let memoData = regionConfidence(forImage: convertToCGImage(image)) {
                print(memoData[0].count)
                print(memoData[1].count)
                print(memoData[0][0])
                print(memoData[0][1])
                
                print(memoData[1][0])
                print(memoData[1][1])
                print(memoData[1][2])
                print(memoData[1][3])
                if let memoLabel = sceneLabel(forImage: convertToCGImage(image)) {
                    print("Classified as: " + memoLabel)
                    let messageString: String
                    switch memoLabel {
                    case "Invalid Memo Images":
                        messageString = "Invalid Memo"
                        self.statusImageCell.image = NSImage(imageLiteralResourceName: "NSStatusUnavailable")
                    case "Valid Memo Images":
                        messageString = "Valid Memo"
                        self.statusImageCell.image = NSImage(imageLiteralResourceName: "NSStatusAvailable")
                    default:
                        messageString = "Error"
                    }
                    self.classificationLabel.stringValue = "Classified as: " + messageString
                }
            }
        }
    }
    
    func regionConfidence(forImage image: CGImage) -> [MLMultiArray]? {
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image) {
            guard let memo = try? regionModel.prediction(image: pixelBuffer, iouThreshold: nil, confidenceThreshold: nil) else {fatalError("Unexpected runtime error")}
            return [memo.confidence, memo.coordinates]
        }
        return nil
    }
    
    func sceneLabel(forImage image: CGImage) -> String? {
        if let pixelBuffer = ImageProcessor.pixelBuffer(forImage: image) {
            guard let memo = try? model.prediction(image: pixelBuffer) else {fatalError("Unexpected runtime error")}
            return memo.classLabel
        }
        return nil
    }
    
    func convertToCGImage(_ image: NSImage) -> CGImage {
        var imageRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        return image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)!
    }
    
}

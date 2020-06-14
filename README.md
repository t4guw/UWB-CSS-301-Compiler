# University of Washington | Bothell - CSS301 Compiler
#### README Last Updated 6/14/2020

#### Faculty Mentor: Professor Yusuf Pisan

#### Contributors: Sam Wolf, ...

### Overview

This project's intentions is to make a paper analyzer for CSS301 Professors and Students. It will not grade paper, but rather compile your paper and see if it "builds." Such as, does the paper have page numbers, correct headers, an underlined thesis, etc.
Since this is such a large undertaking, the project has been broken down. The intent is to start with the first C/C (Compare and Contrast) Paper. The work done so far has been analyzing the Memo for the C/C paper. Once the Compiler work for the C/C paper is finished, other papers shall be added.

### Dependencies

* CSS301 and its Topics
* A Mac running at least Catalina v10.15
* Xcode running at least v11.5
* CreateML running at least v1.0
* Some knowledge of the Swift language and Apple's Cocoa Touch Framework is very helpful for UI design

### Future Strategies and Work Needing to be Done

1. As of now, the Compiler only uses image classification. Meaning it will take an image and the `CSS301MemoClassifier.mlmodel` will take a guess whether or not it is a _Valid_ Memo.
   This is a good start, but not a helpful long term goal, since robust feedback would not be possible with Boolean based logic. A goal for the project is to research and see if it is possible to break down each paper element and train an object detection model to identify and determine each element.
   So far, there is one object detection model `PaperRegionDetector.mlmodel` that tries to determine and identify a memo as a singular element on an image.

2. Another work item is to design and develop a secure way to upload paper data to a Mac Server running the Compiler. Then downloading the Compiler's feedback. This should only be worked on after the C/C Paper Compiler itself is in a ready state.

### Helpful Resources

[Model Data & CSS301 Memo Guidelines](https://drive.google.com/drive/u/2/folders/1hqQHEx90_mig_EwS7NaiHCVbO6v38bYK)

[WWDC Video on the Introduction of CoreML](https://developer.apple.com/videos/play/wwdc2017/703/)

[WWDC Video on the More Advanced Topics of CoreML](https://developer.apple.com/videos/play/wwdc2017/710/)

[YouTube Video of Applied use of CoreML Object Detection](https://www.youtube.com/watch?v=3MXYwpifQOM)

[YouTube Video of Applied use of CoreML Image Detection](https://www.youtube.com/watch?v=NNKPbdT9gXU)

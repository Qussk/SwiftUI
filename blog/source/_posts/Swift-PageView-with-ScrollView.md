---
title: '[Swift]PageView(with:ScrollView)'
date: 2020-07-20 17:24:35
category: "ios"
tags:
- Swift
- UIPageView
- UIScrollView
thumbnail:
---


### **[PageView]** 

ScrollView와 세트인 PageView도 구현 

### 1.선언 
```swift 
//페이지뷰
lazy var pageControl = UIPageControl(frame: CGRect(x: view.frame.midX - 100, y: view.frame.maxY - 200, width: 200, height: 50))
```
### 2. Veiw ~ Constrain

```swift
view.addSubview(pageControl)
```
```swift
pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
    pageControl.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
   
```

### 3. pageViewControl
```swift
//MARK:-pageView
    func pageViewControl(){
    
      pageControl.numberOfPages = images.count
      pageControl.currentPage = 0
      pageControl.pageIndicatorTintColor = .lightGray
      pageControl.currentPageIndicatorTintColor = ColorPiker.customBlue
      pageControl.addTarget(self, action: #selector(handlePageControl(_:)), for: .valueChanged)
  
    }
    
@objc func handlePageControl(_ sender: UIPageControl) {
            let x = CGFloat(pageControl.currentPage) * scrollView.frame.width
            scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
          }
  }
```
### 4.ScrollView와의 연동(UIScrollViewDelegate)

```swift 
//MARK:-UIScrollViewDelegate
extension DescriptionViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
```

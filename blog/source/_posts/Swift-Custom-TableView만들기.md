---
title: '[Swift]CustomTableViewCell만들기'
date: 2020-05-28 20:44:57
category: "ios"
tags:
- Swift
- TableView
thumbnail: /image/custom1.png
---


- cellForRowAt의 기본방식을 이용하지 않고, cellForRowAt의  let cell: UITableViewCell 로 커스텀하여 접근. 


## TableViewCustom


```swift
import UIKit

final class TableViewCustomCell: UIViewController {
  
  override var description: String { "TableView - CustomCell" }
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.rowHeight = 80
    view.addSubview(tableView)
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
    tableView.register(CustomCell.self, forCellReuseIdentifier: "Custom")
  }
}

// MARK: - UITableViewDataSource
extension TableViewCustomCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: UITableViewCell
    
    if indexPath.row.isMultiple(of: 2) { //만약 나누기2로 떨어지면,
      cell = tableView.dequeueReusableCell(withIdentifier: "Custom", for: indexPath)

    //myLable접근이 안됨.. 되게 하려면?..
      (cell as! CustomCell).myLabel.text = "ABCDE"
    } else {
      cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
    }
    
    cell.textLabel?.text = "\(indexPath.row * 1000)"
    cell.imageView?.image = UIImage(named: "bear")
      
    //레이아웃이 필요한 곳이 아니기 떄문에, 딜리게이트에서 따로 잡아야함.
    print(tableView.rowHeight)  --> 44.0
    //프린트 찍어보면 높이가 기본인 44로 나옴. 위에 80으로 지정했음에도...->시뮬에서는 80으로 보이지만..
    //그래서 1.딜리게이트에서 직접 작업해주거나, 2.CustomCell에서 직접 레이아웃잡아야함. 
    (cell as? CustomCell)?.myLabel.frame = CGRect(
      x: cell.frame.width - 120, y: 15,
      width: 100, height: cell.frame.height - 30
    )

   return cell
  }
}


//1. 딜리게이트 작업 
// MARK: - UITableViewDelegate

extension TableViewCustomCell: UITableViewDelegate {
  // cellForRowAt -> willDisplayCell -> layoutSubviews

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let customCell = cell as? CustomCell else { return }
    customCell.myLabel.frame = CGRect(
      x: cell.frame.width - 120, y: 15,
      width: 100, height: cell.frame.height - 30
    )
  }
}

```


## Custom Cell

```swift
import UIKit

class CustomCell: UITableViewCell {
  
  let myLabel = UILabel()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
  // 커스텀 뷰를 올릴 때는 contentView 위에 추가
  myLabel.textColor = .black
  myLabel.backgroundColor = .yellow
  contentView.addSubview(myLabel)
  }
  
  // 스토리보드 생성할 때
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


//2. (여기에 넣음)

}
```
1)  상속받은 애가 _required_할 때 반드시 해야하는 init함수. 스토리보드로 만들게 될 경우, init 메서드가 위의 _override init_이 아닌,  required init?으로 오게 됨. 
2) _required_는 이미 부모 것을 받아서 쓰는 것이기 때문에 override할 필요없음(이미 되어 있음)


### 2.CustomCell의 레이아웃으로 조정할 경우.

```swift

// 레이아웃 조정 시
override func layoutSubviews() {
  super.layoutSubviews()
  
  //프레임 이용
  myLabel.frame = CGRect(
    x: frame.width - 120, y: 15,
    width: 100, height: frame.height - 30
  )
}
```

![](/image/custom2.png) 
- 결과 값 바뀜. 



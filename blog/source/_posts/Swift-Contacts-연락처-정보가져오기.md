---
title: '[Swift]Contacts - 연락처 정보가져오기'
date: 2020-08-08 09:52:18
category: "ios"
tags:
- Swift
- Contacts
thumbnail:
---



Contacts을 이용하여, 앱으로 연락처 정보를 가져오기,,! 




들어가기 전에 아래 CNContact에 대한 애플문서를 확인하자. 


[링크 : https://developer.apple.com/documentation/contacts/cncontact](https://developer.apple.com/documentation/contacts/cncontact)



문서를 요약하자면, 


![](/image/Contact3.png)



오른쪽의 정보들을 가져온다는 뜻.

나는 phoneNumbers와 

class func descriptorForAllComparatorKeys() -> CNKeyDescriptor
(연락처 정렬 비교기에 필요한 모든 키를 가져옵니다.)을 이용해 fullname을 가져왔다. 


자세한 내용은 
아래 코드에서 주석으로 숫자를 달았는데, 코드와 비교해보면서 읽어보길 바란다! 



## 1. ViewController

```swift
import UIKit
import Contacts

class ViewController: UIViewController {
  
  let tableView = UITableView(frame: .zero, style: .grouped)
  var objects = [CNContact]() //1-1.
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.rowHeight = 80
    tableView.backgroundColor = .white
    view.addSubview(tableView)
    
    tableView.register(testTableViewCell.self, forCellReuseIdentifier: "testTableViewCell")
    
    
    findContactsOnBackgroundThread { (contacts) in
      self.objects = contacts!
      self.tableView.reloadData()
    }
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  
  func findContactsOnBackgroundThread (_ completionHandler: @escaping (_ contacts:[CNContact]?)->()) {
    
    DispatchQueue.global(qos: .background).async(execute: { () -> Void in
      
      //1-2.
      let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]
      
      let fetchRequest = CNContactFetchRequest( keysToFetch: keysToFetch as! [CNKeyDescriptor])
      
      /* This is the array of objects that will be passed into the completion block.
       And then retrieved as the objects array
      objects 배열이 데이터를 검색함.
      */
      var contacts = [CNContact]()
      
      //1-3.
      CNContact.localizedString(forKey: CNLabelPhoneNumberiPhone)
      
      if #available(iOS 10.0, *) {
        fetchRequest.mutableObjects = false
      } else {
        // Fallback on earlier versions
      }
      
      //1-4.
      fetchRequest.unifyResults = true
      fetchRequest.sortOrder = .userDefault
      
      
      //연락처를 가져오는 중 에러남. 성공을 위해 do/try/catch block 필요.
      //1-5.
     do {
        
        // For each CNContact in your phone...
        try CNContactStore().enumerateContacts(with: fetchRequest) { (contact, stop) -> Void in
          //연락처를 정렬
  
          // If this contact has a phone number, append to the array
          if contact.phoneNumbers.count > 0 {
            contacts.append(contact)
          }
          
        }
        
        // Catch the error, if it exists
      } catch let e as NSError {
        print(e.localizedDescription)
      }
      
      DispatchQueue.main.async(execute: { () -> Void in
        //완성되면 contacts 배열을 제공
        completionHandler(contacts)
        
      })
    })
  }
  
}

//MARK: -UITableViewDataSource

extension ViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "testTableViewCell", for: indexPath) as! testTableViewCell
 
    
    let contact = self.objects[indexPath.row]
    
    configureCell(cell, contact: contact)
    return cell
    
  }
  
}

extension ViewController: UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 80
  }
  func configureCell(_ cell: testTableViewCell, contact: CNContact) {
      
      let formatter = CNContactFormatter()
      
      let contactPhoneNumber = (contact.phoneNumbers[0].value).value(forKey: "digits") as? String
      
      cell.personName.text = formatter.string(from: contact)
      cell.conditionMassge.text = contactPhoneNumber
  }
}

```
일단 테스트용으로 만든거라.. viewDidLoad가 빵빵 ㅎㅎ.. 

- 1-1. **objects = [CNContact]()** 는 CNContact(연락처)의 배열을 담은 객체

- 1-2. **연락처비교 : class func descriptorForAllComparatorKeys() ->. CNKeyDescriptor
(연락처 정렬 비교기에 필요한 모든 키를 가져옴.)**

```swift 
let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactPhoneNumbersKey] as [Any]

```
**keysToFetch**는 CNContactFormatter의 descriptorForRequiredKeys로 접근하여, **.fullName**을 가져오고 CNContactPhoneNumbersKey에도 접근하도록 하는 그릇이다.

이 그릇을 
```swift
   let fetchRequest = CNContactFetchRequest( keysToFetch: keysToFetch as! [CNKeyDescriptor])
```   
fetchRequest에

CNContactFetchRequest(연락처를 일치시키기위한 술어) 에 CNKeyDescriptor의 배열을 업캐스팅하여 CNKeyDescriptor의 정보를 가져온다.


CNKeyDescriptor에 대한 정보는 퀵헬퍼로 확인가능. 

![](/image/Contact4.png) 

이렇게 되어있었다 ! ...



- 1-3. **연락처 데이터 현지화 : 
class func localizedString(forKey: String) -> String
지역화 된 연락처 속성 이름이 포함 된 문자열을 반환.** 

```swift
CNContact.localizedString(forKey: CNLabelPhoneNumberiPhone)
   
   if #available(iOS 10.0, *) {
     fetchRequest.mutableObjects = false
   } else {
     // Fallback on earlier versions
   }
   
```
localizedString은 문자열을 반환하는 용도, 그중 CNLabelPhoneNumberiPhone 핸드폰 번호를 가져와 반환시킨다. 

만약 iOS10이하면,
fetchRequest.mutableObjects = falese로 
string의 값 뮤터블(변수) 변경불가능하게 처리

이전 버전의 폰이 왔을 때의 대비책인거 같다. 그런데 이미 프로젝트를 13이상에서만 다운할수 있도록 해놔서.. ㅎㅎ 안써도될듯하지만.. 공부해볼겸 ,,!!


1-4. 
```swift
//1-4.
 fetchRequest.unifyResults = true
 fetchRequest.sortOrder = .userDefault
```
**unifyResults**현재 연락처가 통합 연락처이고 지정된 식별자를 가진 연락처를 포함하는지 여부를 나타내는 Bool값. **sortOrder** 연락처의 정렬 순서를 나타냄




1-5. 연락처의 열거가 성공적으로 실행되었는지 판단. (ㅇㅖ외사항 처리)
*do/try/catch /block*을 이용해 오류 판단. 

```swift
     do {
       //1-5.
       // For each CNContact in your phone...
       try CNContactStore().enumerateContacts(with: fetchRequest) { (contact, stop) -> Void in
         //연락처를 정렬
 
         // If this contact has a phone number, append to the array
         if contact.phoneNumbers.count > 0 {
           contacts.append(contact)
         }
         
       }

```
do 나는 try하겠다, CNContactStore()을 통해, enumerateContacts(연락처 가져 오기 요청과 일치하는 모든 연락처의 열거가 성공적으로 실행되었는지 여부를 나타내는 부울 값을 반환)에 접근 ~ fetchRequest(검색 기준을 지정하는 연락처 가져 오기 요청.
)을 요청하여 (contact(성공), stop(오류))시 에 대한 정보 클로저 이용하여 성공 및 오류사항 정의. 


만약 성공시, contact.phoneNumbers.count > 0 { 이면 contxts.append(contact)
그냥 정렬한다는 소리...... 


```swift
} catch let e as NSError {
       print(e.localizedDescription)
     }
     
     DispatchQueue.main.async(execute: { () -> Void in
       //완성되면 contacts 배열을 제공
       completionHandler(contacts)
       
     })
   })
 }
```
만약 에러나면, e.localizedDescription을 프린트하고, 어씽크(시분할방식 - 비동기) 통해 completionHandler(비동기 완료시점)에 (contacts)반환 (Void를 반환)하여 오류가 반환됨. 

이 메서드는 열거가 완료 될 때까지 기다리기 때문에, 결과가 없으면 블록이 호출되지 않고 메서드가 true를 반환한다. 
모든 연락처를 한 번에 메모리에 보관하지 않고 모든 연락처를 가져오기 때문에 비용이 많이 든다. 

연락처 가져 오기 요청과 일치하는 모든 연락처의 열거가 성공적으로 실행되면 true이고, 그렇지 않으면 거짓



휴.... 동기/비동기를 다시 한번 훑어봐야겠다.. 
[동기/비동기 참고하기](https://m.blog.naver.com/PostView.nhn?blogId=jdub7138&logNo=220937372865&proxyReferer=https:%2F%2Fwww.google.com%2F)



셀 부분은 그냥 코드보면 대충 무슨 뜻인지 알것이라 생각하고 cell로 넘어가자. 



## 2. testTableViewCell 

```swift
import UIKit

class testTableViewCell: UITableViewCell {

     let identifier = "testTableViewCell"

      let personImage = UIImageView()
      let personName = UILabel()
      let conditionMassge = UILabel()
      let inPerson = UIButton()
  
//      let personAddButton = UIButton()
  
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          
          selectionStyle = .none
          
          personImage.backgroundColor = .systemGray4
          personImage.image = UIImage(systemName: "person")
          personImage.tintColor = .lightGray
          personImage.layer.cornerRadius = 15
          contentView.addSubview(personImage)
          
          personName.text = "이름"
         // personName.font = UIFont.boldSystemFont(ofSize: 17)
          conditionMassge.font = UIFont(name: "PingFangHK-Medium", size: 17)
          contentView.addSubview(personName)
          
          conditionMassge.text = "즐거운 하루~~ 빛나는 미래가 보여🐶"
          conditionMassge.font = UIFont(name: "PingFangHK-Thin", size: 14)
          conditionMassge.textColor = .gray
          contentView.addSubview(conditionMassge)

        //  conditionCheck.text = "21분전"
          inPerson.setTitle("+ 초대", for: .normal)
          inPerson.titleLabel?.font = UIFont(name: "PingFangHK-Medium", size: 12)
          inPerson.setTitleColor(.black, for: .normal)
          inPerson.layer.borderColor = UIColor.black.cgColor
          inPerson.backgroundColor = .yellow
          inPerson.layer.borderWidth = 1
          inPerson.layer.cornerRadius = contentView.frame.width/23
          contentView.addSubview(inPerson)
          
          setConstrain()
          
        }
        
      func setConstrain(){
        
        레이아웃은 생략..

        ])
        
      }
        required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
        }
      
}
```

위의 vc가 연락처목록을 가져오는 tablewView였다면, estTableViewCell은 
그에 대한 셀이다. 

테스트용으로 만든것이라서.. 변수명이 좀 헷깔릴 수 있는데



conditionMassge가 폰넘버에 해당된다. 원래 상태메세지 가져오는 걸 구현할 계획이었던거라.. 번호는 사실 셀에 표현안되어도 되지만 눈으로 확인하기 위해 여기다가 뿌렸다..ㅋㅋㅋ.... 


아래 이미지를 보면 이해가 더 쉬울것 같다. 🙂




![](/image/Contacts.png)


이러케 ㅎㅎ... 


어쨌든 나는 이름과 폰넘버만 가져왔지만, 
필드만 지정해주면 연락처상에 저장된 모든 데이터(NCContact)를 통해 메모,이메일, 기념일?등도 가져올 수 있다는점 !!!



그리고 폰넘버가 만약 2개 저장된 정보라면, 가장 상단에 있는 값을 가져온다는 점! 

알아두면 좋을 듯 하다! 




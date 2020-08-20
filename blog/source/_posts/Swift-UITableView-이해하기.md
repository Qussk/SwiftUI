---
title: '[Swift]UITableView 이해하기.md'
date: 2020-05-27 13:28:04
category: "ios"
tags:
- UITableView
- TableView
- Swift
thumbnail: /image/table1.png
---


## UITableView 종류 

Tableview는 크게 2가지로 나뉜다.  
기본 나열방식인 Plain 과 그룹핑으로 표현되는 Group.

![](/image/table1.png)


- Group Table View의 경우 Padding과 Header ~ TableCell ~ Footer과 Padding순으로 잘 기억해야한다. 



## UITableView를 사용하기 이전에 준비해야할 것. 

### UITableViewDataSource 

- UITableView를 사용하기 위해 UITableViewDataSource에 대한 권한 설정은 필수다. 
(class에  이용하여 할당해줘야함. )


viewController 


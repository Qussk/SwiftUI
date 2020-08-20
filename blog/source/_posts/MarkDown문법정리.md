---
category : "기타"
title: MarkDown문법정리
date: 2020-04-29 20:47:38
tags:
- MaskDown
---


# MarkDown 문법정리 



## 제목스타일 

# 헤딩1
## 헤딩2
### 헤딩3
#### 헤딩4

```
# 헤딩1
## 헤딩2
### 헤딩3
#### 헤딩4
```


## 항목(List)만들기

#### 항목으로만 입력. 

* Item 1 
* Item 2 
    * Item 2a 
    * Item 2b 

```       
* Item 1 
* Item 2 
    * Item 2a 
    * Item 2b 

("*"로 구분하면 됨. *안에 *를 추가하면 하위 항목으로 새로 추가됨)    
  ```



#### 순차적으로 정렬 

1. Item 1 
1. Item 2 
1. Item 3 
    1. Item 3a 
    1. Item 3b

  ```
1. Item 1 
1. Item 2 
1. Item 3 
    1. Item 3a 
    1. Item 3b
 
('1'숫자 붙히면 순차적으로 정렬됨. 위와 동일하게 1.안에 1.추가하면 하위 항목으로 추가됨.) 

  ```
 



## 문장입력

문장 입력시 공백을주지 않으면, 앞문장과 뒷문장이 서로 붙음. 이에 스페이스바를 두 번 이상 누를 경우  
위 문장과 분리되어 다음줄에 입력됨 <br> `<br>` 도 동일하게 이용가능



## 취소선 

~~취소선~~


## 이미지 등록(Image)


#### 첫번째 

![이미지 실험](image/Lemon.png)

```
![이미지 이름]+(url링크)
```


#### 두번째 
![마크다운로고](https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Markdown-mark.svg/330px-Markdown-mark.svg.png)  
  ```
  ![text](image태그 url붙여넣기)
  ```
  





## 하이퍼링크(Links)
[GitHub](http://github.com/Qussk "깃허브")






## 코드 블록(Code Blocks) 

```javascript 
function test() { 
 console.log("hello world!"); 
} 
```
``````
javascript 
function test() { 
 console.log("hello world!"); 
} 
``````




## 인용 상자(Blockquotes)

As Grace Hopper said: 

> I’ve always been more interested. 
> in the future than in the past.

```
As Grace Hopper said: 

> I’ve always been more interested. 
> in the future than in the past.
```



## 강조 (Emphasis)


### 이탤릭체

*This text will be italic* 
_This will also be italic_ 

```
*This text will be italic* 
_This will also be italic_ 
```


### 굵게

**This text will be bold** 
__This will also be bold__ 

```
**This text will be bold** 
__This will also be bold__ 
```


### 부분 강조

*You **can** combine them*

```
*You **can** combine them*
```




## 테이블 TABLES


First Header | Second Header 
------------ | ------------- 
Content cell 1 | Content cell 2 
Content column 1 | Content column 2


```
First Header | Second Header 
------------ | ------------- 
Content cell 1 | Content cell 2 
Content column 1 | Content column 2
```


## 체크 박스(Task Lists)

- [x] this is a complete item 
- [ ] this is an incomplete item 
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported 
- [x] list syntax required (any unordered or ordered list supported)

```
- [x] this is a complete item 
- [ ] this is an incomplete item 
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported 
- [x] list syntax required (any unordered or ordered list supported)
```


## 인라인 코드(Inline code)

문단 중간에 `Code`를 넣을 수 있습니다. 
예를 들어 `printf("hello world!");` 이런 식으로 들어갑니다.





## 수평선(hr)


--- 

*** 

___

```
--- 
*** 
___
```


## 탈출 문자 (Backslash Escapes)


＼*literal asterisks＼* 
*literal asterisks* 
__＼*＼*Text＼*＼*__ 
_＼_Tom＼__


```
＼*literal asterisks＼* 
*literal asterisks* 
__＼*＼*Text＼*＼*__ 
_＼_Tom＼__
```



## 이모지(EMOJI) - 아이콘

[emoji로 이동>>>](http://emoji-cheat-sheet.com)

GitHub supports emoji! 
:+1: :sparkles: :camel: :tada: 
:rocket: :metal: :octocat:

```
GitHub supports emoji! 
:+1: :sparkles: :camel: :tada: 
:rocket: :metal: :octocat:
```


## 배지(badge) 만들기

[shields.io](https://shields.io/)
로 접속


license 로 이동 / 본인이 직접 만들어도 됨 


APM: /apm/l/:packageName.svg   
AUR license: /aur/license/:packageName.svg

<img src="https://img.shields.io/badge/license-mit-orange">

```
<img src="https://img.shields.io/badge/license-mit-orange">
```



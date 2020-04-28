# SpringProject2
<hr>
개발환경 - Windows10

사용도구 - Eclipse, Dbeaver, MyBatis, Oracle, Spring Framework 

사용기술 - Java, Jsp, Spring3.0, Oracle 11g, JS,jQuery, XML


# Communicate Board with file
<hr>

Communicate게시판은 로그인한 유저들끼리 서로의 정보를 파일로 올려 공유하고 방명록을 이용해 친목동호가 가능한 게시판입니다
로그인한 유저만 게시글의 작성이 가능하며 To-do List를 작성해 자신의 계획도 함께 세울 수 있습니다

또한 로그인시 비밀번호가 암호화되어 비밀번호의 유출 가능성을 막았습니다.
Spring security를 사용하여 user가 관리자(admin)의 페이지로 이동할 시 페이지에 접속할 수 없도록 만들었습니다.
관리자 게시판은 오직 admin으로 권한이 지정되어있는 사람만 관리자게시판으로 이동이 가능해 유저의 자격 (user인지 admin)인지 알 수 있습니다. 

# 구현화면

* 일반유저로그인시
![intro](https://user-images.githubusercontent.com/59599438/80486508-3f667380-8996-11ea-9ff7-4bcd070d6092.png)

* 파일업로드게시판:첨부파일의 개수만큼 디스크모양의 이미지가 나타납니다 
![1](https://user-images.githubusercontent.com/59599438/80486558-50af8000-8996-11ea-93da-90f4fdd6e530.png)

* 방명록게시판 :User만 게시글 작성이 가능하도록만들었습니다. 
![2](https://user-images.githubusercontent.com/59599438/80486567-560cca80-8996-11ea-9c86-467c14b9218b.png)

* To-do List게시판:DONE과 진행중으로 나누어 계획이 실천되었을 시 DONE으로 수정이 가능합니다
![3](https://user-images.githubusercontent.com/59599438/80486575-5a38e800-8996-11ea-9af3-9ea5eeb85ea2.png)

* 권한이 USER인 유저가 ADMIN페이지로 접속을 시도할 시 시큐리티에서 접금제한 페이지를보냅니다
![20200428_203026](https://user-images.githubusercontent.com/59599438/80487294-8acd5180-8997-11ea-8ad0-9c784af515d1.png)

# admin계정로그인시

* 일반유저와 달리 ADMIN으로 접속한 유저는 관리자페이지로 접속이 가능합니다
![20200428_212438](https://user-images.githubusercontent.com/59599438/80487055-290ce780-8997-11ea-8641-86b7315bd933.png)
![admin](https://user-images.githubusercontent.com/59599438/80486830-c1ef3300-8996-11ea-8da9-60f342f4a6ae.png)

* 멤버관리 게시판으로 가면 유저들의 권한자격을 알수있습니다. 
권한은 유저멤버에 있는 USERID를 가져와서 USER_ADMIN으로 지정하였습니다 .
ADMIN은 ROLE_USER와 ROLE_ADMIN 두 개의 권한을 가지고있습니다
![ad2](https://user-images.githubusercontent.com/59599438/80486853-cd425e80-8996-11ea-9f91-dcce99a704b2.png)

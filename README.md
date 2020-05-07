# SpringProject2
<hr>
개발환경 - Windows10


사용도구 - Eclipse, Dbeaver, MyBatis, Oracle, Spring Framework 

사용기술 - Java, Jsp, Spring, Oracle, JS,jQuery,BootStrap,Html,css

전체화면구현은 https://www.notion.so/Project-2-Communicate-board-90ab09295f5e4c6393e503561c62956c 을 통해서 확인하실 수 있습니다


# Communicate Board with attachment
<hr>
 User- 아이디:mr9418@naver.com 비밀번호:1234 
 
 
 admin- 아이디:admin@naver.com 비밀번호:1234

Communicate 게시판은 로그인한 사용자들끼리 서로의 정보를 파일로 올려 공유하고 방명록을 이용해 친목 동호가 가능한 게시판입니다
로그인한 사용자만 게시글의 작성이 가능하며 To-do List를 작성해 자신의 계획도 함께 세울 수 있습니다

또한 로그인 시 비밀번호가 암호화되어 비밀번호의 유출 가능성을 막았습니다.
Spring security를 사용하여 user가 관리자(admin)의 페이지로 이동할 시 페이지에 접속할 수 없도록 만들었습니다.
관리자 게시판은 오직 admin으로 권한이 지정되어있는 사람만 관리자 게시판으로 이동이 가능해 사용자의 자격 (user인지 admin)인지 알 수 있습니다. 

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

# FrameWork 설계
[ Spring 4.3.2 ]

* Resource Mapping을 통한 리소스 폴더 관리

* 비밀번호 암호화를 통한 보안강화

[ MyBatis ]

* MyBatis와 Oracle 연동 구현
* Connection Pool 셋팅을 통한 DB 연결 최적화

[ Log4j ]

* 패키지별 로그 설정을 하여 디버깅 효율성 향상

[ Maven ]

* 라이브러리 관리를 위해 사용

[Dbeaver]

* 테이블관리를 위해 사용


# CODE
회원가입 후 DB에 저장을 할 시 자동으로 USER_ROLE의 권한을 갖도록 하였습니다. 
![20200428_214929](https://user-images.githubusercontent.com/59599438/80489302-94a48400-899a-11ea-934e-70b6f1748fef.png)


DB에 저장을 하면 비밀번호가 bcryptPasswordEncoder에 의해서 암호화로 바뀌도록 설정하였습니다
![20200428_202726](https://user-images.githubusercontent.com/59599438/80489505-e0efc400-899a-11ea-9e2a-f2dcf66f9cef.png)

memberVO와memberRoleVO에 있는 객체들을 연결시키기위해 사용한코드입니다 
PagingVO에서 List를 가져올때 memberDAO에 있는 selectRoleList를 사용하여 member_role테이블의 username을 가져왔습니다
그리고 userid(username)을 키 값으로 지정해 for문을 사용해 DB에 저장되어있는 username이 있을 시 role도 같이 가져올수있도록 설정하였습니다
![20200428_215012](https://user-images.githubusercontent.com/59599438/80489315-99693800-899a-11ea-968c-59c2b0889d31.png)


security-context의 부분입니다
 password-encoder는 bcryptPasswordEncoder를 사용하였고 권한은 member테이블에 저장되어있는 userid 하나를 들고와서 member_role테이블에 username으로 지정하였습니다
![20200428_215130](https://user-images.githubusercontent.com/59599438/80489330-9e2dec00-899a-11ea-8dd0-d704ab19783f.png)

 메일샌더를 이용해서 회원가입한 유저의 이메일로 회원가입환영 메일을 보냈습니다
![m1](https://user-images.githubusercontent.com/59599438/80496658-7a6fa380-89a4-11ea-9d2f-1debc269e586.png)

![m2](https://user-images.githubusercontent.com/59599438/80496674-7e032a80-89a4-11ea-8554-c9c8090173fc.png)

![20200428_205314](https://user-images.githubusercontent.com/59599438/80497328-3fba3b00-89a5-11ea-8df0-27df94366d09.png)

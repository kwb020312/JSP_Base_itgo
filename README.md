# Jsp

[총 정리 PPT 보기](https://github.com/kwb020312/JSP_Base_itgo/files/10801005/2023_02_21_JSP._._.pptx)

![image](https://user-images.githubusercontent.com/46777310/220549874-6d1c9b5b-4402-48fa-b7af-77c280efea1c.png)

### 😁알게된 점

- 중급 Part1
    - JSP에서 말하는 `beans` 는 자바 기준에서의 클래스 이다.
    - `jsp:getProperty`, `jsp:setProperty` 는 자바의 `getter`, `setter`와 동일하다.
    - `jsp:setProperty`의 property 속성에 * 를 선언하면, 지역변수 초기화를 의미한다.
- 중급 Part2
    - MySQL을 활용한 `CREATE`, `DELETE`, `UPDATE`, `ALTER`에 대해 학습
- 중급 Part3
    - `Class.forName`의 역할 - Driver 객체 생성
    - `Statement`대신 `PreparedStatement`사용하는 이유
        - Statement
            - 사용자의 입력값에 따라 쿼리문의 형태가 바뀔 수 있어 보안에 취약하다.
                - `OR 1=1`과 같은 값이 전달된다면, 모든 사용자의 정보가 노출됨
            1. 쿼리 문장 분석
            2. 컴파일
            3. 실행
            - 위 세 단계를 호출될 때마다 거치며 DB에 부하를 줄 수 있다.
            - ResultSet에 할당된 값이 있는 경우 Statement가 close() 되면 ResultSet 또한 값을 잃는다.
        - PreparedStatement
            - 사전에 정의된 쿼리를 호출하며 `?`부분에만 변화를 주어 쿼리문의 형태가 바뀌지 않는다.
            - 정의된 분석, 컴파일, 실행의 단계를 선언될 때만 거친 후 캐시에 담아 재사용하기 때문에 성능상 용이하다.
            - ResultSet에 값을 할당했을 때, PreparedStatement가 close() 되더라도 ResultSet은 값을 유지한다.
- 중급 Part4
    - 커넥션 풀 (`DBCP`)
        - XML형태의 Resource 코드를 작성해놓고, 클라이언트가 필요로 할 때 가져다 쓰는 개념이며, 재활용이 가능하여 매번 새로운 코드를 작성하지 않아도 된다.
        - `Context` {변수} = new InitialContext() // context.xml의 경로를 얻기 위함
        - `{변수}.lookup()` 익명 경로인 `"java:comp/env"`에 접근하며 context.xml에 `Resource`항목에 지정한 `name`의 값을 지정한다.
- 중급 Part5
    - 서버에 파일을 업로드하는 방식에 대해 학습
    - MultipartRequest
        - cos.jar
    - 아파치 API
        - commons-fileupload.jar
            - 상대적으로 사용에 필요한 데이터 타입이 많지만, 로딩 퍼센테이지 등 다양한 모듈이 지원됨
        - commons-io.jar
            - 상대적으로 간편하나, 파일 업로드에 관한 최소한의 기능이 제공됨
- 중급 Part6
    - 데이터 중복 및 원치 않는 값의 방지를 위한 유효성 검사
        - 데이터 유무의 검사
            - `JS`를 사용한 `HTMLElement.target.value.length`를 활용한 검사를 진행
        - 원치 않는 형태의 데이터 검사
            - `JS` & `정규표현식`을 활용한 `HTMLElement.target.value`를 활용한 검사를 진행
- 중급 Part7
    - 기존의 표현식 `<%= 변수명 %>` 과`${ 변수명 }` 과 같은 구조의 `EL(Expression Language)` 의 장점 및 사용 예시를 보며 학습
    - `JSTL`에 대해 알아보고 `c:if`, `c:choose` 등 자주 사용되는 키에 대해 학습
- 중급 Part8
    - 다국어 처리 방법에 대해 학습
        - 지역화: 사용 국가별 환경에서 특정 지역에 맞게 적합화 함
        - 국제화: 여러 국가에서 사용이 가능하도록 다국어 지원
            - 숫자, 날짜, 시간
            - 화폐
    - `java.util.Locale request.getLocale();`
        - 현재 브라우저에 정의된 언어나 국가 정보를 가져올 수 있다.
    - `fmt JSTL`에 대해 학습
- 중급 Part9
    - 보안처리 방법에 대해 학습
        - 선언적 시큐리티
            - `web.xml`파일에 역할을 선언하여 보안처리
            - 선언된 role의 사용자 인증으로 원치않는 접근을 제어하는 방법에 대해 학습
        - 프로그래밍적 시큐리티
            - 선언적 시큐리티의 보안이 충분치 않을 때 `request`내장 객체의 메소드를 활용하여 사용
- 중급 Part10
    - `필터(filter)`에 대해 학습
        - 데이터의 필요 부분만을 걸러내는 역할을 한다.
        - 여러개의 `필터`가 모여 하나의 연결을 형성하는 것을 `필터 체인`이라고 한다.

Jsp 기초에서 실무까지 완전정복 하기 고급 Part1 - Part4

- 고급 Part1
    - `RequestDispatcher`를 통한 요청 위임
        - `response.sendRedirect`로 페이지를 이동하게 될 경우, `request`객체가 달라지므로, 데이터의 이전이 불가능함
    - 클라이언트로부터 요청을 받았을 때 작업을 직접 처리하지 않고 담당 서블릿을 분산시켜 처리하도록 하는것을 `Command`패턴이라고 한다.
- 고급 Part2
    - `DataBase(DB)`연동을 통해 쇼핑몰 사이트를 구축하고 필요한 정보를 추출, 저장함
- 고급 Part3
    - 회원가입을 구현하고 `DataBase(DB)`를 통해 관리함
- 고급 Part4
    - `MVC`패턴이 무엇인지 학습하고, 패턴에 맞는 프로그래밍으로 게시판 구현

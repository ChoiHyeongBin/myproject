# GreenStyle Project

### 1. Project명 <br />
GreenStyle이라는 이름의 쇼핑몰이고 역동적이고 편리한 UI, 깔끔하고 기능에 충실한 쇼핑몰을 만들어보고자 하여 개발하게 되었습니다. 남여 옷을 판매하고 있고, 사이트에서 추천하는 코디(cody) 카테고리도 만들어 보았습니다. 4명으로 이루어진 팀이었고 각자 업무를 분담하여 본인은 로그인 화면, 장바구니, 주문결제, 주문완료 및 상세보기, 고객센터의 공지사항, 페이지 최하단 푸터 영역, Admin 주문관리를 구현하였습니다. 주요 기능으로는 
1) 로그인 외 비회원 구매, 주문조회 가능
2) 마이페이지에서 리뷰 작성 및 별점(최대 5점) 부여
3) 1:1 고객상담에서 주문찾기 시 설정한 기간으로 주문조회
4) 상품 이미지 자동 전환
5) 관리자 로그인 시 판매/취소/반품 현황 확인 가능
6) 통계 메뉴에서 많이 판매된 상품, VIP고객, 매출액 등 확인 가능


### 2. 사용방법 <br />
개발 툴은 Eclipse이고 서버는 apache-tomcat-8.5.53 버전이며, DBMS는 MySQL을 사용하였습니다. <br />
- 실행방법 <br />
1. 먼저 eclipse의 Pakage Explorer 창에서 Dynamic Web Project 클릭하여 프로젝트를 생성합니다. <br />
2. 생성된 프로젝트 폴더에 오픈소스의 GreenStyle/WebContent/WEB-INF/lib 폴더 안의 jar 파일들을 같은 폴더명에 복사 <br />
3. WebContent/META-INF 폴더의 context.xml 파일 복사 <br />
4. 그 외의 META-INF, WEB-INF 폴더를 제외한 WebContent 폴더 내의 모든 폴더 및 파일들(.jsp) 복사
5. WebContent 이전 폴더로 이동하여 src 폴더 복사
6. eclipse에서 index.html 파일로 프로젝트 실행

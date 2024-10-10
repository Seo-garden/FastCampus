# C사 커머스앱 클론 코딩

[패스트캠퍼스 C사 클론 코딩](https://fastcampus.co.kr/dev_online_ios)

### 🌟 기능 및 구현 내용
</br>

<img src="https://github.com/Seo-garden/FastCampus/blob/main/part6/구매하기.PNG" alt="" width="200" height="300">  <img src="https://github.com/Seo-garden/FastCampus/blob/main/part6/좋아요.PNG" alt="" width="200" height="300">  <img src="https://github.com/Seo-garden/FastCampus/blob/main/part6/상세정보.PNG" alt="" width="200" height="300">  <img src="https://github.com/Seo-garden/FastCampus/blob/main/part6/구매하기.PNG" alt="" width="200" height="300">


### 🐚 주요 기능
<br/>

    1. 메인탭
    - 사용자가 구매할 수 있는 품목들이 비동기로 가져옴
    - 쿠폰을 발매받을 수 있음 (UserDefalut에 저장)

    2. 좋아요탭
    - 사용자가 좋아요 누른 품목을 볼 수 있는 화면
    
    3. 제품 상세정보
    - 사용자가 구매를 희망하는 품목의 상세한 정보를 볼 수 있음
    - 상품정보를 모두 보여주지 않고 더보기를 통해 보여줌으로, 서버의 부하를 덜어줌

    4. 구매하기
    - 사용자가 주문을 희망하는 목록을 보고, 구매할 수 있는 화면
    

### 🛠️ Framework + Library

<br/>

| 카테고리 | 이름 |  태그   |  
| :--------: | :--------: | :------: | 
|   프레임워크    |   SwiftUI + UIKit    | Storyboard + Codebase |
|       |   WebKit    | WKWebView |
|   Library    |   Combine    | 반응형 프로그래밍 | 
|       |   Kingfisher    | Image Caching |
|       |   Lottie    | Launch Screen |

### 🌟 완성하기까지의 과정 😅
<br/>

<details>
  <summary>⭐️ 배운점</summary>        
  SwiftUI가 등장함으로써 트위터 클론코딩을 진행할 때, 스토리보드 방식은 레거시라고 생각했었습니다. 사용한지 오래된 기술이니 레거시라고 판단하는 안좋은 생각을 바꿀 수 있는 기회였습니다. 아직까지도 스토리보드 방식은 눈으로 직접 보면서 배치가 가능하기 때문에, 한 화면의 오브젝트가 관리되기 힘들 정도가 아니라면 스토리방식을 여전히 사용할 것 같습니다. 그리고 여러가지 뷰들을 사용해봄으로써, 의도한 화면에 대한 뷰를 어떤걸 사용해야 할지에 대해 알게 되었습니다.
</details>

<details>
  <summary>⭐️ Combine? RxSwift? </summary>
  비동기적인 작업을 처리하기 위해 escaping closure를 사용했었는데, 중첩 클로저를 사용해 직관적이지 않아 유지보수가 어려웠습니다. 그러던 중 반응형 프로그래밍 도구인 Combine, RxSwift 에 대해 알게 되었고, 직접 강의를 보고 사용해보면서 중첩 클로저를 개선할 수 있었습니다.
</details>




### Property Wrappers
> [!NOTE] @State
> - SwiftUI 에서 상태를 처리하는 방법
> - 뷰의 상태를 저장하는 프로퍼티로 상태 관리 주체는 해당 뷰
> - 기본적으로 Private 선언이기에 다른 뷰와 값을 소통하려면 Binding 을 이용
> - 값이 변경될 때 마다 UI 업데이트
> 보통 사용하는 경우에는 사용자의 입력으로 변경되거나, 화면 전환 및 애니메이션의 경우 사용된다.

> [!NOTE] @Binding
> - 뷰와 상태를 바인딩 하는 방법
> - 상위 @State 변수를 전달 받아 하위 뷰에서 캐치해 변화 감지 및 연결
> - Binding 은 다른 뷰가 소유한 속성을 연결하기에 소유권 및 저장 공간이 없음

> [!NOTE] @Published
> - ObservableObject 를 구현한 클래스 내에서 프로퍼티 선언 시 사용
> - @Published 로 선언된 프로퍼티를 뷰에서 관찰할 수 있음
> - ObservableObject 의 objectWillChange.send() 기능을 @Published 프로퍼티가 변경되면 자동호출

> [!NOTE] @ObservedObject
> - 뷰에서 ObservableObject 타입의 인스턴스 선언 시 사용
> - ObservableObject 의 값이 업데이트되면 뷰를 업데이트

> [!NOTE] @StateObject
> - 뷰에서 ObservableObject 타입의 인스턴스 선언 시 사용
> - 뷰마다 하나의 인스턴스를 생성하며, 뷰가 사라지기 전까지 같은 인스턴스 유지
> - @ObservedObject 의 뷰 렌더싱 시 인스턴스 초기화 이슈 해결을 위한 방법
> - 매번 인스턴스가 새롭게 생성되는것처럼 외부에서 주입 받는 경우가 아닌 최초 생성 선언 시에 @StateObject 를 사용하는 것이 적절한 방법

> [!NOTE] @Environment
> - 미리 정의되어 있는 시스템 공유 데이터
> - 사용하려는 공유 데이터의 이름을 KeyPath로 전달하여 사용
> - 시스템 공유 데이터는 가변하기에 var 로 선언 필요
> - 뷰가 생성되는 시점에 값이 자동으로 초기화됨

> [!NOTE] @EnvironmentObject
> - ObservableObject 를 통해 구현된 타입의 인스턴스를 전역적으로 공유하여 사용
> - 앱 전역에서 공통으로 사용할 데이터를 주입 및 사용


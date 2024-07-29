# FastCampus

> [!NOTE] Completion
> Completion Handler 는 비동기 작업이 끝났을 때 호출되는 클로저로, 일반적으로 네트워크 요청이나 파일 I/O 와 같은 시간이 걸리는 작업에서 사용된다

> [!NOTE] snapshot
> 스냅샷은 주로 UI 관련 작업에서 사용되는데, 특정 시점의 데이터 상태를 캡처하는데 사용됩니다. 예를 들어, UITableViewDiffableDataSource 는 테이블 뷰의 상태를 나타내기 위해 snapshot 을 사용하게 된다

```
snapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels {      //해당값이 API에서 값이 전혀 없다면 배너 조차 만들지 않음

            snapshot.appendSections([.banner])

            snapshot.appendItems(bannerViewModels, toSection: .banner)

        }
```

> [!NOTE] UIKit 기반 프로젝트를 #Preview 에서 Crashed 가 발생할 때
> 시뮬레이터는 이상이 없었는데, 크래쉬가 발생하면서 프리뷰가 안될 때, 클린 빌드를 해본다!

> [!NOTE] Swift Combine 에 대해 파헤치다가
> https://green1229.tistory.com/332

> [!NOTE] @MainActor
> MainActor 는 자동으로 UI관련 API 가 메인스레드에서 적절하게 디스패치 되도록 제공하는 속성이다. 즉, Swift Concurrency를 사용하고 MainActor가 표시된 컨텍스트 내에서 비동기 코드를 작성하면 실수로 백그라운드 큐에서 UI 업데이트를 해주는 오류에 대해 더 이상 걱정할 필요가 없다.


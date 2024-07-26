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

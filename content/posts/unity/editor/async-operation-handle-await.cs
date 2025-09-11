
# AsyncOperationHandleAwait

최근에.. OnInspectorGUI 함수 깊숙한 스택에 `AsyncOperationHandle` = 어드레서블 리소스 로드를 사용하는 곳이 있었다.

자꾸 pending 상태가 되어 왜 그런가 싶었는데 내부 구조를 확인해보니 AsyncOperationHandle 는 플레이어 루프에서만 정상 동작한다.

따라서 다음과 같이 조치할 수 있었다

```cs

  OnClickRow(target, kvp.Key).Forget();
                    
                    // 이걸 넣어줘야 AsyncOperatitonHandle이 플에이어루프ㅇㅔ서 돌아서 제대로 반영됨.
                    UnityEditor.EditorApplication.QueuePlayerLoopUpdate();
```
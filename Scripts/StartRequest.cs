using Unity.Entities;

public struct StartRequest : IComponentData{
    // 処理を開始するときはStartRequestとWaitTaskの２つをアタッチする
}
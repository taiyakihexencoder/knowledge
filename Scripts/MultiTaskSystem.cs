using Unity.Collections;
using Unity.Entities;

public partial struct MultiTaskSystem : ISystem {
    private EntityQuery startQuery;
    private EntityQuery requestQuery;
    private EntityQuery taskQuery;

    void ISystem.OnCreate(ref SystemState state) {
        startQuery = new EntityQueryBuilder(Allocator.Temp)
            .WithAll<StartRequest, WaitTask>()
            .Build(ref state);
        requestQuery = new EntityQueryBuilder(Allocator.Temp)
            .WithAll<StartRequest>()
            .Build(ref state);
        taskQuery = new EntityQueryBuilder(Allocator.Temp)
            .WithAll<WaitTask>()
            .Build(ref state);
        state.RequireForUpdate(requestQuery);
    }

    void ISystem.OnUpdate(ref SystemState state) {
        EntityCommandBuffer commandBuffer = GetCommandBuffer(ref state);

        if (!startQuery.IsEmpty) {
            state.Dependency = new StartJob {
                commandBuffer = commandBuffer,
            }.Schedule(startQuery, state.Dependency);
        }

        if (taskQuery.IsEmpty) {
            commandBuffer.DestroyEntity(requestQuery, EntityQueryCaptureMode.AtPlayback);

            // -- 完了時処理 -- // 
        }
    }

	private EntityCommandBuffer GetCommandBuffer(ref SystemState state) {
		return SystemAPI.GetSingleton<EndSimulationEntityCommandBufferSystem.Singleton>().CreateCommandBuffer(state.World.Unmanaged);
	}

    partial struct StartJob : IJobEntity {
        public EntityCommandBuffer commandBuffer;

        void Execute(in Entity entity) {
            commandBuffer.RemoveComponent<WaitTask>(entity);

            // -- 後続処理 -- //
            Entity task1Entity = commandBuffer.CreateEntity();
            commandBuffer.AddComponent(task1Entity, new WaitTask {});
            commandBuffer.AddComponent(task1Entity, new OtherTask1 {});

            Entity task2Entity = commandBuffer.CreateEntity();
            commandBuffer.AddComponent(task2Entity, new WaitTask {});
            commandBuffer.AddComponent(task2Entity, new OtherTask2 {});

            ...
        }
    }
}
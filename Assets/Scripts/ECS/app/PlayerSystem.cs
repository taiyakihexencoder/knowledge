using Unity.Collections;
using Unity.Entities;

namespace hexencoder.lab {
	[UpdateInGroup(typeof(ProjectSimulationSystemGroup))]
	public partial struct PlayerSystem : ISystem {
		private Entity playerEntity;

		void ISystem.OnCreate(ref SystemState state) {
			EntityManager entityManager = state.EntityManager;
			playerEntity = entityManager.CreateEntity(
				entityManager.CreateArchetype(
					ComponentType.ReadWrite<input.InputAxisStateComponent>(),
					ComponentType.ReadWrite<input.InputMainButtonStateComponent>(),
					ComponentType.ReadWrite<input.InputSideButtonStateComponent>(),
					ComponentType.ReadWrite<input.InputOtherButtonStateComponent>(),
					ComponentType.ReadWrite<input.InputButtonDownEventBufferElement>(),
					ComponentType.ReadWrite<input.InputButtonUpEventBufferElement>()
				)
			);

			Entity updateInputListenerEntity = entityManager.CreateEntity(
				entityManager.CreateArchetype(
					ComponentType.ReadWrite<input.RequestUpdateInputListenerComponent>()
				)
			);
			entityManager.SetComponentData(
				updateInputListenerEntity, 
				new input.RequestUpdateInputListenerComponent{
					target = playerEntity,
					enabled = true,
				}
			);

#if UNITY_EDITOR
			entityManager.SetName(playerEntity, "Player Entity");
			entityManager.SetName(updateInputListenerEntity, "Update Input Listener Entity");
#endif
		}

		void ISystem.OnUpdate(ref SystemState state) {
		}

		void ISystem.OnDestroy(ref SystemState state) {
		}

		private EntityCommandBuffer CreateCommandBuffer(ref SystemState state) {
			return SystemAPI.GetSingleton<EndSimulationEntityCommandBufferSystem.Singleton>().CreateCommandBuffer(state.World.Unmanaged);
		}
	}
}

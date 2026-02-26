using Unity.Entities;
using Unity.Mathematics;

namespace hexencoder.lab.input {
	[UpdateInGroup(typeof(ProjectSimulationSystemGroup))]
	public partial struct UpdateInputStateSystem : ISystem {
		private static Input0 input;

		private ComponentLookup<InputMainButtonStateComponent> _mainButtonLookup;
		private ComponentLookup<InputSideButtonStateComponent> _sideButtonLookup;
		private ComponentLookup<InputOtherButtonStateComponent> _otherButtonLookup;
		private ComponentLookup<InputAxisStateComponent> _axisLookup;

		private BufferLookup<InputButtonDownEventBufferElement> _buttonDownLookup;
		private BufferLookup<InputButtonUpEventBufferElement> _buttonUpLookup;

		void ISystem.OnCreate(ref SystemState state) {
			_mainButtonLookup = state.GetComponentLookup<InputMainButtonStateComponent>();
			_sideButtonLookup = state.GetComponentLookup<InputSideButtonStateComponent>();
			_otherButtonLookup = state.GetComponentLookup<InputOtherButtonStateComponent>();
			_axisLookup = state.GetComponentLookup<InputAxisStateComponent>();

			_buttonDownLookup = state.GetBufferLookup<InputButtonDownEventBufferElement>();
			_buttonUpLookup = state.GetBufferLookup<InputButtonUpEventBufferElement>();

			input = new Input0();
			input.Enable();
		}

		void ISystem.OnUpdate(ref SystemState state) {
			_mainButtonLookup.Update(ref state);
			_sideButtonLookup.Update(ref state);
			_otherButtonLookup.Update(ref state);
			_axisLookup.Update(ref state);

			_buttonDownLookup.Update(ref state);
			_buttonUpLookup.Update(ref state);

			EntityCommandBuffer commandBuffer = CreateCommandBuffer(ref state);
			if (SystemAPI.TryGetSingletonBuffer(out DynamicBuffer<InputListenerBufferElement> listeners)) {
				Entity listenerEntity;
				for(int i = listeners.Length-1; i >= 0; --i) {
					listenerEntity = listeners[i].target;
					if (state.EntityManager.Exists(listenerEntity)) {
						if (listeners[i].enabled) {
							if (_mainButtonLookup.HasComponent(listenerEntity)) {
								_mainButtonLookup[listenerEntity] = new InputMainButtonStateComponent {
									button0 = input.player.button0.IsPressed(),
									button1 = input.player.button1.IsPressed(),
									button2 = input.player.button2.IsPressed(),
									button3 = input.player.button3.IsPressed(),
								};
							}

							if (_sideButtonLookup.HasComponent(listenerEntity)) {
								_sideButtonLookup[listenerEntity] = new InputSideButtonStateComponent {
									buttonBumperL = input.player.shoulderl.IsPressed(),
									buttonBumperR = input.player.shoulderr.IsPressed(),
									buttonTriggerL = input.player.triggerl.IsPressed(),
									buttonTriggerR = input.player.triggerr.IsPressed(),
									buttonStickL = input.player.stickl.IsPressed(),
									buttonStickR = input.player.stickr.IsPressed(),
								};
							}

							if (_otherButtonLookup.HasComponent(listenerEntity)) {
								_otherButtonLookup[listenerEntity] = new InputOtherButtonStateComponent {
									buttonStart = input.player.button4.IsPressed(),
									buttonSelect = input.player.button5.IsPressed(),
								};
							}

							if (_axisLookup.HasComponent(listenerEntity)) {
								_axisLookup[listenerEntity] = new InputAxisStateComponent {
									axis0 = input.player.axis0.ReadValue<UnityEngine.Vector2>(),
									axis1 = input.player.axis1.ReadValue<UnityEngine.Vector2>(),
								};
							}

							if (_buttonDownLookup.HasBuffer(listenerEntity)) {
								DynamicBuffer<InputButtonDownEventBufferElement> downButtonBuffer = commandBuffer.SetBuffer<InputButtonDownEventBufferElement>(listenerEntity);
								if (input.player.button0.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.Button0, }); }
								if (input.player.button1.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.Button1, }); }
								if (input.player.button2.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.Button2, }); }
								if (input.player.button3.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.Button3, }); }
								if (input.player.button4.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.Start, }); }
								if (input.player.button5.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.Select, }); }
								if (input.player.shoulderl.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.BumperL, }); }
								if (input.player.shoulderr.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.BumperR, }); }
								if (input.player.triggerl.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.TriggerL, }); }
								if (input.player.triggerr.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.TriggerR, }); }
								if (input.player.stickl.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.StickL, }); }
								if (input.player.stickr.WasPressedThisFrame()) { downButtonBuffer.Add(new InputButtonDownEventBufferElement { button = InputButton.StickR, }); }
							}

							if (_buttonUpLookup.HasBuffer(listenerEntity)) {
								DynamicBuffer<InputButtonUpEventBufferElement> upButtonBuffer = commandBuffer.SetBuffer<InputButtonUpEventBufferElement>(listenerEntity);
								if (input.player.button0.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.Button0, }); }
								if (input.player.button1.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.Button1, }); }
								if (input.player.button2.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.Button2, }); }
								if (input.player.button3.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.Button3, }); }
								if (input.player.button4.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.Start, }); }
								if (input.player.button5.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.Select, }); }
								if (input.player.shoulderl.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.BumperL, }); }
								if (input.player.shoulderr.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.BumperR, }); }
								if (input.player.triggerl.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.TriggerL, }); }
								if (input.player.triggerr.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.TriggerR, }); }
								if (input.player.stickl.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.StickL, }); }
								if (input.player.stickr.WasReleasedThisFrame()) { upButtonBuffer.Add(new InputButtonUpEventBufferElement { button = InputButton.StickR, }); }
							}
						} else {
							if (_mainButtonLookup.HasComponent(listenerEntity)) {
								_mainButtonLookup[listenerEntity] = new InputMainButtonStateComponent {
									button0 = false,
									button1 = false,
									button2 = false,
									button3 = false,
								};
							}

							if (_sideButtonLookup.HasComponent(listenerEntity)) {
								_sideButtonLookup[listenerEntity] = new InputSideButtonStateComponent {
									buttonBumperL = false,
									buttonBumperR = false,
									buttonTriggerL = false,
									buttonTriggerR = false,
									buttonStickL = false,
									buttonStickR = false,
								};
							}

							if (_otherButtonLookup.HasComponent(listenerEntity)) {
								_otherButtonLookup[listenerEntity] = new InputOtherButtonStateComponent {
									buttonStart = false,
									buttonSelect = false,
								};
							}

							if (_axisLookup.HasComponent(listenerEntity)) {
								_axisLookup[listenerEntity] = new InputAxisStateComponent {
									axis0 = float2.zero,
									axis1 = float2.zero,
								};
							}
						}
					} else {
						listeners.RemoveAt(i);
					}
				}
			}
		}
	
		void ISystem.OnDestroy(ref SystemState state) {
		}

		private EntityCommandBuffer CreateCommandBuffer(ref SystemState state) {
			return SystemAPI.GetSingleton<EndSimulationEntityCommandBufferSystem.Singleton>().CreateCommandBuffer(state.World.Unmanaged);
		}
	}
}

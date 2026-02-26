using Unity.Entities;

namespace hexencoder.lab {
	[UpdateInGroup(typeof(SimulationSystemGroup))]
	public partial class ProjectSimulationSystemGroup : ComponentSystemGroup {}
}
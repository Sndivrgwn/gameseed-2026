extends Node

func get_target(
	caster: BaseCharacter,
	target_type: CombatTypes.TargetType
) -> BaseCharacter:

	match target_type:

		CombatTypes.TargetType.SELF:
			return caster

		CombatTypes.TargetType.NEAREST_ENEMY:
			return CombatQuery.get_nearest_enemy(caster)

	return null

extends Node

func cast(
	caster: BaseCharacter,
	target,
	skill: SkillData
):

	match skill.delivery_type:

		CombatTypes.DeliveryType.PROJECTILE:
			ProjectileDelivery.cast(
				caster,
				target,
				skill
			)

		CombatTypes.DeliveryType.INSTANT:
			InstantDelivery.cast(
				caster,
				target,
				skill
			)

		CombatTypes.DeliveryType.AREA:
			AreaDelivery.cast(
				caster,
				target,
				skill
			)
		CombatTypes.DeliveryType.BEAM:
			BeamDelivery.cast(caster,target,skill)
		CombatTypes.DeliveryType.MELEE:
			MeleeDelivery.cast(
			caster,
			target,
			skill
			)

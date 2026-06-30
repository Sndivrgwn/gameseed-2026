extends Node

func get_nearest_enemy(caster: BaseCharacter) -> BaseCharacter:

	var nearest: BaseCharacter = null
	var nearest_distance := INF

	for character in get_tree().get_nodes_in_group("character"):

		if !is_instance_valid(character):
			continue

		if character.is_dead:
			continue

		if character == caster:
			continue

		if character.team == caster.team:
			continue

		var distance := caster.global_position.distance_to(
			character.global_position
		)

		if distance < nearest_distance:
			nearest_distance = distance
			nearest = character

	return nearest


func get_enemies(
	caster: BaseCharacter
) -> Array[BaseCharacter]:

	var result : Array[BaseCharacter]

	for character in get_tree().get_nodes_in_group("character"):

		if !is_instance_valid(character):
			continue

		if character.is_dead:
			continue

		if character.team == caster.team:
			continue

		result.append(character)

	return result


func get_enemies_in_radius(
	caster: BaseCharacter,
	position: Vector2,
	radius: float
) -> Array[BaseCharacter]:

	var result : Array[BaseCharacter]

	for character in get_tree().get_nodes_in_group("character"):

		if !is_instance_valid(character):
			continue

		if character.is_dead:
			continue

		if character.team == caster.team:
			continue

		if character.global_position.distance_to(position) <= radius:
			result.append(character)

	return result

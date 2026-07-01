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

func get_enemies_in_front(
	caster: BaseCharacter,
	distance: float,
	width: float
) -> Array[BaseCharacter]:

	var result : Array[BaseCharacter]

	var facing = caster.get_facing_direction()

	for character in get_tree().get_nodes_in_group("character"):

		if !is_instance_valid(character):
			continue

		if character.is_dead:
			continue

		if character.team == caster.team:
			continue

		var offset = character.global_position - caster.global_position

		# cek depan belakang
		if facing == 1:
			if offset.x < 0:
				continue
		else:
			if offset.x > 0:
				continue

		# cek panjang
		if abs(offset.x) > distance:
			continue

		# cek lebar
		if abs(offset.y) > width * 0.5:
			continue

		result.append(character)

	return result

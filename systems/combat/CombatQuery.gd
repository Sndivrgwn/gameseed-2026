extends Node

func get_nearest_enemy(caster: BaseCharacter) -> BaseCharacter:

	var enemies = caster.get_tree().get_nodes_in_group("enemy")

	var nearest: BaseCharacter = null
	var nearest_distance := INF

	for enemy in enemies:

		if !is_instance_valid(enemy):
			continue

		if enemy.is_dead:
			continue

		var distance = caster.global_position.distance_to(enemy.global_position)

		if distance < nearest_distance:

			nearest_distance = distance
			nearest = enemy

	return nearest

func get_enemies(
	caster: BaseCharacter
) -> Array[BaseCharacter]:

	var result : Array[BaseCharacter]

	for enemy in caster.get_tree().get_nodes_in_group("enemy"):

		if !is_instance_valid(enemy):
			continue

		if enemy.is_dead:
			continue

		result.append(enemy)

	return result

func get_enemies_in_radius(
	position: Vector2,
	radius: float
) -> Array[BaseCharacter]:

	var result : Array[BaseCharacter]

	for enemy in get_tree().get_nodes_in_group("enemy"):

		if !is_instance_valid(enemy):
			continue

		if enemy.is_dead:
			continue

		var distance = enemy.global_position.distance_to(position)

		print(enemy.name, " distance = ", distance)

		if distance <= radius:
			result.append(enemy)

	print("Radius :", radius)
	print("Enemy dalam radius :", result.size())

	return result

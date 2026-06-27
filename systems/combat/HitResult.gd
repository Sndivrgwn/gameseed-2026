extends Node

class_name HitResult

enum ResultType {
	HIT,
	CRITICAL,
	MISS,
	BLOCK,
	IMMUNE
}

var result_type := ResultType.HIT
var damage_data : DamageData

func is_hit():
	return result_type == ResultType.HIT

func is_critical():
	return result_type == ResultType.CRITICAL

func is_miss():
	return result_type == ResultType.MISS

func is_block():
	return result_type == ResultType.BLOCK

func is_immune():
	return result_type == ResultType.IMMUNE

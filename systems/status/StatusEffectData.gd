extends Resource
class_name StatusEffectData

@export var display_name := ""
@export_multiline
var description := ""
@export var duration := 5.0
@export var tick_rate := 1.0
@export var max_stacks := 1
@export var icon : Texture2D
@export var effect_script : Script
@export_group("Flags")
@export var is_negative := false

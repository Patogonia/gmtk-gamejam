extends Node2D

signal alavanca_pressionada

var ligado: bool = false
var pode_pressionar: bool = false

export var porta_path: NodePath

onready var porta: Node2D = get_node(porta_path)


func _process(delta) -> void:
	if (Input.is_action_just_pressed("interacao") and pode_pressionar and not ligado):
		ligado = true
		emit_signal("alavanca_pressionada")


func _on_Area2D_body_entered(body):
	pode_pressionar = true


func _on_Area2D_body_exited(body):
	pode_pressionar = false

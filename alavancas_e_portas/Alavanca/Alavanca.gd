extends Node2D

signal alavanca_pressionada

var ligado: bool = false
var pode_pressionar: bool = false

export var porta_path: NodePath

onready var porta: Node2D = get_node(porta_path)


func _ready():
	connect("alavanca_pressionada",porta,"abrir")


func _process(delta) -> void:
	if (Input.is_action_just_pressed("interacao") and pode_pressionar and not ligado):
		ligado = true
		$AnimatedSprite.play("On")
		emit_signal("alavanca_pressionada")
		$Seta.look_at(porta.position)
		$Seta.modulate = Color("#00ffffff")
		$Seta.visible = true
		$Seta/Tween.interpolate_property($Seta,"modulate",$Seta.modulate,Color("#ffffffff"),0.7,Tween.TRANS_LINEAR)
		$Seta/Tween.start()


func _on_Area2D_body_entered(body):
	pode_pressionar = true


func _on_Area2D_body_exited(body):
	pode_pressionar = false

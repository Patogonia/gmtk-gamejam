extends Area2D

export var sprite_frames: SpriteFrames
export var aliado: PackedScene

var resgatado := false setget set_resgatado


func _ready():
	$AnimatedSprite.frames = sprite_frames
	$AnimatedSprite.play("default")


func _on_Area2D_body_entered(body):
	if resgatado: return

	var aliado_instancia: Jogador = aliado.instance()
	aliado_instancia.position = position
	get_parent().add_child(aliado_instancia)
	self.resgatado = true


func set_resgatado(valor: bool) -> void:
	resgatado = valor
	$AnimatedSprite.visible = not valor

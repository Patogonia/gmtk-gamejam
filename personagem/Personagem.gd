class_name Personagem
extends KinematicBody2D

onready var sprite_animado: AnimatedSprite = $AnimatedSprite
export var vel_maximo := 0.0
export var rapidez := 0.0
export var gravidade := -980.0
export var forca_pulo := 0
export var projetil: PackedScene
var dir := Vector2.ZERO
var _velocidade := Vector2.ZERO



func ready():
	pass


func _physics_process(delta: float) -> void:
	mover_personagem(delta)
	reproduzir_animacoes()


func mover_personagem(delta: float) -> void:
	var dir_hor_desejado := dir * Vector2(1,0) * vel_maximo
	var vel_horizontal := _velocidade * Vector2(1, 0)
	var vel_vertical := _velocidade * Vector2(0, 1)
	vel_horizontal = vel_horizontal.linear_interpolate(dir_hor_desejado, rapidez*delta)

	vel_vertical.y -= gravidade * delta
	if is_on_floor():
		vel_vertical.y = 1

		if dir.y > 0:
			vel_vertical.y -= forca_pulo

	_velocidade = move_and_slide(vel_horizontal + vel_vertical, Vector2.UP, false, 4, 0.785398, false)


func reproduzir_animacoes() -> void:
	var dir_horizontal := dir.x

	if is_on_floor():
		sprite_animado.play("Andando" if dir_horizontal != 0 else "Parado")
	else:
		sprite_animado.play("Caindo")

	if sprite_animado.flip_h == false and dir_horizontal < 0:
		sprite_animado.flip_h = true
	elif sprite_animado.flip_h == true and dir_horizontal > 0:
		sprite_animado.flip_h = false


func atirar(direcao: Vector2, player: bool = false) -> void:
	if projetil != null:
		var proj := projetil.instance()
		get_parent().add_child(proj)
		proj.iniciar(direcao, position, player, true)

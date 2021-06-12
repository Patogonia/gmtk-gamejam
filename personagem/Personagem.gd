extends KinematicBody2D

export var vel_maximo := 0.0
export var rapidez := 0.0
export var gravidade := -980.0
export var forca_pulo := 0
var dir := Vector2.ZERO
var _velocidade := Vector2.ZERO



func ready():
	pass


func _physics_process(delta: float) -> void:
	mover_personagem(delta)


func mover_personagem(delta: float) -> void:
	var dir_hor_desejado = dir * Vector2(1,0) * vel_maximo
	var vel_horizontal = _velocidade * Vector2(1, 0)
	var vel_vertical = _velocidade * Vector2(0, 1)
	vel_horizontal = vel_horizontal.linear_interpolate(dir_hor_desejado, rapidez*delta)

	vel_vertical.y -= gravidade * delta
	if is_on_floor():
		vel_vertical.y = 1

		if dir.y > 0:
			vel_vertical.y -= forca_pulo

	_velocidade = move_and_slide(vel_horizontal + vel_vertical, Vector2.UP)

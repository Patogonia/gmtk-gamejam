extends KinematicBody2D

var velocidade: float = 100
var direcao: Vector2
var dano: int = 1
var atirado_player: bool = false


func iniciar(proj_direcao, proj_posicao, player):
	self.look_at(proj_direcao)
	self.position = proj_posicao
	atirado_player = player
	if (atirado_player):
		self.set_collision_layer_bit(6, true)
		self.set_collision_mask_bit(2, true)


func _physics_process(delta) -> void:
	direcao *= transform.x
	direcao *= velocidade
	
	var colisor = move_and_collide(direcao*delta)
	if (is_instance_valid(colisor)):
		_colidir(colisor)
	direcao = Vector2(1,1)


func _colidir(colidiu_com):
	if (colidiu_com.has_method("_dano")):
		colidiu_com._dano(dano)
	trata_colisao(colidiu_com)
	self.queue_free()


func _empurrao(alvo_empurrao: Vector2):
	look_at(alvo_empurrao)


func trata_colisao(colisor):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()

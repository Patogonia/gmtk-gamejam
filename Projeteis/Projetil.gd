extends KinematicBody2D

var velocidade: float = 100
var direcao: Vector2
var dano: int = 1
var atirado_player: bool = false setget _set_atirado_player


func iniciar(proj_direcao, proj_posicao, player = false, projetil = false):
	if (player):
		self.look_at(proj_direcao)
		self.position = proj_posicao + Vector2(0, -2 if player else 0)
	else:
		self.position = proj_posicao + Vector2(0, -2 if player else 0)
		self.look_at(proj_direcao)
	_set_atirado_player(player)
	if (not "EmpurraoArcano" in self.name):
		$CollisionShape2D.disabled = false
	if (not projetil):
		$AnimatedSprite.play("default")
	else:
		$AnimatedSprite.play("defaultAliado" if player else "defaultFeiticeiro")


func _set_atirado_player(new_state):
	atirado_player = new_state
	self.set_collision_layer_bit(2, atirado_player)
	self.set_collision_mask_bit(1, atirado_player)
	self.set_collision_mask_bit(0, not atirado_player)
	$CollisionShape2D.disabled = false
	$AnimatedSprite.play("default")


func _physics_process(delta) -> void:
	direcao *= transform.x
	direcao *= velocidade

	var colisor = move_and_collide(direcao*delta, false)
	if (is_instance_valid(colisor)):
		_colidir(colisor.collider)
	direcao = Vector2(1,1)


func _colidir(colidiu_com):
	if (colidiu_com.has_method("dano")):
		colidiu_com.dano(dano)
	trata_colisao(colidiu_com)
	self.queue_free()


func _empurrao(alvo_empurrao: Vector2):
	look_at(alvo_empurrao)
	_set_atirado_player(true)


func trata_colisao(colisor):
	pass


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()

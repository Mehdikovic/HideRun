extends Node

var player
var navigation : Navigation2D
var destinations : Node2D

const sfx_NIGHT_VISION_ON : String = "res://Assets/SFX/nightvision.wav"
const sfx_NIGHT_VISION_OFF : String = "res://Assets/SFX/nightvision_off.wav"

const GREEN_LIGHT : String = "res://Assets/GFX/Interface/PNG/dotGreen.png"
const RED_LIGHT : String = "res://Assets/GFX/Interface/PNG/dotRed.png"

const player_PLAYER_SPRITE : String = "res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const player_PLAYER_LIGHT : String = "res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const player_PLAYER_OCCLUDER : String = "res://Resources/Character/Player_Occluder.tres"
const player_PLAYER_COLLISION_SHAPE : String = "res://Resources/Character/Player_Collision_Shape.tres"

const player_BOX_SPRITE : String = "res://Assets/GFX/PNG/Tiles/tile_129.png"
const player_BOX_LIGHT : String = "res://Assets/GFX/PNG/Tiles/tile_129.png"
const player_BOX_OCCLUDER : String = "res://Resources/Character/Box_Occluder.tres"
const player_BOX_COLLISION_SHAPE : String = "res://Resources/Character/Box_Collision_Shape.tres"

const BOX_ITEM_ICON = preload("res://Assets/GFX/PNG/Tiles/tile_130.png")
const BRIEFCASE_ITEM_ICON = preload("res://Assets/GFX/Loot/suitcase.png")

const MESSAGE_FILE_JSON = "res://Resources/TutorialMessages.json"
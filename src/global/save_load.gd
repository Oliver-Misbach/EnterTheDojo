extends Node


# TODO: use Object serialization once a secure version is available: https://docs.godotengine.org/en/stable/classes/class_fileaccess.html#class-fileaccess-method-get-var
#       this would remove the boilerplate code from read/write functions

# TODO (optional): unencrypted config (.cfg), runtime type checking, versioning and patching


const PATH_BIN := "user://user.bin"


var _password: String = ProjectSettings.get_setting("config/password")
var _enc := ConfigFile.new()


func load_enc() -> Dictionary:
	var err := _enc.load_encrypted_pass(PATH_BIN, _password)
	if err != ERR_FILE_NOT_FOUND:
		Global.ok(err, "config: load enc")
	
	var value: Dictionary = _enc.get_value(&"", &"data", {})
	return value


func save_enc(dict: Dictionary) -> void:
	_enc.set_value(&"", &"data", dict)
	
	var err := _enc.save_encrypted_pass(PATH_BIN, _password)
	Global.ok(err, "config: save enc")

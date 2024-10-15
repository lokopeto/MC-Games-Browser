extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._github_releases)

	var error = http_request.request("https://github.com/minekube/gate/releases/latest")
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _github_releases(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	

	print(result, response_code, json.get_parsed_text())

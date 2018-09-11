#include <../HTTP.au3>

$_HTTP_ScriptDir = @ScriptDir&"\html"

_HTTP_SetConnection("127.0.0.1", 8080)
_HTTP_ServerStart()
While True
	_HTTP_MainUserLoop()
	_HTTP_MainLoop()
	Sleep(1)
WEnd
#include-once
#include "../IP.au3"
#include <String.au3>
#include <Array.au3>

#Region Global variable
Global $_HTTP_Socket = Null
Global $_HTTP_IP, $_HTTP_Port
Global $_HTTP_MaxClient = 150, $_HTTP_CountClient = 0
Global $_HTTP_MaxLen = 65400
Global $_HTTP_Client[$_HTTP_MaxClient][2]
#EndRegion Global variable

#cs Function List
	_HTTP_ServerStart - Uruchamianie serwera HTTP
	_HTTP_SetConnection - Zmiana adresu IP oraz Portu dla serwera
	_HTTP_MainLoop - Główna pętla wykonująca polecenia

	__HTTP_SendDataMain - Główna funkcja wysyłająca informacje do klienta
#ce Function List

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_SetConnect
; Description ...: Zmiana adresu IP oraz Portu dla serwera
; Syntax ........: _HTTP_SetConnect()
; Parameters ....:
; Return values .: bool
; @error ........: 1 - Błędny adres IP
;				   2 - Błędy port
; ===============================================================================================================================
Func _HTTP_SetConnection($ip, $port = 80)
	If $ip == "localhost" Then $ip = "127.0.0.1"
	If _IP_check($ip) == False Then Return SetError(1)
	If $port < 0 Or $port > 65535 Then Return SetError(2)
	$_HTTP_IP = $ip
	$_HTTP_Port = $port
EndFunc   ;==>_HTTP_SetConnection

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_ServerStart
; Description ...: Uruchamianie serwera HTTP
; Syntax ........: _HTTP_ServerStart()
; Parameters ....:
; Return values .: bool
; @error ........: 1 - Błąd uruchamiania serwera TCP
;				   2 - Błędny adres IP
;				   3 - Błędy port
; ===============================================================================================================================
Func _HTTP_ServerStart()
	If $_HTTP_Socket <> Null Then Return False
	TCPStartup()
	If @error Then Return SetError(1)
	$_HTTP_Socket = TCPListen($_HTTP_IP, $_HTTP_Port)
	If Not @error Then
		Return True
	Else
		Switch @error
			Case 1
				Return SetError(2)
			Case 2
				Return SetError(3)
		EndSwitch
	EndIf
EndFunc   ;==>_HTTP_ServerStart

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_MainLoop
; Description ...: Główna pętla wykonująca polecenia
; Syntax ........: _HTTP_MainLoop()
; Parameters ....:
; Return values .:
; @error ........:
; ===============================================================================================================================
Func _HTTP_MainLoop()
	For $x = 0 To $_HTTP_MaxClient - 1
		If $_HTTP_Client[$x][0] == Null Then Return
		If $_HTTP_Client[$x][0] < 0 Then Return
		Local $bufor = TCPRecv($_HTTP_Client[$x][0], $_HTTP_MaxLen)
		If @error Then
			$_HTTP_Client[$x][0] = Null
			$_HTTP_CountClient -= 1
		Else
			__HTTP_SendDataMain($_HTTP_Client[$x][0], $bufor)
		EndIf
	Next
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _HTTP_MainUserLoop
; Description ...: Główna funkcja oczekująca na użytkowników
; Syntax ........: _HTTP_MainUserLoop()
; Parameters ....:
; Return values .: <bool> / <int> 503
; @error ........:
; ===============================================================================================================================
Func _HTTP_MainUserLoop()
	Local $Sock = TCPAccept($_HTTP_Socket)
	If $Sock >= 0 Then
		If $_HTTP_CountClient < $_HTTP_MaxClient Then
			For $x = 0 To $_HTTP_MaxClient - 1 Step 1
				If $_HTTP_Client[$x][0] = Null Then
					$_HTTP_Client[$x][0] = $Sock
					$_HTTP_CountClient += 1
					Return True
					ExitLoop
				EndIf
			Next
		Else
			;send error 503
			Return 503
		EndIf
	EndIf
EndFunc   ;==>_HTTP_NewUser

#cs
GET / HTTP/1.1
Host: 127.0.0.1:8080
Connection: keep-alive
Cache-Control: max-age=0
Upgrade-Insecure-Requests: 1
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.183 Safari/537.36 Vivaldi/1.96.1147.55
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8
Accept-Encoding: gzip, deflate, br
Accept-Language: pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7
#ce

; #FUNCTION# ====================================================================================================================
; Name ..........: __HTTP_SendDataMain
; Description ...: Główna funkcja wysyłająca informacje do klienta
; Syntax ........: __HTTP_SendDataMain($socket, $data)
; Parameters ....: $socket - socket TCP
;				   $data - dane HTTP
; Return values .:
; @error ........:
; ===============================================================================================================================
Func __HTTP_SendDataMain($socket, $data)
	If $data == "" Then Return False
	Local $temp = _StringExplode($data, @CRLF)
	Local $header[1][2]
	$header[0][1] = $temp[0]
	For $x=0 To UBound($temp)-1
		$exp = _StringExplode($temp[$x], ": ", 2)
		If UBound($exp) >= 2 Then
			Local $add_id = _ArrayAdd($header, "")
			$header[$add_id][0] = $exp[0]
			$header[$add_id][1] = $exp[1]
		EndIf
	Next
	Local $method = _StringExplode($temp[0][1], " ")[0]
	If $method <> "POST" Or $method <> "GET" Then Return
	Local $link = _StringExplode($temp[0][1], " ")[1]
	;Continue
EndFunc

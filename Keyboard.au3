#include-once
#include <Misc.au3>

#cs Function List
	_Keyboard_ReturnPressKey - Zwraca naciśnięty przycisk
#ce Function List

MsgBox(0, "", _Keyboard_ReturnPressKey())

; #INDEX# =======================================================================================================================
; Title .........: Zwraca naciśnięty przycisk
; Description ...: Zwraca aktualny naciśnięty przycisk
; Author(s) .....: Krzysztof Żyłka
; DLL's .........: user32
; ===============================================================================================================================
Func _Keyboard_ReturnPressKey()
	Dim $key_list[][2] = [[8, "BACKSPACE"], [9, "TAB"], ["0C", "CLEAR"], ["0D", "ENTER"], [10, "SHIFT"], [11, "CTRL"], [13, "PAUSE"], [14, "CAPS_LOCK"], _ ;8
		["1B", "ESC"], [20, "SPACEBAR"], [21, "PAGE_UP"], [22, "PAGE_DOWN"], [23, "END"], [24, "HOME"], [25, "LEFT_ARROW"], [26, "UP_ARROW"], [27, "RIGHT_ARROW"], _ ;9
		[28, "DOWN_ARROW"], [29, "SELECT"], ["2A", "PRINT"], ["2B", "EXECUTE"], ["2C", "PRINT_SCREEN"], ["2D", "INS"], ["2E", "DEL"], [30, "0"], [31, "1"], [32, "2"], _ ;10
		[33, "3"], [34, "4"], [35, "5"], [36, "6"], [37, "7"], [38, "8"], [39, "9"], [41, "A"], [42, "B"], [43, "C"], [44, "D"], [45, "E"], [46, "F"], [47, "G"], [48, "H"], _ ;15
		[49, "I"], ["4A", "J"], ["4B", "K"], ["4C", "L"], ["4D", "M"], ["4E", "N"], ["4F", "O"], [50, "P"], [51, "Q"], [52, "R"], [53, "S"], [54, "T"], [55, "U"], [56, "V"], _ ;14
		[57, "W"], [58, "X"], [59, "Y"], ["5A", "Z"], ["5B", "LEFT_WINDOWS_KEY"], ["5C", "RIGHT_WINDOWS_KEY"], [60, "NUM_0"], [61, "NUM_1"], [62, "NUM_2"], [63, "NUM_3"], _ ;10
		[64, "NUM_4"], [65, "NUM_5"], [66, "NUM_6"], [67, "NUM_7"], [68, "NUM_8"], [69, "NUM_9"], ["6A", "MULTIPLY"], ["6B", "ADD"], ["6C", "SEPARATOR"], ["6D", "SUBTRACT"], _ ;10
		["6E", "DECIMAL"], ["6F", "DEVIDE"], [70, "F1"], [71, "F2"], [72, "F3"], [73, "F4"], [74, "F5"], [75, "F6"], [76, "F7"], [77, "F8"], [78, "F9"], [79, "F10"], _ ;12
		["7A", "F11"], ["7B", "F12"], ["7C", "F13"], ["7D", "F14"], ["7E", "F15"], ["7F", "F16"], ["80H", "F17"], ["81H", "F18"], ["82H", "F19"], ["83H", "F20"], _ ;10
		["84H", "F21"], ["85H", "F22"], ["86H", "F23"], ["87H", "F24"], [90, "NUM_LOCK"], [91, "SCROLL_LOCK"], ["A0", "LEFT_SHIFT"], ["A1", "RIGHT_SHIFT"], ["A2", "LEFT_CONTROL"], _ ;9
		["A3", "RIGHT_CONTROL"], ["A4", "LEFT_MENU"], ["A5", "RIGHT_MENU"], ["BA", ";"], ["BB", "="], ["BC", ","], ["BD", "-"], ["BE", "."], ["BF", "/"], ["C0", "`"], ["DB", "["], _ ;11
		["DC", "\"], ["DD", "]"]]
	For $x = 0 To UBound($key_list) - 1 Step 1
		If Not _IsPressed($key_list[$x][0], DllOpen("user32.dll")) Then
			$key = $key_list[$x][1]
			Return $key
		EndIf
	Next
	Return "NaN"
EndFunc
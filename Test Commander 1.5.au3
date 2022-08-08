#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <TrayConstants.au3>
#include <Misc.au3>
#include <IE.au3>
#include '_Startup.au3'
#include 'IE_EmbeddedVersioning.au3'

#pragma compile(FileDescription, TEST Commander - One click access to Spectrum and TEST via Desktop)
#pragma compile(ProductName, TEST Commander)
#pragma compile(ProductVersion, 1.5)
#pragma compile(FileVersion, 1.5)
#pragma compile(LegalCopyright, Written by Harkonan aKa harkypoo)

$Skin_Folder = "C:\Users\Jon\Google Drive\Test Commander\TEST"

$ver = _IE_EmbeddedGetVersion()
_IE_EmbeddedSetBrowserEmulation($ver)

If _Singleton("TEST Commander", 1) = 0 Then
	MsgBox($MB_APPLMODAL, "Whoops!", "TEST Commander is already running.")
	Exit
EndIf

Opt("GUIOnEventMode", 1)
Opt("GUIEventOptions", 0)
Opt("TrayMenuMode", 3)
Opt("TrayOnEventMode", 1)

$StopIdling = 0


GUIRegisterMsg($WM_COMMAND, "_WM_COMMAND")

TrayCreateItem("My Hangar")
TrayItemSetOnEvent(-1, "CreateHangar")
TrayCreateItem("Star Citizen Apps")
TrayItemSetOnEvent(-1, "CreateTexas")

TrayCreateItem("")

$SC = TrayCreateMenu("Star Citizen")
TrayCreateItem("Ship Yard", $SC)
TrayItemSetOnEvent(-1, "CreateShip")
TrayCreateItem("Road Map", $SC)
TrayItemSetOnEvent(-1, "CreateRM")
TrayCreateItem("Star Map", $SC)
TrayItemSetOnEvent(-1, "CreateMap")
TrayCreateItem("", $SC)
TrayCreateItem("Spectrum", $SC)
TrayItemSetOnEvent(-1, "CreateSpectrum")
TrayCreateItem("RSI Comms", $SC)
TrayItemSetOnEvent(-1, "CreateTweet")
$Test = TrayCreateMenu("TEST HQ")
TrayCreateItem("Forums", $Test)
TrayItemSetOnEvent(-1, "CreateForum")
TrayCreateItem("Gaming", $Test)
TrayItemSetOnEvent(-1, "CreateGaming")
TrayCreateItem("Discord", $Test)
TrayItemSetOnEvent(-1, "CreateDiscord")

TrayCreateItem("")
$idStart = TrayCreateItem("Start on Boot")
	If _StartupFolder_Exists() = 1 Then
		TrayItemSetState(-1, $TRAY_CHECKED)
	Else
		TrayItemSetState(-1, $TRAY_UNCHECKED)
	EndIf
TrayItemSetOnEvent(-1, "Startup")

TrayCreateItem("")

TrayCreateItem("Exit")
TrayItemSetOnEvent(-1, "Terminate")

TraySetState($TRAY_ICONSTATE_SHOW)
TraySetToolTip("TEST Commander")

While 1
		Sleep(100)
WEnd

;CreateForum()
;ShowGUIFunction()

Func CreateHangar()

If WinExists("My Hangar","") Then
	WinActivate("My Hangar")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("My Hangar", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)
$ForumHandle = WinGetHandle ("My Hangar")
GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE,"https://robertsspaceindustries.com/account/pledges")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")

;GUISetState()
EndIf
EndFunc

Func CreateTexas()

If WinExists("Star Citizen Apps","") Then
	WinActivate("Star Citizen Apps")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("Star Citizen Apps", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)
$ForumHandle = WinGetHandle ("My Hangar")
GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE,"https://starcitizen.danielaburke.com/")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")

;GUISetState()
EndIf
EndFunc

Func CreateForum()

If WinExists("TEST Forums","") Then
	WinActivate("TEST Forums")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("TEST Forums", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)
$ForumHandle = WinGetHandle ("TEST Forums")
GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "https://testsquadron.com/forums/")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")

;GUISetState()
EndIf
EndFunc

Func CreateDiscord()

If WinExists("TEST Discord Channel","") Then
	WinActivate("TEST Discord Channel")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("TEST Discord Channel", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)

GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "https://discordapp.com/channels/75630661951557632/75630661951557632")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")
;GUISetState()
EndIf
EndFunc

Func CreateGaming()

If WinExists("TEST Gaming","") Then
	WinActivate("TEST Gaming")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("TEST Gaming", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)

GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "https://test.gg/")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")
;GUISetState()
EndIf
EndFunc


Func CreateMap()

If WinExists("https://robertsspaceindustries.com","") Then
	WinActivate("https://robertsspaceindustries.com")
Else
Dim $smIE = _IECreate('about:blank', 0, 0, 0)

With $smIE
    .Width = @DesktopWidth
    .Height = @DesktopHeight
    .Left = @DesktopWidth
    .Top = @DesktopHeight
    .Menubar = True
    .Resizable = False
    .StatusBar = False
    .TheaterMode = False
    .Toolbar = False
    .Visible = True
    .AddressBar = False
EndWith
_IENavigate($smIE, 'https://robertsspaceindustries.com/starmap', 0)
EndIf
EndFunc

Func CreateSpectrum()

If WinExists("Spectrum","") Then
	WinActivate("Spectrum")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("Spectrum", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)

GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "https://robertsspaceindustries.com/spectrum/community/SC")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")
;GUISetState()
EndIf
EndFunc

Func CreateShip()

If WinExists("Ship Yard","") Then
	WinActivate("Ship Yard")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("Ship Yard", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)

GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "https://robertsspaceindustries.com/pledge/ships")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")
;GUISetState()
EndIf
EndFunc

Func CreateRM()

If WinExists("Road Map","") Then
	WinActivate("Road Map")
Else
$oIE = _IECreateEmbedded()
$GUI = GUICreate("Road Map", @DesktopWidth -50, @DesktopHeight -50, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)

GUISetState(@SW_SHOW)
WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "https://robertsspaceindustries.com/roadmap/board/1-Star-Citizen")
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")
;GUISetState()
EndIf
EndFunc

Func CreateTweet()

If WinExists("Star Citizen On Twitter","") Then
	WinActivate("Star Citizen On Twitter")
Else
$ver = _IE_EmbeddedGetVersion()
_IE_EmbeddedSetBrowserEmulation($ver)

$oIE = _IECreateEmbedded()
$GUI = GUICreate("Star Citizen On Twitter", 1215, @DesktopHeight -200, -1, -1)
GUICtrlCreateObj($oIE, -1, -1, @DesktopWidth, @DesktopHeight)

GUISetState(@SW_SHOW)
;WinSetState($GUI, "", @SW_MAXIMIZE)
_IENavigate($oIE, "http://www.thewalkingeek.com/sc.html")
Local $oHtml = _IETagNameGetCollection($oIE, "HTML", 0)
GUISetOnEvent($GUI_EVENT_CLOSE, "CloseWin")
EndIf
EndFunc

;Func _WM_COMMAND($hWnd, $Msg, $wParam, $lParam)
;    If BitAND($wParam, 0x0000FFFF) = $RightButton Then $StopIdling = 1
;    If BitAND($wParam, 0x0000FFFF) = $WrongButton Then $StopIdling = 1
;    Return $GUI_RUNDEFMSG
;EndFunc

Func ShowGUIFunction()
    $StopIdling = 0
    GUISetState(@SW_SHOW)
    Do
        Sleep(100)
    Until $StopIdling = 1
EndFunc

Func Startup()
		If _StartupFolder_Exists() = 1 Then
			_StartupFolder_Uninstall()
			TrayItemSetState($idStart, $TRAY_UNCHECKED)

		Else
			_StartupFolder_Install()
			TrayItemSetState($idStart, $TRAY_CHECKED)
		EndIf
EndFunc

Func Terminate()
    Exit 0
EndFunc

Func CloseWin()
$tar = WinActive("[ACTIVE]")
	GUIDelete($tar)
EndFunc

# [Project 1] UX(Conceptual Design) Specification

Date Created: 07/11/25

Created by: Hungu Lim, Jisu Lim, Hyunsu Lim

Version: 1.0



[[UX Overview]	4](#uxoverview4)
[[UXID-000] Start Up Screen	5](#uxid000startupscreen5)
[[UXID-001] Home Screen	6](#uxid001homescreen6)
[About Button	6](#aboutbutton6)
[Game Center Button	6](#gamecenterbutton6)
[Help Button	6](#helpbutton6)
[Game Button	6](#gamebutton6)
[Solver Button	6](#solverbutton6)
[Ads	6](#ads6)
[Leaderboard Button	6](#leaderboardbutton6)
[Setting Button	6](#settingbutton6)
[[UXID-002] About Screen (FR-12)	7](#uxid002aboutscreenfr127)
[Back Button	7](#backbutton7)
[Version Info Text	7](#versioninfotext7)
[Dev Info Text	7](#devinfotext7)
[Easter Egg	7](#easteregg7)
[GNU License Info Text	7](#gnulicenseinfotext7)
[[UXID-003] Game Center (FR-13)	8](#uxid003gamecenterfr138)
[Back Button	8](#backbutton8)
[Screen	8](#screen8)
[[UXID-004] Help Screen (FR-10)	9](#uxid004helpscreenfr109)
[Back Button	9](#backbutton9)
[Next Button	9](#nextbutton9)
[Screen	9](#screen9)
[Home Button	9](#homebutton9)
[[UXID-005] Game Screen (TBD, v2.0)	10](#uxid005gamescreentbdv2010)
[Back Button	10](#backbutton10)
[“Single” Button	10](#singlebutton10)
[“Multi” Button	10](#multibutton10)
[[UXID-006] Level Screen (FR-1.2, FR-5)	11](#uxid006levelscreenfr12fr511)
[Back Button	11](#backbutton11)
[Easy Button	11](#easybutton11)
[Medium Button	11](#mediumbutton11)
[Hard Button	11](#hardbutton11)
[Resume Button	11](#resumebutton11)
[[UXID-007] Game Board Screen	12](#uxid007gameboardscreen12)
[Error Marking	12](#errormarking12)
[Score Marking	12](#scoremarking12)
[Timer	12](#timer12)
[Game Board	13](#gameboard13)
[Restart Button	13](#restartbutton13)
[Undo/Redo Button	13](#undoredobutton13)
[Hint Button	13](#hintbutton13)
[Memo(Pencil Mark) Button	13](#memopencilmarkbutton13)
[Number Pad	13](#numberpad13)
[Ads	13](#ads13)
[[UXID-008] Score Screen	14](#uxid008scorescreen14)
[Screen	14](#screen14)
[Home Button	14](#homebutton14)
[[UXID-009] Solver Screen	15](#uxid009solverscreen15)
[Back Button	15](#backbutton15)
[Manual Button	15](#manualbutton15)
[Camera Button	15](#camerabutton15)
[[UXID-010] Solution Screen (FR-17)	16](#uxid010solutionscreenfr1716)
[Sudoku Board	16](#sudokuboard16)
[“Solve It!” Button	16](#solveitbutton16)
[Home Button	16](#homebutton16)
[[UXID-011] Capture Screen	17](#uxid011capturescreen17)
[Back Button	17](#backbutton17)
[Screen	17](#screen17)
[Camera Button	17](#camerabutton17)
[[UXID-012] Leaderboard Screen	18](#uxid012leaderboardscreen18)
[Back Button	18](#backbutton18)
[Clear Button	18](#clearbutton18)
[Leaderboard	18](#leaderboard18)
[[UXID-013] Setting Screen	19](#uxid013settingscreen19)
[Back Button	19](#backbutton19)
[Screen	19](#screen19)
# 

# [UX Overview]

# 

# [UXID-000] Start Up Screen

# 

# [UXID-001] Home Screen

|  | About Button
Connects to UXID-002
SRS Specification: FR-12
Game Center Button
Connects to UXID-003
SRS Specification: FR-13
Help Button
Connects to UXID-004
SRS Specification: FR-10
Game Button
Connects to UXID-005
Solver Button
Connects to UXID-009
SRS Specification: FR-17
Ads
SRS Specification: FR-8
Leaderboard Button
Connects to UXID-012
SRS Specification: FR-13.2
Setting Button
Connects to UXID-013
SRS Specification: FR-9 |
|---|---|

# [UXID-002] About Screen (FR-12)

|  | Back Button 
Connects to UXID-001
Version Info Text
There will be information about version history
버젼 정보가 나온다.
Dev Info Text
There will be information about developers
개발자들의 정보가 나온다.
Easter Egg
There will be a separate page connecting to an easter egg when clicked
This will actually not be a button but disguised as a small logo on the bottom for example like a true “easter egg”
버튼을 누르면 이스터 에그의 페이지로 넘어간다 (버튼 숨길 예정)
GNU License Info Text
There will be GNU license information
GNU License에 관한 정보가 나온다.

 |
|---|---|


# [UXID-003] Game Center (FR-13)

|  | Back Button 
Connects to UXID-001
Screen
SRS Specification: FR-13.1
Will redirect to the Game Center(external connection)
게임센터로 연결된다(외부 연결)
 |
|---|---|


# [UXID-004] Help Screen (FR-10)

|  | Back Button 
Connects to UXID-001
Next Button
Takes user to the next page of tutorial
Screen
Multiple pages consisting of a step-by-step tutorial of the game
Home Button
Connects to UXID-001 |
|---|---|

# [UXID-005] Game Screen (TBD, v2.0)

|  | Back Button 
Connects to UXID-001
“Single” Button
Connects to UXID-006
SRS Specification: FR-1.2
“Multi” Button
To be determined in version 2.0 |
|---|---|

# [UXID-006] Level Screen (FR-1.2, FR-5)

|  | Back Button 
Connects to UXID-001
Easy Button
Connects to UXID-007
Produces a Sudoku board with 35~40 blank spaces
Medium Button
Connects to UXID-007
Produces a Sudoku board with 41~50 blank spaces
Hard Button
Connects to UXID-007
Produces a Sudoku board with 51+ blank spaces
Resume Button
Connects to UXID-007
SRS Specification: FR-5
Only exists when there is a game to be resumed
Reloads game |
|---|---|


# [UXID-007] Game Board Screen

|  | Error Marking
SRS Specification: FR-4.1
3 ‘X’ marks indicating how many errors user can make without penalties
After 3 errors, user will get time shaven off for each error made

4th error
-5 seconds
5th error
-10 seconds
6th error
-20 seconds
7+ errors
-30 seconds

Score Marking
SRS Specification: FR-15
Score Calculation
Method 1: Different time given per level

Easy
5 minutes
Medium
10 minutes
Hard
20 minutes
Downcount the time, leftover time when finished solving is the score.
If don’t solve it within time, score is zero.
 |
|---|---|

## Timer

- SRS Specification: [FR-6](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.c67vv2gbgx63)

- Referring to Method 1 of Score Calculation, time will be given correspondingly to level.

## Game Board

- SRS Specification: [FR-1.1](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.se66h25agf9)

- 9x9 Sudoku board

- Blanks will be corresponding to level selection from Level Screen

## Restart Button

- SRS Specification: [FR-7.2](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.hzaud4qe2s7n)

- Pressing the button will wipe out any user input and restart the timer.

- This must be dimmed at the start of the game and be available once the user has inputted their first input.

## Undo/Redo Button

- SRS Specification: [FR-7.1](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.hzaud4qe2s7n)

- Pressing the button will delete/re-insert the last input from the user.

- This must be dimmed at the start of the game and be available once the user has inputted their first input.

## Hint Button

- SRS Specification: [FR-4.2](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.65hq8g6gzwpr)

- Pressing the button will fill in a blank cell with its answer.

- This must be dimmed once the user has used up to their limit.

## Memo(Pencil Mark) Button

- SRS Specification: [FR-3](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.5zkqr8wlknnn)

- Pressing the button will turn the selected cell into memo mode.

## Number Pad

- SRS Specification: [FR-2](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.fbbuds6qlyda), [FR-4.1](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.65hq8g6gzwpr)

- Pressing the numbers will input the selected number into the selected cell/memo space.

- When player inputs number, cell must indicate right or wrong for the input

## Ads

- SRS Specification:[ FR-8](https://docs.google.com/document/d/1xX3HZR1scRv5GxhuiEIKgagxRFud7o2wgEuFuMolt6w/edit?tab=t.0#heading=h.pwq3ze6fy2p)


# [UXID-008] Score Screen

|  | Screen
Shows completed time, final score, and leaderboard if needed.
Home Button 
Connects to UXID-001
 |
|---|---|

# [UXID-009] Solver Screen

|  | Back Button 
Connects to UXID-001
Manual Button
Connects to UXID-010
SRS Specification: FR-17
Camera Button
Connects to UXID-011
 |
|---|---|

# [UXID-010] Solution Screen (FR-17)

|  | Sudoku Board
9x9 Sudoku Board 
Filled if used Capture Screen to retrieve board
Able to select cell and input numbers if clicked manual (Blank 9x9 Sudoku board)
“Solve It!” Button
When clicked, solutions will be filled in a different color.
Home Button 
Connects to UXID-001
 |
|---|---|

# [UXID-011] Capture Screen

|  | Back Button 
Connects to UXID-009
Screen
Camera background, with guidelines indicating how to line up the sudoku board
Camera Button
When clicked, will capture Sudoku Board and automatically move to UXID-010 with filled Sudoku Board
 |
|---|---|

# [UXID-012] Leaderboard Screen

|  | 
Back Button 
Connects to UXID-001
Clear Button
Clears the Leaderboard
Leaderboard
SRS Specification: FR-13.2
Contains the updated leaderboard connected to Game Center |
|---|---|


# [UXID-013] Setting Screen

|  | 
Back Button 
Connects to UXID-001
Screen
SRS Specification: FR-9, FR-16
There must be a list of buttons/effects that lets users customize their own experiences.
 |
|---|---|

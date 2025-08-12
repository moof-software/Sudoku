# [Project 1] UI(Detailed Design) Specification

Date Created: 07/11/25

Created by: Hungu Lim, Jisu Lim, Hyunsu Lim

Version: 1.0


## [UIID-000] Layout Design Overview

![Layout Design Overview Image](leB_Image_1.jpeg)

## [UUID-001] StartUpView detail

Connects to [UXID-000](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.oylzsxjp3t1d) 

File name: StartUpView.swift (StartUp.storyboard를 생성하여 “Launch Screen File” 에 등록한다. SwiftUI에서 다른 Launch screen 등록 방법이 있으면 대체 할 수 있다.)

Implements:

1. HomeView 최초 화면 표시 전에 StartUp view를 표시한다.

2. (임시) 3초후 StartUp화면을 Hide 한다.

## [UUID-002] GameHomeView detail

Connects to [UXID-001](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.cf1ohv9768b3) 

File name: GameHomeView.swift

Implements:

1. 6개의 버튼이 필요하다.
    - About - AboutView(Sheet type) 열기
    - Help - HelpView(Navigation Link type) 열기
    - Leader Board - LeaderBoardView(Sheet type) 열기
    - Setting - SettingView(Sheet type) 열기
    - Game- GameBoardView(Navigation Link type, 진입시 항상 LevelView ActionSheet type형 화면을 표시한다) 열기
    - Solver - SolverView(Navigation Link type) 열기

2. 1개의 Text가 필요하다.
    - “Ads”의 Placeholder가 될것이다.

![GameHomeView Image Specified](ejq_Image_3.jpeg)

*(Fig. 1) GameHome Conceptual Design*

![GameHomeView Image Specification 1.1](1.1_GameHomeView)

*(Fig. 1.1) GameHome Storyboard UI Design*

### [Fig 1.1] Storyboard Design Description

Button Types: IconButton, NameButton, located in Components folder

**IconButton:** 
- Label: Image
    - Modifiers:
        - resizeable
        - frame (width 30, height 30)
- button padding default (16)

**NameButton:**
- Label:
    - VStack
        - Image 
        - Text
            - Semibold
    - Modifiers:
        - frame (width 200, height 80)
- background
    - RoundedRectangle with cornerRadius 25
        - stroke in accentColor, linewidth 4


**Screen Details**
- About Button: IconButton with label as SystemImage "info.circle," location top left not ignoring safe area.
- Help Button: IconButton with label as SystemImage "question.circle," location top right not ignoring safe area.
- Game Button: NameButton with label as SystemImage "gamecontroller.fill" and text as "Game", location center above Solver Button
- Solver Button: NameButton with label as SystemImage "wand.and.sparkles" and text as "Solver", location center below Game Button
- Leaderboard Button: IconButton with label as SystemImage "chart.bar.xaxis," location bottom left not ignoring safe area.
- Setting Button: IconButton with label as SystemImage "gearshape.fill," location bottom right not ignoring safe area.

## [UUID-003] AboutView detail

Connects to [UXID-002](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.dpoanieffg3k) 

File name: AboutView.swift

Implements:

1. Type: Sheet
    - 밑으로 내리는 Swipe Action을 취하면 dismiss된다.
2. 3개의 Text가 필요하다.
    - Version Information
    - Developer Information
    - GNU License Information
3. Easter Egg는 TBD 로 결정하되 현재로선 버튼으로 구현되어 있다.

![AboutView Image Specified](pXy_Image_5.jpeg)

*(Fig. 2) About Conceptual Design*

![AboutView Image Specification 2.1](2.1_AboutView)

*(Fig. 2.1) About Storyboard UI Design*

### [Fig 2.1] Storyboard Design Description

- VStack (alignment: center)
    - titleLabel (width 230, height 115)
        - Type: Text
        - Text: "Ultimate Sudoku Pro" ( localized from Localizable )
        - Font: Chalkduster
        - Size: 28.0
        - Multiline alignment: center
    - versionLabel (width 150, height 20)
        - Type: Text
        - Text: "Version: 1.0"
        - Font: headline
        - Padding: ???
        - Content: Pull from Bundle with code below and with helper code "buildNumber"
    ```Swift
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {}
    ```
    - HStack
        - developersLabel (height 20)
            - Type: Text
            - Text: "Developers :"
            - Font: bold
            - Padding: horizontal, 40
        - Spacer
    - staffsLabel (wdith 260, height 90)
        - Type: Text
        - Text: "Team leader: Hungu Lim
                Technical writer: Jisu Lim
                Quality manager: Hyunsu Lim..."
        - Font: semibold
        - Multiline alignment: leading
    - HStack
        - licenseLabel (height 20)
            - Type: Text
            - Text: "License Info :"
            - Font: bold
            - Padding: horizontal, 40
        - Spacer
    - Scrollview (width 330, height 280)
        - License info text
        - Font: caption
        - Multiline Text Alignment: leading
        - Padding

GNU License Script:

Copyright (C) 2025 moof software

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.


## [UUID-004] HelpView detail

Connects to [UXID-004](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.wgh1tju4ajc5)

File name: HelpView.swift

Implements:

1. Type: Navigation Link
    - Back Button이 자동으로 생성된다.
    - GameHomeView로 연결된다.
2. 여러개의 페이지가 존재할 예정이다. (TBD)
    - 여러개의 페이지를 구현할 방법이 모색되면 알맞게 버튼이나 뷰가 추가될 예정이다.

![HelpView Image Specified](hU3_Image_8.jpeg)

*(Fig. 3) Help Conceptual Design*

![HelpView Image Specification 3.1](3.1_HelpView)

*(Fig. 3.1) Help Storyboard UI Design*

### [Fig 2.1] Storyboard Design Description

- VStack
    - ScrollView(horizontal)
        - LazyHStack(Spacing:0)
            - Images put in using ForEach
                - Modifiers: resizeable, scaled to fit, container relative frame adjusted for horizontal, count and span 1.
        - Modifier: Scroll to Target Layout
    - Modifiers: Scroll to Target Behavior(paging), Scroll Position(with ID), Scroll Indicators (set to never)
    - Text that shows page/all page number

## [UUID-005] LeaderBoardView detail

Connects to [UXID-012](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.8aiqkkjs65ej) 

File name: LeaderBoardView.swift

Implements:

1. Type: Sheet
    - 밑으로 내리는 Swipe Action을 취하면 뷰가 dismiss 된다.
2. 1개의 버튼을 가진다.
    - Clear Button
3. 1개의 Text를 가진다.
    - “Leaderboard View” 라고 적혀있으며 Placeholder이다.

![LeaderBoardView Image Specified](GRz_Image_10.jpeg)

*(Fig. 4) Leader Board Conceptual Design*

## [UUID-006] SettingView detail

Connects to [UXID-013](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.h04ag8s8httz) 

File name: SettingView.swift

Implements:

1. Type: Sheet
    - 밑으로 내리는 Swipe Action을 취하면 뷰가 dismiss 된다.
2. 1개의 Toggle을 가진다.
    - Sound Toggle (Action TBD)

3. 2개의 Picker을 가진다.
    - Effects Segmented Picker (Action TBD)
    - Tile Patterns Segmented Picker (Action TBD)

![SettingView Image Specified](shb_Image_12.jpeg)

*(Fig. 5) Setting Conceptual Design*

## [UUID-007] LevelView detail

Connects to [UXID-006](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.fu6pj9lxeugc) 

File name: LevelView.swift

Implements:

1. Type: Navigation Link
    - Back Button이 자동으로 만들어진다.
    - GameHomeView로 연결된다.
2. 4개의 Button을 갖는다
    - Easy
    - Medium
    - Hard
    - Resume

![LevelView Image Specified](oUg_Image_14.jpeg)

*(Fig. 6) Level Conceptual Design*

![LevelView Image Specification 6.1](6.1_LevelView)

*(Fig. 6.1) Levels Storyboard UI Design*

### [Fig 6.1] Storyboard Design Description

Button Type: NameButtonView, located in Components folder

**NameButton:** 
- Parameters: title (String), size (Int)
- Label: title as Text
    - Modifiers: custom font of "Chalkduster", size: CGFloat(size)

**Screen Details**
- VStack
    - Title
        - Type: Text
        - Text: "Levels"
        - Font: custom("Chalkduster", size: 28), bold
    - Easy Button
        - Action: open GameBoardView(append path to boardView)
        - Label: NameButtonView with localized title "Easy", size 32
        - Default padding
    - Medium Button
        - Action: open GameBoardView(append path to boardView)
        - Label: NameButtonView with localized title "Medium", size 32
        - Default padding
    - Hard Button
        - Action: open GameBoardView(append path to boardView)
        - Label: NameButtonView with localized title "Hard", size 32
        - Default padding

## [UUID-008] ScoreView detail

Connects to [UXID-008](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.whn6zythk9x)

File name: ScoreView.swift

Implements:

1. Type: Sheet
    - 밑으로 내리는 Swipe Action을 취하면 dismiss 된다.
2. 1개의 Text
    - “Score View” Placeholder

![ScoreView Image Specified](XZY_Image_16.jpeg)

*(Fig. 7) Score Conceptual Design*

## [UUID-009] GameBoardView detail

Connects to [UXID-007](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.41rvsmmfog15)

File name: GameBoardView.swift

Implements:

1. Type: Navigation Link
    - Back Button을 없앤다.
2. 6개의 Text가 존재한다.
    - “Error,” “Score,” “Time” 이 존재한다. (Placeholder)
    - “Board,” “Number Pad”, “Ads” 가 존재한다. (Placeholder)
    - (임시) “Score” Text를 LevelView 에서 선택한 Button의 값을 표시한다.

3. 5개의 버튼이 존재한다.
    - Rewind
    - Undo
    - Redo
    - Hint
    - Memo

![GameBoardView Image Specified](OS3_Image_18.jpeg)

*(Fig. 8) Game Board Conceptual Design*

![GameBoardView Image Specification 8.1](8.1_GameBoardView)

*(Fig. 8.1) Game Board Storyboard UI Design*

### [Fig 8.1] Storyboard Design Description

scoreText: String, default set to "Score"
memoToggled: Boolean, default set to false
showScoreView: Boolean, default set to false

- VStack
    - HStack
        - Text: "Errors"
            - Font: Custom font "Chalkduster", size: 18
        - Spacer
        - Text: scoreText
            - Font: Custom font "Chalkduster", size: 18
        - Spacer
        - Text: "Time"
            - Font: Custom font "Chalkduster", size: 18
    - Spacer
    - Game Board
        - ZStack(alignment: center)
            - Rounded Rectangle (cornerRadius 4)
                - Frame: width and height infinity
                - Background: gray, opacity 0.2
                - ForegroundStyle: gray, opacity 0.2
                - aspectRatio: 1.0, contentMode: fit
        - Board() with padding 1
    - Default padding
    - HStack
        - Button: Restart (label: arrow.counterclockwise)
            - Action: changeBoardText("Restart")
            - Padding: 10
        - Button: Undo (label: arrow.left)
            - Action: changeBoardText("Undoing...")
            - Padding: 10
        - Button: Redo (label: arrow.right)
            - Action: changeBoardText("Redoing...")
            - Padding: 10
        - Button: Hint (label: "Hint" with custom font "Chalkduster" pt 18)
            - Action: changeBoardText("Hint")
            - Padding: 10
        - Spacer
        - Button: Memo (label: pencil)
            - Action: Toggle memoToggled
            - Padding: 10
    - Text
        - Conditional operator relying on memoToggled
        - if memoToggled = True, set to "Memo"
        - if memoToggled = False, provide NumberPad
        - Frame: maxWidth infinity, maxHeight 70
        - Background: gray, opacity 0.2
    - Spacer
    - HStack
        - Button: End (label: "End" with custom font "Chalkduster" pt 18)
            - Action: remove last path (connect back to levelView)
            - Default padding
        - Button: Score (label: "Score" with custom font "Chalkduster" pt 18)
            - Action: toggle showScoreView(showing ScoreView sheet)
            - Default padding
            - .sheet to present ScoreView (must connect path)
    - Spacer
    - Text: "Ads"

- Function: changeBoardText
    - Parameters: to (temporaray string), duration: 3(TimeInterval)
    - Action: Set scoreText to temporary string, use DispatchQueue to asyncAfter duration (seconds) and change back to default("Score")

![GameBoardView UML 8.2](UML_Overview)

*(Fig. 8.2) Sudoku Board UML Design Overview*

### 8.2) UML Design Breakdown

![GameBoardView UML 8.2.1](UML1)

*(Fig. 8.2.1) Sudoku Class UML Design*

Sudoku(Class)
- Wrapped by @Model class wrapper
- Contains the following properties:
    - `table: [[CellProperty]]`
    - `level: Int`
    - `columnNote: [<Int>]`
    - `rowNote: [<Int>]`
    - `blockNote: [<Int>]`
- Contains the following methods:
    - `init(level:Int): void`
    - `seeding(): void`
    - `dataSwapper(): void`
    - `makeTable(level:Int): void`
    - `updateNotes(cell:cellLocation): void`

![GameBoardView UML 8.2.2](UML2)

*(Fig. 8.2.2) CellLocation Struct UML Design*

CellLocation(Struct)
- Contains the following properties:
    - `board: Grid`
    - `block: Grid`
    - `cell: Grid`

![GameBoardView UML 8.2.3](UML3)

*(Fig. 8.2.2) CellProperty Struct UML Design*

CellProperty(Struct)
- Contains the following properties:
    - `location: CellLocation`
    - `visible: Bool`
    - `value: Int`
    - `select: Bool`
    - `note: <Int>`

![GameBoardView UML 8.2.4](UML4)

*(Fig. 8.2.2) Grid Struct UML Design*

Grid(Struct)
- Contains the following properties:
    - `row: Int`
    - `column: Int`

![GameBoardView UML 8.2.5](UML5)

*(Fig. 8.2.2) Data Struct UML Design*

Data(Struct)
- Contains the following properties:
    - `table: [[CellProperty]]`

## [UUID-010] SolverView detail

Connects to [UXID-009](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.c1mlmt2yuhtz)

File name: SolverView.swift

Implements:

1. Type: Navigation Link
    - Back Button이 자동으로 생성된다.
    - GameHomeView로 연결되어 있다.

2. 2개의 Button을 갖는다
    - Manual Button (Action: SolutionView 열기)
    - Camera Button (Action TBD)

![SolverView Image Specified](BgG_Image_20.jpeg)

*(Fig. 9) Solver Conceptual Design*

## [UUID-011] SolutionView detail

Connects to [UXID-010](https://docs.google.com/document/d/1u0TZvop8mj24Qc8F9U_8gmA_11DPu_a0_A2RHEuICnk/edit?tab=t.0#heading=h.d5hyhr3glsh4) 

File name: SolutionView.swift

Implements:

1. Type: Navigation Link
2. 1개의 Text를 가진다.
    - “Board”
3. 2개의 Button을 가진다.
    - “Solve it!”
    - Home

![Enter image alt description](cwz_Image_22.jpeg)

*(Fig. 10) Solution Conceptual Design*

## [UIID-TBD] Game Center Details (FR-13)

*Details for this part is to be determined later.*


## [UIID-TBD] Game Screen  Details (TBD, v2.0)

*Details for this part is to be determined later.*

## [UIID-TBD] Capture Screen Details

*Details for this part is to be determined later.*

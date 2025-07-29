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

### 1.1 Storyboard Design Description
- About Button: info.circle image, takes user to About Page, point size 30
- Help Button: question.circle image, takes user to Help Page, point size 30
- Game Button: gamecontroller.fill image, takes user to Level Page, icon placement top, corner radius 25
- Solver Button: wand.and.sparkles image, takes user to Solver Page, icon placement top, corner radius 25
- Leaderboard Button: chart.bar.xaxis image, takes user to Leaderboard Page, point size 30
- Setting Button: gearshape.fill image, takes user to Settings Page, point size 30

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

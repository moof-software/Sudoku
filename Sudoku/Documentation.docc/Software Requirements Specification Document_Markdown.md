

# [Project 1] Software Requirements Specification


Date Created: 07/02/25

Created by: Hungu Lim, Jisu Lim, Hyunsu Lim

Version: 1.0


## 1. Introduction

### 1.1 Purpose

“Project 1: Sudoku” provided by moof software aims to deliver a user-friendly, innovative app that primarily focuses on an outstanding software architecture combined with redefining the scope of functionality and playability of the traditional Sudoku game.

이 문서는 **클래식 스도쿠 게임**의 개발을 위한 소프트웨어 요구사항을 정의합니다. 이 SRS는 개발자, 디자이너, QA 테스터, 프로젝트 관리자, 사용자 등 프로젝트의 모든 이해관계자들이 참조할 수 있는 기반 자료입니다.

### 1.2 Intended Audience

In the context of the design choice to utilize Swift, our audience clusters around Apple environment users, specifically iOS. The software is oriented around a guided experience on game play and its various modes, focusing on a simplistic user-interface, UI/UX, and design.

Swift라는 프로그램 언어를 사용하면서 주요 타겟층은 Apple 환경의 사용자들, 특히 iOS 사용자들입니다. 이 소프트웨어는 게임 플레이와 다양한 모드를 안내하며, 심플한 UI·UX 디자인을 지향합니다.

### 1.3 Intended Use

The software is accessible through app marketplaces, primarily on Apple’s App Store with the device requirements being iPhone, iPad, and/or any devices that support iOS 26. The software is intended to be out-of-the-box design that excludes any low-level customizations from the user themselves. The software should be accessible, simple, easy-to-learn, and work as expected per marketing.

This document provides various features and product expectations for standardized development of such usage.

이 소프트웨어는 다양한 앱 시장을 통해 접근할 수 있으며, 주로 Apple의 App Store에서 제공됩니다. 사용 가능한 기기는 iPhone, iPad 및 iOS 26을 지원하는 모든 기기입니다. 이 소프트웨어는 사용자가 직접 세부적인 설정을 변경하지 않아도 되는 즉시 사용 가능한(out-of-the-box) 디자인을 목표로 합니다. 또한 접근성이 뛰어나고, 심플하며, 배우기 쉽고, 마케팅에서 제시한 대로 기대한 기능을 수행해야 합니다.

본 문서는 이러한 사용 사례의 표준화된 개발을 위해 다양한 기능과 제품 기대사항을 제공합니다.

### 1.4 Product Scope

This product is a classic Sudoku Puzzle game based on a 9x9 grid. Users can produce a puzzle and play, receive hints and verify their answers, and save the current game and reload it if needed.

This game is a single-player game provided on desktop, tablet, and mobile environments. Puzzles must have a unique solution, and have various difficulties(Easy, Medium, Hard).

이 제품은 9x9 그리드를 기반으로 한 **클래식 스도쿠 퍼즐 게임**입니다. 사용자는 퍼즐을 생성하고 플레이하며, 힌트를 얻거나 검증할 수 있고, 진행 중인 게임을 저장하거나 불러올 수 있습니다.

본 게임은 데스크탑, 태블릿 및 모바일 환경 모두에서 사용할 수 있는 **단일 사용자 게임**입니다. 퍼즐은 항상 고유한 해를 가져야 하며, 다양한 난이도(쉬움, 보통, 어려움)를 제공합니다.

### 1.5 Definitions and Acronyms

| 용어 | 설명 |
|---|---|
| SRS | Software Requirements Specification |
| GUI | Graphical User Interface |
| RNG | Random Number Generator |
| Puzzle Grid | 9x9 스도쿠 보드 (9x9 Sudoku Board) |
| Block | 3x3 하위 블록 (총 9개)  |
| Cell | 보드의 각 칸 (총 81개) |


## 2. Overall Description

### 2.1 Sudoku Definition

### 2.1.1 Introduction

Sudoku is a puzzle game traditionally designed for single-player, similar to a crossword puzzle. The game requires attention to simple number patterns and organization to fill in blank parts of the board in an orderly fashion.

스도쿠는 전통적으로 단일 사용자들을 위해 만들어진 퍼즐 게임으로, 십자말풀이와 유사합니다. 이 게임은 단순한 숫자 패턴과 규칙등을 통해서 보드에 있는 빈칸은 질서 있게 채워 넣어야 됩니다.

### 2.1.2 Environment and Restrictions

The game consists of a board of 81 individual cells in a 9x9 placement. The structure is defined into 3 compartments:

- **Row**: horizontal sequence of 9 cells

- **Column**: vertical sequence of 9 cells

- **Block**: 3x3 sub-placement of a group of cells, total of 9 blocks defined without overlap

Allowed dynamic game pieces are numbers 1-9, where some cells are predefined on the board with a number, while others are left blank.

The board itself should be defined without number repetition within row, column, **AND** block, allowing each generation to consist of a unique, defined solution for the whole board. Conversely, there would only be a limited amount of available board generations (over 6 billion trillion) and a limited amount of starting conditions for each generation.

Therefore, if generated correctly, each cell will have **one** **unique** solution.

이 게임은 9x9 배열로 구성된 총 81개의 개별 셀로 이루어진 보드를 사용합니다. 이 구조는 다음의 3가지 구획으로 나뉩니다.

- **행(Row)**: 가로로 연속된 9개의 셀

- **열(Column)**: 세로로 연속된 9개의 셀

- **블록(Block)**: 3x3으로 이루어진 총 9개의 셀 구역

사용 가능한 숫자는 1~9이며, 일부 셀에는 미리 숫자가 입력되어 있고 나머지 셀은 비워져 있습니다. 보드는 행, 열, 그리고 블록 내에서 숫자가 반복되지 않도록 정의되어야 하며, 전체적으로 단 하나의 해답만을 가져야 합니다. 총 생성 가능한 보드 수도 약 6백만 조로 제한됩니다.

따라서 올바르게 생성되면 각 셀은 하나의 유일한 해답을 가지게 됩니다.

### 2.1.3 Objective

With a correct generation of the board, the game's objective is to fill in the blanks to complete the board, until no empty cells are left.

보드가 올바르게 생성되었다는 전제 하에, 플레이어의 목표는 모든 빈칸을 채워 보드를 완성하는 것입니다.

### 2.1.4 Difficulty

Traditionally, the difficulty is rated in relation to how many cells are empty, requiring the user to use more complex techniques to progress through the board.

전통적으로 난이도는 빈칸의 개수에 따라 정의되며, 빈칸이 많을수록 사용자가 더 복잡한 기법을 사용해야 보드를 완성할 수 있습니다.

### 2.1.5 Tools

| Tool (도구) | Use (사용) |
|---|---|
| Number pad (숫자 패드) | Primary tool to input numbers into the cells for solving the board. (숫자를 입력하여 보드를 푸는 주요 도구) |
| Pencil (연필) | Note taking used for various different strategies defined below. (아래 설명된 여러 전략에 사용하는 메모 기능) |


### 2.1.6 Basic Techniques

| Technique | Description |
|---|---|
| Open Singles | Filling in a row, column, or block with only 1 empty cell through counting. |
| Visual Elimination | Visualizing same numbered cells and its positions to infer positions for that same number on a block without it. |
| Pencil Marking | When there are no Open Single and visual elimination provides multiple answers on a same particular cell, marking those possible numbers on the cell without guessing an answer is defined as pencil marking. |
| Lone Singles | Through pencil marking and continuing to solve the board, cells with single pencil marks will appear, revealing the answer, which are called lone singles. |
| Hidden Singles | When a pencil mark is placed in a position where its rows, columns, and block does not include any numbers or pencil marks of the same indicated number, that number will be the answer. |
| Naked Pair | When two cells in the same row, column, or block share exactly the same two pencil marks (like 2 and 3); this means no other cells in that house can be those numbers, allowing you to eliminate them as pencil marks elsewhere. |
| Naked Triplets and Quads | If three (or four) cells in the same house share only three (or four) total candidates, those candidates must go in those cells, allowing them to be eliminated from all others in that house. |
| Omission | Removes pencil marks when candidates in a row or column are confined to a single block (or vice versa). If a number’s only possible positions in a row or column lie within one block, you can eliminate that number from the rest of the block—and the reverse is also true. |
| Hidden Pair/Triplet/Quad | When a set of digits appear as candidates in exactly the same number of set cells of a house, even if those cells have another pencil mark, all other candidates in them can be removed. |

| 기술 | 설명 |
|---|---|
| Open Singles | 행, 열, 또는 블록에서 빈 칸이 단 하나인 경우 그 빈 칸을 채우는 방법 |
| Visual Elimination | 시각적으로 같은 숫자들의 위치를 파악해 해당 숫자가 없는 블록 내 위치를 추론하는 기법 |
| Pencil Marking | Open Single 나 Visual Elimination으로도 여러 후보 숫자가 남아 있을때 가능한 숫자들을 셀에 적어 표시하는 방법 |
| Lone Singles | Pencil Marking을 활용해 보드를 풀다가 후보 숫자가 하나 남는 걸 통해 정답을 찾는 방법 |
| Hidden Singles | 행, 열, 블록 내 특정 후보 숫자가 표시된 곳이 오직 한 곳일때 그 숫자를 정답으로 하는 기법 |
| Naked Pair | 같은 행, 열, 또는 블록 내에 두개의 셀이 정확히 같은 두 후보 숫자 (예:2 와 3)를 가질때 반드시 그 두 셀에 두 숫자가 들어가야 하므로 나머지 셀에서는 제외하는 기법 |
| Naked Triplets and Quads | 세 개(또는 네 개)의 셀이 같은 행, 열, 또는 블록 내에서 총 세 개(또는 네 개)의 후보 숫자만 가질 때, 이 후보 숫자들은 해당 셀들에 반드시 들어가야 하므로 다른 셀에서는 제외하는 기법 |
| Omission | 같은 행, 열 내의 후보 숫자가 같은 구획에 제한이 되면, 그 블록의 다른 후보 숫자들을 지울 수 있는 기법 |
| Hidden Pair/Triplet/Quad | 후보 숫자들이 특정 집합 내 정확히 같은 개수의 셀에만 등장하는 경우, 해당 셀들에서 다른 후보 숫자들은 제거할 수 있는 기법 |


### 2.1.7 Advanced Techniques

| Technique | Description |
|---|---|
| X-Wing | If there exist two parallel rows/columns with the same candidates in the exact same two spots, diagonal candidates can be the same number, therefore eliminating similar candidates in the columns passing through these spots. |
| Swordfish | If three rows/columns contain a candidate in at most three matching columns/rows, then those positions must contain the candidate, allowing you to eliminate that number from the rest of those columns/rows. |
| XY Wing | There are three cells: the center (green) shares candidates with both wings (blue). The number shared by the wings must be in one of them, so you can eliminate that number from other cells in the same row or column (pink) as the wings. |


| 기술 | 설명 |
|---|---|
| X-Wing | 두개의 평행한 행/열에 동일한 후보 숫자가 정확히 같은 두 칸에 있을 때, 그 숫자는 각 행/열의 두 칸 중 하나에 반드시 들어가기 때문에 이 두 칸이 포함되는 열/행의 다른 칸들에선 해당 후보 숫자를 제거 할 수 있는 기법 |
| Swordfish | 세 개의 행/열에 특정 후보 숫자가 최대 세 개의 같은 열/행에만 나타날 때, 그 후보는 반드시 그 세 행/열과 세 열/행의 교차점에 위치해야 되므로 해당 숫자는 그 열/행의 다른 칸들에서 제거 할 수 있는 기법 |
| XY Wing | 세 개의 칸이 있고, 가운데(녹색) 칸은 양쪽 날개(파란색) 칸과 후보 숫자를 공유합니다. 두 날개에 공통된 숫자는 반드시 둘 중 하나에 들어가야 하므로, 두 날개가 있는 행/열(핑크색)의 다른 셀에서는 그 후보 숫자를 지울 수 있는 기법 |

### 2.2 User Needs

- A stand-alone or web-based game that runs directly on the client side without a backend server.

- Puzzle generation algorithm, UI, game logic are all modularized.

- Optional features include puzzle result saving, limit on number of hints, and automatic grading.

- 독립 실행형 또는 웹 기반 게임으로, 백엔드 서버 없이 클라이언트 사이드에서 작동

- 퍼즐 생성 알고리즘, UI, 게임 로직은 모듈화되어 있음

- 선택적으로 퍼즐 결과 저장, 힌트 수 제한, 자동 채점 기능 포함

### 2.3 Assumptions and Dependencies

- V1.0 - Basic sudoku 기능을 제공한다. solve 기능은 무작위 수를 이용한 기본 기능을 제공한다.

- V2.0 - ML, AI등의 solution techniques를 구현하여 solve 기능을 향상되게 제공한다.

- V3.0 - 네트워크 연결을 이용한 2인 게임 기능을 제공한다..


## 3. Software Features and Requirements

### 3.1 Product Functions

- 고유 해를 갖는 스도쿠 퍼즐 생성

- 퍼즐 난이도 선택

- 숫자 입력 및 메모(펜슬 마크)

- 퍼즐 유효성 검증

- 힌트 제공

- 되돌리기 / 다시 실행

- 퍼즐 저장 및 불러오기

- 완료 시간 기록

- Produce a Sudoku Puzzle with a unique solution

- Selecting puzzle difficulty

- Number input and memo(pencil marking)

- Verifying puzzle effectiveness

- Provide hints

- Rewind/Reload

- Puzzle save and load

- Record finish time

### 3.2 Functional Requirements

Sudoku generation with unique UUID

하나의 유일한 UUID로 스도쿠 생성

### **[FR-1] 퍼즐 생성 (Puzzle Generation)**

- [FR-1.1] 보드 생성(Board Generation)

    - 시스템은 9x9 퍼즐을 생성해야 하며, 각 행/열/블록에 1~9가 랜덤으로, 중복 없이 배치되어야 한다.

    - System must produce a 9x9 puzzle that randomly places the numbers 1~9 in each row/column/block without duplicates.

- [FR-1.2] 난이도(Difficulty)

    - 난이도는 최소한 “쉬움”, “보통”, “어려움” 3단계로 제공되어야 한다.

    - At least three levels of difficulty (“Easy”, “Medium”, “Hard”) must be provided.

| 난이도 | 빈칸 수 | 특징 |
|---|---|---|
| 쉬움 | 35~40개 | 단순 논리로 풀이 가능 |
| 보통 | 41~50개 | 후보분석(메모기능) 필요 |
| 어려움 | 51개 이상 | 고급기법(Naked pair 등) 필요 |

| Difficulty | Blanks | Characteristics |
|---|---|---|
| Easy | 35~40 cells | Can be solved with simple logic |
| Medium | 41~50 cells | Needs candidate reviews(using memo function) |
| Hard | 51 cells or more | Advanced techniques (i.e., Naked pair) is necessary |

- [FR-1.3] 해(Solution)

    - 생성된 퍼즐은 단 하나의 해(unique solution)를 가져야 한다.

    - The generated puzzle must be solved with a unique solution.

### **[FR-2] 사용자 입력(User Input)**

- [FR-2.1] 셀 입력 (Cell Input)

    - 사용자는 빈 셀에 1~9 사이의 숫자를 입력할 수 있어야 한다.

    - User must be able to input the numbers 1~9 into an empty cell.

- [FR-2.2] 수정 불가능성 (Immutability)

    - 이미 제공된 숫자는 수정 불가능해야 한다.

    - Numbers that are already provided must be immutable.

- [FR-2.3] 실시간 업데이트 (Live Update)

    - 사용자 입력은 실시간으로 게임 보드에 표시되어야 한다.

    - User input must be updated live on the game board.

### **[FR-3] 메모(펜슬 마크) (Memo(Pencil Marking))**

- [FR-3.1] 메모 기능 (Memo Function)

    - 사용자는 하나의 셀에 다수의 후보 숫자를 메모할 수 있어야 한다.

    - User must be able to memo a variety of number candidates into one cell.

- [FR-3.2] 표시 방법 (Display Method)

    - 메모는 별도의 색상 또는 작은 글씨로 표시된다.

    - 사용자는 셀당 최대 9개의 숫자를 메모할 수 있다.

    - 메모 모드와 입력 모드는 명확히 구분되어야 한다.

    - Memo must be displayed in a different color or smaller font.

    - User can memo up to 9 numbers per cell.

    - Memo mode and input mode must be distinctly separated.

### **[FR-4] 검증 및 힌트 (Verification and Hints)**

- [FR-4.1] 검증 방법 (Verification Method)

    - 사용자는 현재 입력이 유효한지 검증할 수 있어야 한다.

    - User must be able to verify their current input.

    - 시스템은 잘못된 셀을 시각적으로 표시해야 한다.

    - System must visually display an incorrect cell.

- [FR-4.2] 힌트 방법 (Hint Method)

    - 사용자가 요청할 경우, 시스템은 빈 셀 하나에 정답을 채워주는 힌트를 제공한다.

    - Per user’s request, the system must fill in a blank cell with its answer as a hint.

    - 힌트는 사용 가능 횟수를 제한할 수 있다.

    - There can be a limit to hint usage.

### **[FR-5] 게임 상태 저장/불러오기 (LOAD & SAVE)**

- [FR-5.1] 저장 기능 (SAVE)

    - 사용자는 현재 진행 중인 게임을 저장할 수 있어야 한다.

    - User must be able to save their current game.

- [FR-5.2] 불러오기 (LOAD)

    - 저장된 퍼즐은 앱을 재실행한 후에도 불러올 수 있어야 한다.

    - Saved puzzles can be loaded once the app is reloaded.

### **[FR-6] 타이머 및 기록 (Time and Record)**

- [FR-6.1] 타이머 작동 (Timer Function)

    - 퍼즐 시작 시 타이머가 작동해야 한다.

    - Timer must start as soon as the puzzle begins.

- [FR-6.2] 완료 기능 (Finish Function)

    - 완료 시 걸린 시간을 기록하여 표시한다.

    - Once a puzzle is finished, the time is recorded and displayed.

- [FR-6.3] 최고 기록 (Best Record)

    - 최고 기록을 저장하고 갱신한다.

    - Best records must be saved and renewed if needed.

### **[FR-7] Undo/Redo/Restart**

- [FR-7.1] Undo/Redo

    - 사용자는 마지막 입력을 되돌리거나 다시 실행할 수 있어야 한다.

    - Users must be able to undo or redo their last input.

- [FR-7.2] Restart

    - 사용자는 게임을 다시 실행할 수 있어야 한다.

    - Users must be able to restart their game.

- [FR-7.3] 제한 (Restriction)

    - 최대 되돌리기 단계 수는 제한 없이 저장된다.

    - There are no limits to the number of rewinds a user has.

### **[FR-8] 광고 (Advertisement)**

- [FR-8.1] 광고기능(Advertisement Function)

    - 화면 하단에 광고가 존재한다.

    - There exists ads on the lower portion of the screen.

### **[FR-9] 세팅(Setting)**

- [FR-9.1] 세팅기능(Setting Function)

    - 소리, 효과, 타일 디자인 등등을 사용자가 정의할 수 있어야 한다.

    - Users must be able to set their own sound, effects, and tile design.

### **[FR-10] 튜토리얼 (Tutorial)**

- [FR-10.1] 튜토리얼 기능 (Tutorial Function)

    - 처음 스도쿠 사용자에게 스도쿠 플레이 방법을 설명한다.

    - Tutorial must explain how to play Sudoku to first-time Sudoku players.

### **[FR-11] 지원 기기 (Supported Devices)**

- [FR-11.1] OS

    - iOS와 iPadOS를 동시 지원한다.

    - This game supports both iOS and iPadOS.

### **[FR-12] About & License**

- [FR-12.1] 정보 제공 화면 (Informational Screen)

    -  About, GNU License, Easter Egg, Ending Credit을 포함한 화면이 제공된다.

    - There exists an informational screen with About, GNU License, Easter Egg, and Ending Credit.

### **[FR-13] 게임 센터 (Game Center)**

- [FR-13.1] 로그인 (Log-in)

    - 스도쿠에 Apple ID를 이용하여 게임 센터에 접속할 수 있다.

    - Users can use Apple ID to enter the Sudoku Game.

- [FR-13.2] 랭킹 등록 (Rankings)

    - 게임센터의 친구기능과 랭킹을 사용하여 자신의 랭킹을 등록할 수 있다.

    - Users can input their rankings using Game Center’s Friends and Ranking feature.

### **[FR-14] 대결 (Competition)** → v2.0에 업데이트 할 예정 (TBD on v2.0)

- [FR-14.1] 멀티 기능 (Multiplayer Function)

    - 같은 네트워크를 사용하는 Peer to Peer 또는 게임 센터를 사용한 다인 플레이 기능을 제공한다.

    - Game will provide multiplayer functions such as peer-to-peer play using the same network or Game Center.

- [FR-14.2] 모드 (Modes)

    - Competition mode: 동일한 Sudoku Board를 생성하여 게임 센터내에 접속중인 유저 또는 근거리 Peer to Peer 연결된 게임 유저와 풀이 시간을 경쟁하는 방식. 동시에 게임을 시작하여 가장 많은 스도쿠 타일값을 찾은 유저가 승리하는 방식.

    - Turn by Turn mode: 동일한 Sudoku Board를 생성하여 게임 센터내에 접속중인 유저 또는 근거리 Peer to Peer 연결된 게임 유저와 번갈아 가면서 주어진 짤은 시간에 한개의 스도쿠 타일 값을 찾아보는 경쟁을 하는 방식. 본인의 턴에서 주어진 짤은 시간내에 타일 값은 찾지 못하면 패하는 방식. 스도쿠 전체 값은 찾으면 Draw됨.

    - Head to head mode: 동일한 Sudoku Board를 생성하여 게임 센터내에 접속중인 유저 또는 근거리 Peer to Peer 연결된 게임 유저와 풀이 시간을 경쟁하는 방식. 동시에 게임을 시작하여 가장 빠른 시간에 풀이를 완료한 유저가 승리하는 방식.

### **[FR-15] 점수 (Scores)**

- [FR-15.1] 점수 기능 (Score Function)

    - 점수 관리 기능이 있다.

    - There is a function to manage scores.

### **[FR-16] 소리 & 진동 (Sound & Haptics)**

- [FR-16.1] 기능 (Functions)

    - SOUND & HAPTICS 기능이 있다.

    - There’s sound and haptics.

### **[FR-17] 풀이 모드] (Solver Mode)**

- [FR-17.1] 풀이 기능 (Solver Function)

    - 유저가 못푸는 스도쿠를 직접 입력하거나 사진을 찍어 올리면 스도쿠의 해를 찾아주는 기능이 있다.

    - If there exists a Sudoku game that a user cannot solve, they can manually input the game or take a picture to the solver to receive its solution.

### 3.3 External Interface Requirements

### 3.3.1 User Interfaces

- Basic Board : 9x9 Cell

- Each Cell: Number Input, Pencil Marking Function

- Upper UI: Timer, Hint Button, Rewind/Reload

- Lower UI: Number Keypad, Save/Load Button

- 기본 보드: 9x9 셀

- 각 셀: 숫자 입력, 펜슬 마크 가능

- 상단 UI: 타이머, 힌트 버튼, 되돌리기/다시 실행

- 하단 UI: 숫자 키패드, 저장/불러오기 버튼

### 3.3.2 Hardware Interfaces

- Support for mouse and touchscreen input

- Support for keyboard input (numbers 1-9)

- 마우스 또는 터치스크린 지원

- 키보드 입력 지원 (1~9 숫자)

### 3.3.3 Software Interfaces

- Local File Save: localStorage, IndexedDB, or file system

- Optional Integration with Analytics Tools (e.g., Google Analytics, Firebase)

- 로컬 파일 저장: localStorage, IndexedDB, 또는 파일 시스템

- 선택적 분석 도구 연동 (Google Analytics, Firebase 등)

### 3.4 Software Features

### 3.5 Nonfunctional Requirements

| 요구사항 코드 (Requesting Codes) | 설명 (Description) |
|---|---|
| NFR-1 | 응답 시간은 100ms 이내 (로컬 상호작용 기준) (Responding time within 100ms (based on local interactions)) |
| NFR-2 | 퍼즐 생성 시간은 1초 이내 (Puzzle generation time within 1 second) |
| NFR-3 | UI는 모바일 및 데스크탑 환경에 반응형으로 적응 (UI must responsibly adapt to mobile and desktop environments) |
| NFR-4 | 데이터 저장은 JSON 또는 SQLite 기반 (Data storage must be based on JSON or SQLite) |
| NFR-5 | 앱은 무결성 있는 저장 및 복원 기능 제공 (Reliable data saving and restoration functionality) |
| NFR-6 | 사용자는 직관적인 인터페이스만으로 게임을 플레이할 수 있어야 함 (User must play game with intuitive interface) |
| NFR-7 | 모든 코드는 모듈화 및 주석 기반으로 유지보수가 용이해야 함 (All code should be modular and well-commented for maintainability) |

# asm-c-integration-practice
a practice repository combining C and ARM assembly

### 環境
- Raspberry Pi
- C 語言：C17
- 組合語言：ARMv5

### 主題
- 將 [`data/`](data/) 資料夾中的 **C Language 手動改寫成 Assembly Language**。

- [`data/`](data/) 為範例資料夾，裡面有 [drawJuliaSet.c](data/drawJuliaSet.c)、[id.c](data/id.c)、[main.c](data/main.c)、[name.c](data/name.c) 這四個 C 檔案，題目是將 drawJuliaSet.c、id.c、name.c 做轉換、修改，**將 C 語言人工轉成組合語言**，結果放在 [`src/`](src/) 中。

- [`src/`](src/) 資料夾中有 [drawJuliaSet.s](src/drawJuliaSet.s)、[id.s](src/id.s)、[main.c](src/main.c)、[name.s](src/name.s)，除了 main.c 只做了 format code，其他皆已轉成組合語言，執行時，main.c 會呼叫 drawJuliaSet.s、id.s、name.s 這三個函式。

### 函式說明
- `name.s`：輸出組別與每個組員的英文姓名。  
- `id.s`：讓使用者輸入每個組員的學號，並輸出學號加總。  
- `drawJuliaSet.s`：計算並決定 Frame 二維陣列的值，進而決定投影至 Frame Buffer 的像素顏色。  
- `main.c`：呼叫上述三個 ARM 組合語言函式，展示 C 與組合語言的整合。

### 範例輸出
相關程式執行輸出請見 [`images/`](images/)。

##### Note：本專案源自小組作業，但本 repo 中的所有實作內容（包含程式碼與文件）均由我獨立完成。

set windows-shell := ["pwsh.exe", "-NoLogo", "-Command"]

build:
    cargo build --release

screenpipe: build
    sudo .\target\release\screenpipe.exe --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id ((cargo run --bin screenpipe -- --list-monitors | Select-String 'DISPLAY1' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] -match '^\s*(\d+)' | Out-Null; $matches[1] }) | Select-Object -First 1).Trim() --use-pii-removal --audio-transcription-engine deepgram

screenpipe-audio: build
    sudo .\target\release\screenpipe.exe --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id ((cargo run --bin screenpipe -- --list-monitors | Select-String 'DISPLAY1' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] -match '^\s*(\d+)' | Out-Null; $matches[1] }) | Select-Object -First 1).Trim() --use-pii-removal --audio-transcription-engine deepgram --disable-vision

screenpipe-video: build
    sudo .\target\release\screenpipe.exe --ocr-engine windows-native --debug --audio-device "In 1-2 (MOTU M Series) (input)" --audio-device "Out 1-2 (MOTU M Series) (output)" --monitor-id ((cargo run --bin screenpipe -- --list-monitors | Select-String 'DISPLAY1' -Context 0,1 | ForEach-Object { $_.Context.PostContext[0] -match '^\s*(\d+)' | Out-Null; $matches[1] }) | Select-Object -First 1).Trim() --use-pii-removal --audio-transcription-engine deepgram --disable-audio

build-tauri: build
    cd examples/apps/screenpipe-app-tauri && bun scripts/pre_build.js && bun tauri build

dev-tauri: build
    cd examples/apps/screenpipe-app-tauri && bun scripts/pre_build.js && bun tauri dev

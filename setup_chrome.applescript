tell application "Finder"
	set screenRes to bounds of window of desktop
	set screenWidth to item 3 of screenRes
	set screenHeight to item 4 of screenRes
end tell

set halfWidth to (screenWidth / 2) as integer
set targetHeight to (screenHeight * 3 / 4) as integer
set bottomY to (screenHeight - targetHeight) as integer

-- Window 1 (Top Left)
do shell script "\"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome\" --profile-directory=\"Profile 17\" --new-window \"https://teams.entrade.com.vn/entrade/channels/techies\" > /dev/null 2>&1 &"
delay 1.5
tell application "Google Chrome"
	activate
	set bounds of window 1 to {0, 0, halfWidth, targetHeight}
end tell

-- Window 2 (Top Right)
do shell script "\"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome\" --profile-directory=\"Profile 8\" --new-window \"https://fireant.vn/dashboard\" > /dev/null 2>&1 &"
delay 1.5
tell application "Google Chrome"
	activate
	set bounds of window 1 to {halfWidth, 0, screenWidth, targetHeight}
end tell

-- Window 3 (Bottom Left)
do shell script "\"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome\" --profile-directory=\"Profile 17\" --new-window \"https://www.24h.com.vn/\" > /dev/null 2>&1 &"
delay 1.5
tell application "Google Chrome"
	activate
	set bounds of window 1 to {0, bottomY, halfWidth, screenHeight}
end tell

-- Window 4 (Bottom Right)
do shell script "\"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome\" --profile-directory=\"Profile 17\" --new-window \"https://entrade.atlassian.net/jira/for-you\" > /dev/null 2>&1 &"
delay 1.5
tell application "Google Chrome"
	activate
	set bounds of window 1 to {halfWidth, bottomY, screenWidth, screenHeight}
end tell

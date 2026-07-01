@echo off
echo Mapping ADB port...
adb reverse tcp:8081 tcp:8081
echo Starting Expo on localhost via USB...
cd /d D:\projects\dristiprep\apps\mobile
npx expo start --clear --localhost -a
pause

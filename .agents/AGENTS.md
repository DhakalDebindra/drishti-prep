# Workspace Customizations

## Mobile App Development

When running or testing the Expo mobile application for this user, **always** use the ADB reverse TCP port mapping alongside `localhost` mode. 

**Reasoning:** The user connects their Android device physically via USB. Using standard Expo LAN or Tunnel mode will consistently fail with `java.net.socket timeout exception` due to Windows Firewall/Wi-Fi router constraints on their network.

**Execution Script:**
Whenever you are asked to start the mobile app, run the `start-expo.bat` file in `apps/mobile/`, or execute this exact command string:

```powershell
adb reverse tcp:8081 tcp:8081; npx expo start --localhost -a
```

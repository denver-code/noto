
<p align="center">
    <a href="https://t.me/noto_app"><img src="https://telegram.org/img/t_logo.png?1"></a>
</p>
# Noto - No Tomorrow

**Description**
Noto (No Tomorrow) - this is a simple, minimalist application that will help you organize your workflow.
Here you can add tasks, change them, change their status, delete them, assign them to be completed on a particular day, or simply to a continuous list of functions, or you can make a shopping list so that you don't forget anything in the store.

**What you can do now?**
- add new tasks
- change their checking status
- delete tasks

**What do I want to add in the future? aka ToDo**
- Add tasks synchronization with the account
- Implement a daily task list
- Create account in Instagram/Patreon/PayPal
- Update the "add task" field, make it easiest and look more beautiful
- Make tasks draggable
- Implement task editing

## Run Noto on your android device from source code
> [!NOTE]
> For start confirm flutter instalation on your machine.
``` Bash
$ git clone https://github.com/denver-code/noto
$ cd noto
$ flutter analyze
$ flutter test
$ flutter pub get
$ flutter run lib/main.dart
```
##  Build an APK
> [!NOTE]
> For start confirm flutter instalation on your machine.
``` Bash
$ git clone https://github.com/denver-code/noto
$ cd noto
$ flutter analyze
$ flutter test
$ flutter pub get
$ flutter build apk --split-per-abi
```
This commands results in three APK files:
```
    [project]/build/app/outputs/apk/release/app-armeabi-v7a-release.apk
    [project]/build/app/outputs/apk/release/app-arm64-v8a-release.apk
    [project]/build/app/outputs/apk/release/app-x86_64-release.apk
```

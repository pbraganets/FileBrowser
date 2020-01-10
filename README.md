## The File Browser App

The iOS application allows user to scan a directory selecting files of predefined type ("Text", "Audio", "Video").
It should be possible to **add new types** in future. File type is determined by its extension. It should be possible to **use another approaches** in future.

Such operations are defined for a file:
- for all types: getting size in bytes
- for text: characters count
- for audio/video: playback duration (no need to calculate in real)

Such opertaions are defined for a group of files:
- number of files
- total size in bytes

It should be possilbe to **add new operations** in future (for files and file groups).
"Presentation" should be added as a query of files by some criteria. A criteria may be a combination of other criterias: f.e. audio files with duration less than a minute.


## User interface:
Application screen is divided into two parts:
- Files list
- File details.


## Technical details:
- The app is written in **Swift**
- Such best practices are used: Open-Closed, IoC, Decorator, Visitor, Extenstion Objects

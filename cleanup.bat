@echo off
cd %~dp0
cd ..

rd /Q /S CombatInsightsFightData
del /Q CHANGELOG.md
del /Q CombatInsights.lua
del /Q CombatInsights.txt
del /Q CombatInsights.xml
del /Q LICENSE

echo Trash deleted!
PAUSE
EXIT

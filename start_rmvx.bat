@echo off

REM #========================================================
REM #             Based on script
REM #      Developed by Raku (rakudayo@gmail.com)
REM #========================================================
REM # Use this batch file as you please.
REM #========================================================

REM #========================================================
REM #  Setup the Paths for the Importer/Exporter
REM #========================================================

REM # The path to the utility scripts relative to the project dir
SET SCRIPTS_DIR=Rvdata_Versioning_Utility

REM # The path to the project dir relative to the utility scripts
SET PROJECT_DIR=.

REM #===============================
REM #  Get current path
REM #===============================

SET START_FOLDER=%CD%

REM #===============================
REM #  Get Project path
REM #===============================

CD %START_FOLDER%
CD %PROJECT_DIR%
SET PROJECT_PATH=%CD%

REM #===============================
REM #  Get Scripts path
REM #===============================

CD %START_FOLDER%
CD %SCRIPTS_DIR%
SET SCRIPTS_PATH=%CD%

REM #===============================
REM #  Run scripts
REM #===============================

CD %SCRIPTS_PATH%
run.exe script_importer.rb "%PROJECT_PATH%"
run.exe data_importer.rb "%PROJECT_PATH%"

run.exe logtime.rb "%PROJECT_PATH%"

CD %PROJECT_PATH%
START /WAIT Game.rvproj

CD %SCRIPTS_PATH%
run.exe script_exporter.rb "%PROJECT_PATH%"
run.exe data_exporter.rb "%PROJECT_PATH%"

REM #================================
REM #  Return to Original Directory
REM #================================

CD %START_FOLDER%

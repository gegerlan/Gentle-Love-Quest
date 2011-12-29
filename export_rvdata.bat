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

REM # Where the script files can be found
SET SCRIPTS_DIR=Rvdata Versioning Utility

REM # Where the project folder can be found
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
run.exe script_exporter.rb "%PROJECT_PATH%"
run.exe data_exporter.rb "%PROJECT_PATH%"

REM #================================
REM #  Return to Original Directory
REM #================================

CD %START_FOLDER%
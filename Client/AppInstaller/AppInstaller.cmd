::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcFXVbTLoOpoS7czp5vyCnsvrs2T+u7P806CmNeIv31XgdIIoxEZ5lMIJAg9kVCiefgs1vWtQ+GeIM6c=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFEoDHV3QAES0A5EO4f7+02xxRcvcl94YcZvzz7ayFfAX61HhZ6oO2nNflt8wLQtIVxy4eg44pWtQimWPYZHN/gDqQ1GQqxtgSit9hGyw
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF65
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF65
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErTXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXrZg==
::ZQ05rAF9IAHYFVzEqQIROAsUZQqRKGq2CrAOiA==
::eg0/rx1wNQPfEVWB+kM9LVsJDC64CXu+B6EZ+qXa//qurF4JVe4zfZ2V36yLQA==
::fBEirQZwNQPfEVWB+kM9LVsJDC64CXu+B6EZ+m02H2NGe8rmmoI=
::cRolqwZ3JBvQF1fEqQK15vLcj+GoBl6qArQI7fq7ztq3wg==
::dhA7uBVwLU+EWGugxHEkPR9dQ2Q=
::YQ03rBFzNR3SWATE3ngFOB9VWAGQfCOIT9U=
::dhAmsQZ3MwfNWATE100gMQldSwyWfCOZT/VOuLmiorjX8BxdZsYPS5vO3r2BYMEf5gXWfJElwmkaqs4aCQlLexblDg==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFEoDHV3QAES0A5EO4f7+02xxRcvcl94YcZvzz7ayFfAX61HhZ6oO2nNflt8wLQtIVxy4eg44pWtQik6/AteYshvkWAWo9lsZFXZghm/ciTl1Zctt+g==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal EnableExtensions EnableDelayedExpansion

title App Installer

set "jz.appname=AppInstaller"
set "jz.ver=1001"
call JZUpdater.cmd
cls

:app
set jz.appname=none
set /p jz.appname=输入你想安装或重新安装的软件(需在JZUpdater数据库中记录)：
set "jz.ver=0"
if %jz.appname%==none goto :app
call JZUpdater.cmd
exit
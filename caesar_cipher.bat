@echo off
setlocal EnableDelayedExpansion

rem Set the encryption key (shift amount)
set /p "key=Enter encryption key (a number between 1 and 25): "

rem Clear the screen
cls

:menu
echo 1. Encrypt a message
echo 2. Decrypt a message
echo 3. Exit
set /p "choice=Enter your choice (1, 2, or 3): "

if "%choice%"=="1" (
    call :encrypt
) else if "%choice%"=="2" (
    call :decrypt
) else if "%choice%"=="3" (
    exit /b
) else (
    echo Invalid choice. Please try again.
    goto :menu
)

:encrypt
set /p "message=Enter the message to encrypt: "
set "encrypted="
for /l %%a in (0,1,25) do (
    set "temp="
    for %%b in (%message%) do (
        set "char=%%b"
        set /a "ascii=!char:~0,1!+!key!"
        if !ascii! gtr 90 set /a "ascii-=26"
        set "temp=!temp!!ascii:~-1!"
    )
    set "encrypted=!encrypted!!temp!|"
)
echo Encrypted message: %encrypted%
goto :menu

:decrypt
set /p "encrypted=Enter the encrypted message: "
set "decrypted="
for /l %%a in (0,1,25) do (
    set "temp="
    for %%b in (%encrypted%) do (
        set "group=%%b"
        for /l %%c in (0,1,25) do (
            set "char=!group:~%%c,1!"
            if "!char!"=="|" (
                set "temp=!temp!!char!"
            ) else (
                set /a "ascii=!char!-%%a"
                if !ascii! lss 65 set /a "ascii+=26"
                set "temp=!temp!!ascii:~-1!"
            )
        )
    )
    set "decrypted=!decrypted!!temp!"
)
echo Decrypted message: %decrypted%
goto :menu

@ECHO off
ECHO "Restart?"
pause
ECHO "Authenticating..."
curl "http://192.168.0.1/goform/Docsis_system" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.7,pt-BR;q=0.3" -H "Content-Type: application/x-www-form-urlencoded" -H "Origin: http://192.168.0.1" -H "Connection: keep-alive" -H "Referer: http://192.168.0.1/Docsis_system.asp" -H "Upgrade-Insecure-Requests: 1" --data "username_login=admin&password_login=admin&LanguageSelect=en&Language_Submit=0&login=Log+In" -L -c cookie.txt
ECHO "Fetching web token..."
curl "http://192.168.0.1/Devicerestart.asp" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.7,pt-BR;q=0.3" -H "Connection: keep-alive" -H "Referer: http://192.168.0.1/Administration.asp" -H "Upgrade-Insecure-Requests: 1" -L -b cookie.txt > response.txt
FOR /F "tokens=4" %%m in ('findstr webToken response.txt') do (
    SET m=%%m
)
SET webToken=%m:~6%
ECHO %webToken%
ECHO "Restarting..."
curl "http://192.168.0.1/goform/Devicerestart" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.7,pt-BR;q=0.3" -H "Content-Type: application/x-www-form-urlencoded" -H "Origin: http://192.168.0.1" -H "Connection: keep-alive" -H "Referer: http://192.168.0.1/Devicerestart.asp" -H "Upgrade-Insecure-Requests: 1" --data "devicerestrat_Password_check=admin&mtenRestore=Device+Restart&devicerestart=1&devicerestrat_getUsercheck=&webToken=%webToken%" -L -b cookie.txt
DEL response.txt
DEL cookie.txt


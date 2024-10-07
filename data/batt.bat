@echo off
setlocal enabledelayedexpansion

REM CSV 파일 경로 설정 (같은 폴더에 있는 경우)
set "csv_file=traffic_data.csv"
set "output_file=output.html"

REM HTML 파일 초기화
(
echo ^<html^>
echo ^<head^>^<meta charset="UTF-8"^>^</head^>
echo ^<body^>
) > "%output_file%"

REM CSV 파일 읽기
for /f "skip=1 tokens=1-8 delims=," %%a in (%csv_file%) do (
    REM 각 줄에 대한 데이터를 가져와 HTML 태그 생성
    set "time=%%a"
    set "road=%%f"
    set "road_number=%%d"
    set "direction=%%g"
    set "incident_type=%%h"
    set "details=%%i"
    
    REM 콤마(,) 처리
    set details=!details:"=!

    echo ^<div class="notification-content" style="margin-top:10px"^> >> "%output_file%"
    echo     ^<p class="hover-effect"^>^<i class="fas fa-clock clock-icon"^>^</i^> 시간: !time!^</p^> >> "%output_file%"
    echo     ^<p class="hover-effect"^>^<i class="fas fa-road road-icon"^>^</i^> 도로명: !road! (도로번호: !road_number!)^</p^> >> "%output_file%"
    echo     ^<p class="hover-effect"^>^<i class="fas fa-location-arrow direction-icon"^>^</i^> 방향: !direction!^</p^> >> "%output_file%"
    echo     ^<p class="hover-effect"^>^<i class="fas fa-exclamation-triangle warning-icon"^>^</i^> 사고 유형: !incident_type!^</p^> >> "%output_file%"
    echo     ^<p class="hover-effect"^>^<i class="fas fa-info-circle info-icon"^>^</i^> 상세 내용: !details!^</p^> >> "%output_file%"
    echo ^</div^> >> "%output_file%"
)

REM HTML 파일 종료
(
echo ^</body^>
echo ^</html^>
) >> "%output_file%"

echo HTML 태그가 %output_file% 파일로 생성되었습니다.
pause

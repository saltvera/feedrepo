# CSV 파일 경로 설정
$csv_file = "traffic_data.csv"
$output_file = "output.html"

# HTML 파일 초기화 (UTF-8로 인코딩 설정)
@"
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>교통사고 알림</title>
  <!-- Font Awesome 최신 CSS CDN -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* 전체 레이아웃 */
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f0f4f8;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    /* 알림창 스타일 */
    .notification-container {
      background-color: #ffffff;
      border-radius: 15px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 400px;
      padding: 20px;
      animation: fadeIn 0.5s ease-in-out;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    /* 박스 전체 호버 효과 */
    .notification-container:hover {
      transform: translateY(-10px);
      box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
    }

    /* 헤더 섹션 */
    .notification-header {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }

    .notification-icon {
      font-size: 24px;
      color: #e74c3c;
      margin-right: 10px;
    }

    .notification-title {
      font-size: 18px;
      font-weight: bold;
      color: #333;
    }

    /* 내용 섹션 */
    .notification-content p {
      font-size: 14px;
      color: #555;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
    }

    .clock-icon { color: #3498db; }
    .road-icon { color: #f39c12; }
    .direction-icon { color: #2ecc71; }
    .warning-icon { color: #e74c3c; }
    .info-icon { color: #8e44ad; }

    /* 호버 효과 */
    .hover-effect {
      transition: background-color 0.3s ease, transform 0.3s ease;
      border-radius: 8px;
      padding: 5px;
    }

    .hover-effect:hover {
      background-color: #f9f9f9;
      transform: translateY(-3px);
    }

    .hover-effect:hover i {
      transform: scale(1.2);
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>
"@ | Out-File -FilePath $output_file -Encoding UTF8

# CSV 파일 읽기 및 HTML 태그 반복 생성 (UTF-8 인코딩 사용)
Import-Csv $csv_file -Encoding UTF8 | ForEach-Object {
    $html_content = @"
    <div class="notification-container">
      <div class="notification-header">
        <i class="fas fa-car-crash notification-icon"></i>
        <h2 class="notification-title">교통사고 알림</h2>
      </div>
      <div class="notification-content">
        <p class="hover-effect"><i class="fas fa-clock clock-icon"></i> 시간: $_.돌발일시</p>
        <p class="hover-effect"><i class="fas fa-road road-icon"></i> 도로명: $_.도로명 (도로번호: $_.도로번호)</p>
        <p class="hover-effect"><i class="fas fa-location-arrow direction-icon"></i> 방향: $_.방향</p>
        <p class="hover-effect"><i class="fas fa-exclamation-triangle warning-icon"></i> 사고 유형: $_.돌발구분 - $_.돌발상세구분</p>
        <p class="hover-effect"><i class="fas fa-info-circle info-icon"></i> 상세 내용: $_.돌발내용</p>
      </div>
    </div>
"@
    $html_content | Out-File -FilePath $output_file -Append -Encoding UTF8
}

# HTML 파일 종료 태그 추가
@"
</body>
</html>
"@ | Out-File -FilePath $output_file -Append -Encoding UTF8

Write-Host "HTML 파일이 생성되었습니다: $output_file"

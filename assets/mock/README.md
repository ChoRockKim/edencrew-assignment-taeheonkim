# mock 응답

파싱 로직을 네트워크와 무관하게 맞추기 위해 실제 응답을 저장해 둔 것입니다.
수집일: 2026-09-18

종목은 Figma 시안 `01 · 관심`에 나오는 5개를 그대로 사용했습니다.

| 파일 | endpoint | 쓰이는 화면 |
| --- | --- | --- |
| `autocomplete_samsung.json` | 1. 검색 자동완성 (`q=삼성`) | 검색 |
| `autocomplete_empty.json` | 1. 검색 자동완성 — 결과 0건 | 검색 (`02 · 검색결과_empty`) |
| `realtime_quotes.json` | 2. 실시간 시세 — 5종목 일괄 조회 | 관심, 상세 |
| `meta_{symbol}.json` | 3. 종목 메타데이터 | 검색, 관심, 상세 |
| `daily_005930_1y.json` | 4. 일별 시세 — 1년치 244거래일 | 상세 |

## 주의

- **실시간 시세(2번) 응답은 EUC-KR입니다.** 저장할 때 UTF-8로 변환했습니다.
  실제 네트워크 코드에서는 디코딩 처리가 필요합니다.
- **일별 시세는 문서의 4번 endpoint가 아닙니다.**
  `https://finance.naver.com/item/sise_day.naver` 는 현재 HTTP 410을 반환하며
  "이 페이지는 더 이상 제공되지 않습니다" 안내가 내려옵니다.
  대신 `https://api.stock.naver.com/chart/domestic/item/{symbol}/day` 를 사용했고,
  반환 필드는 문서가 요구한 이름(`localDate`, `closePrice`, `openPrice`,
  `highPrice`, `lowPrice`, `accumulatedTradingVolume`)과 동일합니다.
- 수집 시점 기준으로 5종목 중 **보합(0.00%) 케이스가 없습니다.**
  보합 표시를 확인하려면 `realtime_quotes.json`에서 한 종목의 `nv`를 `pcv`와
  같게 고쳐서 테스트하면 됩니다.

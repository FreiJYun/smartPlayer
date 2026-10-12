# SmartPlayer v0.3 — PC·모바일 무료 동기화 준비

현재 재생에 성공한 `index.html`(v0.2)은 **수정하지 않았습니다**. GitHub Pages에 `SmartPlayer_v0.3_preview.html`이라는 시험용 페이지를 별도로 배포했습니다.

## 1. Supabase 무료 프로젝트 만들기

1. https://supabase.com/dashboard 에 로그인합니다.
2. `New project`를 선택하고 Free 플랜 프로젝트를 만듭니다. 저장소 비밀번호(DB Password)는 절대 채팅이나 GitHub에 올리지 마세요.
3. 프로젝트에서 **SQL Editor**를 열고 `SmartPlayer_v0.3_Supabase_setup.sql`의 전체 내용을 붙여 넣어 실행합니다. 이 SQL은 본인의 음악 데이터만 접근 가능한 RLS 정책을 만듭니다.
4. 프로젝트의 `Connect` 대화상자 또는 `Project Settings → API Keys`에서 **Project URL**과 **publishable key**(`sb_publishable_...`, 예전 프로젝트라면 `anon` 키)를 확인합니다.
5. `service_role`, `sb_secret_...`, Database Password는 절대 웹페이지·GitHub·채팅에 입력하지 마세요.

## 2. SmartPlayer에서 연결

1. `https://freijyun.github.io/smartPlayer/SmartPlayer_v0.3_preview.html` 에 접속합니다.
2. 상단 **☁ 동기화**를 눌러 Project URL과 publishable key를 넣고 `연결 정보 저장`을 누릅니다.
3. 최초 1회 **회원가입** 후, 이메일 확인 메일이 오면 인증합니다. 인증 링크가 Supabase 기본 URL로 이동하더라도, SmartPlayer 페이지로 돌아와 로그인하면 됩니다. 이메일 확인 설정에 따라 바로 로그인할 수도 있습니다.
4. 같은 이메일/비밀번호로 PC와 Android 양쪽에서 로그인합니다.
5. 첫 동기화 때 기존 브라우저의 음악을 클라우드와 합칠지 확인을 요구합니다. **먼저 백업**해 두기를 권장합니다.

## 3. 무엇을 공유하나요?

- YouTube 영상 ID, 곡 제목, 아티스트, 작곡가, 장르/무드 태그, 등록된 커버·아티스트 사진(축소된 데이터 URL), 가사/LRC, 삭제 기록.
- 실제 YouTube 영상 파일이나 YouTube Premium 계정 정보는 복사·저장하지 않습니다.
- 개별 브라우저의 로그인 정보와 Supabase publishable key는 해당 브라우저에 저장됩니다. GitHub에는 업로드하지 않습니다.
- *주의*: 원본 사진 데이터가 많이 쌓이면 브라우저 저장 용량 및 Supabase 무료 데이터베이스 용량 한도에 도달할 수 있습니다. 추후 사진을 Supabase Storage로 분리할 수 있습니다.

## 4. 동기화와 충돌 처리

- 음악을 등록·수정·삭제한 뒤 자동으로 클라우드에 기록합니다. 열린 웹페이지는 약 30초마다 다른 기기의 변경사항을 확인합니다.
- 같은 곡이 양쪽에서 수정됐다면 수정 시간이 최신인 것을 선택합니다. 휴대전화/PC 시계가 크게 다르면 순서가 꼬일 수 있으므로 시간 자동 설정을 사용하세요.
- SQL의 `revision` 비교로 동시에 변경된 전체 라이브러리의 덮어쓰기를 감지하고 재시도합니다. 여러 기기에서 **동일 곡을 동시에 편집하는 작업은 피하세요**.
- 클라우드 장애 시 로컬 음악은 계속 남고 다음 연결 시 재시도합니다. 중요한 변경 전에는 JSON 백업을 만들어 두세요.

## 5. 보안

- 저장소가 Public이어도 음악 데이터는 RLS 정책으로 사용자별 격리됩니다.
- 회원가입을 본인 계정으로 마친 후 Supabase Dashboard의 Authentication 설정에서 `Allow new users to sign up`을 끌 수 있습니다. (다른 사람이 본인 데이터에 접근하지 못하도록 하는 핵심 보호는 회원가입 차단이 아닌 RLS입니다.)
- 가사·사진에 대해서는 저장하거나 공유할 권리를 직접 확인하세요.
- Supabase 무료 플랜의 비활성 프로젝트 일시 중지 등 제약은 공식 문서를 따릅니다.
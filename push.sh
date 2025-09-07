#!/bin/bash

# 현재 브랜치 확인
current_branch=$(git branch --show-current)

# main 브랜치인지 확인
if [ "$current_branch" = "main" ]; then
    echo "❌ 오류: main 브랜치에서는 이 스크립트를 실행할 수 없습니다."
    echo "다른 브랜치로 전환한 후 다시 시도해주세요."
    exit 1
fi

echo "🔍 현재 브랜치: $current_branch"

# Git 상태 확인
echo "📋 현재 Git 상태:"
git status --short

# 사용자 확인
echo ""
read -p "모든 변경사항을 커밋하고 푸시하시겠습니까? (y/N): " confirm

# 사용자 입력 확인 (기본값은 N)
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "❌ 취소되었습니다."
    exit 0
fi

# 현재 날짜와 시간으로 커밋 메시지 자동 생성
commit_message="$(date '+%Y-%m-%d %H:%M:%S') by push.sh"
echo "📝 커밋 메시지: $commit_message"

echo ""
echo "🚀 작업을 시작합니다..."

# 모든 파일 추가
echo "📁 모든 변경사항 추가 중..."
git add .

# 변경사항이 있는지 확인
if git diff --staged --quiet; then
    echo "ℹ️  커밋할 변경사항이 없습니다."
    exit 0
fi

# 커밋 실행
echo "💾 커밋 생성 중..."
if git commit -m "$commit_message"; then
    echo "✅ 커밋이 성공적으로 생성되었습니다."
else
    echo "❌ 커밋 생성에 실패했습니다."
    exit 1
fi

# 푸시 실행
echo "📤 원격 저장소로 푸시 중..."
if git push origin "$current_branch"; then
    echo "✅ 푸시가 성공적으로 완료되었습니다!"
    echo "🎉 브랜치 '$current_branch'가 원격 저장소에 업데이트되었습니다."
else
    echo "❌ 푸시에 실패했습니다."
    echo "원격 저장소 연결 상태를 확인해주세요."
    exit 1
fi
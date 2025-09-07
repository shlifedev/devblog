#!/bin/bash

# 현재 브랜치 이름을 가져옵니다.
current_branch=$(git symbolic-ref --short HEAD)

if [ -z "$current_branch" ]; then
  echo "오류: 현재 브랜치 이름을 확인할 수 없습니다."
  exit 1
fi

echo "현재 브랜치: $current_branch"

# main 브랜치로 전환합니다.
echo "main 브랜치로 전환합니다..."
git checkout main

if [ $? -ne 0 ]; then
  echo "오류: main 브랜치로 전환하지 못했습니다."
  git checkout "$current_branch"
  exit 1
fi

# 현재 브랜치를 main에 병합합니다.
echo "'$current_branch' 브랜치를 'main' 브랜치로 병합합니다..."
git merge "$current_branch"

if [ $? -ne 0 ]; then
  echo "오류: 브랜치 병합에 실패했습니다."
  # 병합 실패 시 원래 브랜치로 돌아갑니다.
  git checkout "$current_branch"
  exit 1
fi

# main 브랜치를 원격 저장소에 푸시합니다.
echo "'main' 브랜치를 원격 저장소에 푸시합니다..."
git push origin main

if [ $? -ne 0 ]; then
  echo "오류: 원격 저장소에 푸시하지 못했습니다."
  exit 1
fi

echo "성공적으로 main 브랜치에 병합하고 푸시했습니다."

# 원래 브랜치로 다시 전환합니다.
echo "원래 브랜치 '$current_branch'(으)로 다시 전환합니다."
git checkout "$current_branch"

exit 0

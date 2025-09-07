# 테마 업데이트 스크립트
# 처음에 pull 한 후에 실행 필요

# 나중에 hugo modules 로 변경 고려
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
git submodule update --init --recursive # needed when you reclone your repo (submodules may not get cloned automatically)
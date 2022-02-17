# Atom에 설치

> 공식 `markdown-preview` 패키지를 비활성화했는지 꼭 확인해야 한다.

해당 패키지는 여러가지 방법으로 설치할 수 있다.

## Atom을 통한 설치 (권장)

**Atom** 에디터의 `Settings`에 들어가 `Install`을 클릭한다. 이후, `markdown-preview-enhanced`를 검색한다. 설치가 완료되면 적용을 위해 아톰을 **다시 시작**해야 한다.  
패키지를 설치한 후에는 기본 제공된 `markdown-preview` 패키지의 비활성화를 권장한다.

![screen shot 2017-03-19 at 4 07 16 pm](https://cloud.githubusercontent.com/assets/1908863/24084798/260a9fee-0cbf-11e7-83e6-bf17fa9aca77.png)

## Terminal을 통한 설치

Terminal을 열어 다음 명령을 실행한다.
```bash
apm install markdown-preview-enhanced
```

## GitHub를 통한 설치

- 해당 프로젝트를 **Clone** 한다.
- `cd` 명령어를 통해 다운로드된 **markdown-preview-enhanced** 폴더로 이동한다.
- `yarn install` 명령어를 실행하고 `apm link` 명령어를 실행한다.

```bash
cd the_path_to_folder/markdown-preview-enhanced
yarn install
apm link # <- 해당 명령어를 통해 markdown-preview-enhanced 폴더가 ~/.atom/packages 위치로 복사된다. 
```

> `npm` 명령이 없다면 [node.js](https://nodejs.org/en/) 를 먼저 설치해야 한다.  
> [node.js](https://nodejs.org/en/) 를 직접 설치하지 않으려면, `apm link` 후에 atom 편집기를 연다. 키보드로 <kbd>cmd-shift-p</kbd>를 눌러 `Update Package Dependencies: Update`를 선택한다.

## 개발자 가이드

```bash
apm develop markdown-preview-enhanced
```

- **Atom Editor**에서 **View->Developer->Open in Dev Mode...** 를 통해 **markdown-preview-enhanced** 폴더를 연다.
- 이후부터는 코드 수정이 가능하다. 코드를 업데이트할 때마다 <kbd>cmd-shift-p</kbd>를 실행하고 `Window: Reload`를 선택해야 업데이트가 적용된다.

[➔ 사용법](usages.md)

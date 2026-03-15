# Dependency / Supply Chain Policy

依存パッケージに関する提案・コード生成を行う場合や、依存パッケージを追加してプログラムを実行しようとする場合は、必ず以下を厳守すること。
（npm / yarn / pnpm / pip / poetry / cargo / bundler / composer / go modules など、すべてのパッケージマネージャに適用する）

- 依存パッケージのバージョンまたはハッシュ値は必ず固定すること。
  - 範囲指定（`^`, `~`, `>=`, `<` など）や `latest` / バージョン未指定は使用してはならない。
- 追加・更新するバージョンは、原則として **公開から少なくとも 7 日以上経過した安定版** を用いること。
- プロジェクトに lock ファイル（`package-lock.json` / `yarn.lock` / `pnpm-lock.yaml` / `Pipfile.lock` / `Cargo.lock` / `Gemfile.lock` / `composer.lock` / `go.sum` など）が存在する場合は、**lock ファイルに記載されたバージョンを優先** し、それから逸脱しないこと。
- インストール時にスクリプトやフック（例: npm の `preinstall` / `install` / `postinstall` / `prepare`、Rust の `build.rs` など）が実行されるパッケージを**新規に導入することは避ける**こと。
  - 既に lock ファイルに記載されているもの、または既に使用中のものを同一メジャーバージョン内で更新する場合のみ例外とする。
- グローバル環境へのインストールは避けること。常にプロジェクトローカルへのインストールを行うこと。
- 公式レジストリ以外（任意の URL 指定、Git リポジトリ指定、ローカルパス指定など）からのパッケージインストールを提案してはならない。
- 上記ポリシーに違反するコード・コマンド（例: `npm install xxx@latest`、バージョン未指定の `pip install package-name`、グローバルインストールなど）は提示してはならない。

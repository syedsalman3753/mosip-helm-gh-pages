# Helm Publisher

A GitHub Action for publishing Helm charts with Github Pages.

## Usage

Inputs:
* `token` The GitHub token with write access to the target repository
* `charts_dir` The charts directory, defaults to `charts`
* `charts_url` The GitHub Pages URL, defaults to `https://<OWNER>.github.io/<REPOSITORY>`
* `owner` The GitHub user or org that owns this repository, defaults to the owner in `GITHUB_REPOSITORY` env var
* `repository` The GitHub repository, defaults to the `GITHUB_REPOSITORY` env var
* `branch` The branch to publish charts, defaults to `gh-pages`
* `target_dir` The target directory to store the charts, defaults to `.`
* `helm_version` The Helm CLI version, defaults to the latest release
* `linting` Toggle Helm linting, can be disabled by setting it to `off`
* `commit_username` Explicitly specify username for commit back, default to `GITHUB_ACTOR`
* `commit_email` Explicitly specify email for commit back, default to `GITHUB_ACTOR@users.noreply.github.com`
* `app_version` Explicitly specify app version in package. If not defined then used chart values.
* `chart_version` Explicitly specify chart version in package. If not defined then used chart values.
* `index_dir` The location of `index.yaml` file in the repo, defaults to the same value as `target_dir`
* `enterprise_url` The URL of enterprise GitHub server in the format `<server-url>/<organisation>`
* `dependencies` A list of helm repositories required to verify dependencies in the format `<name>,<url>;<name>,<url>` or if using private repositories `<name>,<username>,<password>,<url>;<name>,<username>,<password>,<url>`. Combinations are allowed.
* `ignore_charts`: "Ignore the charts present in <charts_dir>, provide the list of chart_names separated by pipe (|), default: ''".
* `chart_publish`: "Toggle Helm chart publish (YES/NO), can be disabled by setting it to 'YES', default: 'YES'".
* `linting`: "Toggle Helm linting (YES/NO), can be disabled by setting it to 'NO', default: 'YES'".
* `linting_health_check_schema_yaml_url`: "The URL contains health check schema yaml file to validate charts containing Deployments or Statefulset, default: 'https://raw.githubusercontent.com/mosip/kattu/master/.github/helm-lint-configs/health-check-schema.yaml'".
* `linting_chart_schema_yaml_url`: "The URL contains `Chart.yaml` schema yaml file to validate `Chart.yaml` file present in helm charts, default: 'https://raw.githubusercontent.com/mosip/kattu/master/.github/helm-lint-configs/chart-schema.yaml'".
* `linting_lintconf_yaml_url`: "The URL contains Helm lint configuration yaml to validate helm charts yaml files, default: 'https://raw.githubusercontent.com/mosip/kattu/master/.github/helm-lint-configs/lintconf.yaml'".
* `linting_chart_testing_config_yaml_url`: "The URL contains helm-chart-testing configuration yaml file to validate `chart-yaml-schema` & `lint-configuration`, default: 'https://raw.githubusercontent.com/mosip/kattu/master/.github/helm-lint-configs/chart-testing-config.yaml'".

## Examples

Package and push all charts in `./charts` dir to `gh-pages` branch:

```yaml
name: release
on:
  push:
    tags: '*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Publish Helm charts
        uses: stefanprodan/helm-gh-pages@master
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
```

Package and push charts in `./chart` dir to `gh-pages` branch in a different repository:

```yaml
name: release-chart
on:
  push:
    tags: 'chart-*'

jobs:
  release-chart:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Publish Helm chart
        uses: mosip/helm-gh-pages@master
        with:
          token: ${{ secrets.BOT_GITHUB_TOKEN }}
          charts_dir: chart
          charts_url: https://charts.fluxcd.io
          owner: fluxcd
          repository: charts
          branch: gh-pages
          target_dir: charts
          commit_username: johndoe
          commit_email: johndoe@example.com
```
Package chart with specified chart & app versions and push all charts in `./charts` dir to `gh-pages` branch:
```yaml
name: release
on:
  push:
    tags: '*'

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Publish Helm charts
        uses: stefanprodan/helm-gh-pages@master
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          app_version: 1.16.0
          chart_version: 0.1.0
```

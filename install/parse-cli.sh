echo "${_group}Parsing command line ..."

show_help() {
  cat <<EOF
Usage: $0 [options]

Install Sentry with \`docker compose\`.

Options:
 -h, --help                 Show this message and exit.
 --minimize-downtime        EXPERIMENTAL: try to keep accepting events for as long
                              as possible while upgrading. This will disable cleanup
                              on error, and might leave your installation in a
                              partially upgraded state. This option might not reload
                              all configuration, and is only meant for in-place
                              upgrades.
 --skip-commit-check        Skip the check for the latest commit when on the master
                              branch of a \`self-hosted\` Git working copy.
 --skip-user-prompt         Skip the initial user creation prompt (ideal for non-
                              interactive installs).
 --report-errors=(yes|no)   Allow Sentry (the organization) to collect error reports
                              from running this installer. We may collect OS username,
                              IP addres, the install log, and performance data. We may
                              retain this information for up to 30 days. Please see
                              our privacy policy at https://sentry.io/privacy.
EOF
}

SKIP_USER_PROMPT="${SKIP_USER_PROMPT:-}"
MINIMIZE_DOWNTIME="${MINIMIZE_DOWNTIME:-}"
SKIP_COMMIT_CHECK="${SKIP_COMMIT_CHECK:-}"
REPORT_ERRORS="${REPORT_ERRORS:-}"

while (( $# )); do
  case "$1" in
    -h | --help) show_help; exit;;
    --no-user-prompt) SKIP_USER_PROMPT=1;;  # deprecated
    --skip-user-prompt) SKIP_USER_PROMPT=1;;
    --minimize-downtime) MINIMIZE_DOWNTIME=1;;
    --skip-commit-check) SKIP_COMMIT_CHECK=1;;
    --report-errors=*) REPORT_ERRORS=$(parse_yes_no "${1#*=}");;
    --) ;;
    *) echo "Unexpected argument: $1. Use --help for usage information."; exit 1;;
  esac
  shift
done

echo "${_endgroup}"

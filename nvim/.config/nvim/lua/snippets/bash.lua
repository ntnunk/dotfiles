local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

return {
  -- Shebang
  s("shebang", {
    t("#!/bin/bash"),
  }),
  
  -- Basic function
  s("func", {
    t("function "), i(1, "name"), t("() {"),
    t({"", "    "}), i(0),
    t({"", "}"}),
  }),

  -- Function with parameters
  s("funcparams", {
    t("function "), i(1, "name"), t("() {"),
    t({"", "    local "}), i(2, "param1"), t("=\"$1\""),
    t({"", "    local "}), i(3, "param2"), t("=\"$2\""),
    t({"", "    "}), i(0),
    t({"", "}"}),
  }),

  -- If statement
  s("if", {
    t("if [[ "), i(1, "condition"), t(" ]]; then"),
    t({"", "    "}), i(0),
    t({"", "fi"}),
  }),

  -- If-else statement
  s("ifelse", {
    t("if [[ "), i(1, "condition"), t(" ]]; then"),
    t({"", "    "}), i(2),
    t({"", "else"}),
    t({"", "    "}), i(0),
    t({"", "fi"}),
  }),

  -- If-elif-else statement
  s("ifelif", {
    t("if [[ "), i(1, "condition1"), t(" ]]; then"),
    t({"", "    "}), i(2),
    t({"", "elif [[ "}), i(3, "condition2"), t(" ]]; then"),
    t({"", "    "}), i(4),
    t({"", "else"}),
    t({"", "    "}), i(0),
    t({"", "fi"}),
  }),

  -- For loop
  s("for", {
    t("for "), i(1, "item"), t(" in "), i(2, "${array[@]}"), t("; do"),
    t({"", "    "}), i(0),
    t({"", "done"}),
  }),

  -- For loop with range
  s("forrange", {
    t("for "), i(1, "i"), t(" in {"), i(2, "1"), t(".."), i(3, "10"), t("}; do"),
    t({"", "    "}), i(0),
    t({"", "done"}),
  }),

  -- While loop
  s("while", {
    t("while [[ "), i(1, "condition"), t(" ]]; do"),
    t({"", "    "}), i(0),
    t({"", "done"}),
  }),

  -- Case statement
  s("case", {
    t("case "), i(1, "$variable"), t(" in"),
    t({"", "    "}), i(2, "pattern1"), t(")"),
    t({"", "        "}), i(3, "command1"),
    t({"", "        ;;"}),
    t({"", "    "}), i(4, "pattern2"), t(")"),
    t({"", "        "}), i(5, "command2"),
    t({"", "        ;;"}),
    t({"", "    *)"}),
    t({"", "        "}), i(0, "default_command"),
    t({"", "        ;;"}),
    t({"", "esac"}),
  }),

  -- Array declaration
  s("array", {
    t("declare -a "), i(1, "array_name"), t("=("), i(0, "\"item1\" \"item2\" \"item3\""), t(")"),
  }),

  -- Associative array
  s("assoc", {
    t("declare -A "), i(1, "assoc_array"), t("=("),
    t({"", "    ["}), i(2, "key1"), t("]="), i(3, "\"value1\""),
    t({"", "    ["}), i(4, "key2"), t("]="), i(5, "\"value2\""),
    t({"", "}"}), i(0),
  }),

  -- Variable with default
  s("vardefault", {
    i(1, "variable"), t("=${"), i(2, "parameter"), t(":-"), i(0, "default_value"), t("}"),
  }),

  -- File test conditions
  s("filetest", {
    t("[[ -"), c(1, {
      t("e"), t("f"), t("d"), t("r"), t("w"), t("x"), t("s")
    }), t(" "), i(0, "filename"), t(" ]]"),
  }),

  -- String test conditions
  s("stringtest", {
    t("[[ "), c(1, {
      t("-z"), t("-n")
    }), t(" "), i(0, "$string"), t(" ]]"),
  }),

  -- Numeric comparison
  s("numtest", {
    t("[[ $"), i(1, "num1"), t(" -"), c(2, {
      t("eq"), t("ne"), t("lt"), t("le"), t("gt"), t("ge")
    }), t(" $"), i(0, "num2"), t(" ]]"),
  }),

  -- Error handling
  s("errexit", {
    t("set -euo pipefail"),
  }),

  -- Trap for cleanup
  s("trap", {
    t("trap '"), i(1, "cleanup_function"), t("' EXIT"),
    t({"", ""}), i(0),
  }),

  -- Read user input
  s("read", {
    t("read -p \""), i(1, "Enter value"), t(": \" "), i(0, "variable"),
  }),

  -- Command line argument parsing
  s("argparse", {
    t("while [[ $# -gt 0 ]]; do"),
    t({"", "    case $1 in"}),
    t({"", "        -h|--help)"}),
    t({"", "            "}), i(1, "show_help"),
    t({"", "            exit 0"}),
    t({"", "            ;;"}),
    t({"", "        -v|--verbose)"}),
    t({"", "            "}), i(2, "VERBOSE=true"),
    t({"", "            shift"}),
    t({"", "            ;;"}),
    t({"", "        -*)"}),
    t({"", "            echo \"Unknown option $1\""}),
    t({"", "            exit 1"}),
    t({"", "            ;;"}),
    t({"", "        *)"}),
    t({"", "            "}), i(0, "POSITIONAL_ARGS+=(\"$1\")"),
    t({"", "            shift"}),
    t({"", "            ;;"}),
    t({"", "    esac"}),
    t({"", "done"}),
  }),

  -- Logging functions
  s("log", {
    t("log() {"),
    t({"", "    echo \"[$(date +'%Y-%m-%d %H:%M:%S')] $*\" >&2"}),
    t({"", "}"}),
    t({"", ""}), i(0),
  }),

  -- Error logging
  s("error", {
    t("error() {"),
    t({"", "    echo \"ERROR: $*\" >&2"}),
    t({"", "    exit 1"}),
    t({"", "}"}),
    t({"", ""}), i(0),
  }),

  -- Check if command exists
  s("cmdexists", {
    t("command -v "), i(1, "command_name"), t(" >/dev/null 2>&1 || { echo \""), rep(1), t(" is required but not installed.\" >&2; exit 1; }"),
    t({"", ""}), i(0),
  }),

  -- Source file if exists
  s("sourceif", {
    t("[[ -f "), i(1, "filename"), t(" ]] && source "), rep(1),
    t({"", ""}), i(0),
  }),

  -- Create directory if not exists
  s("mkdirp", {
    t("[[ ! -d "), i(1, "directory"), t(" ]] && mkdir -p "), rep(1),
    t({"", ""}), i(0),
  }),

  -- Process substitution
  s("procsub", {
    t("while IFS= read -r "), i(1, "line"), t("; do"),
    t({"", "    "}), i(2, "process $line"),
    t({"", "done < <("}), i(0, "command"), t(")"),
  }),

  -- Here document
  s("heredoc", {
    t("cat << '"), i(1, "EOF"), t("'"),
    t({"", ""}), i(0, "content"),
    t({"", ""}), rep(1),
  }),

  -- Background job with wait
  s("background", {
    i(1, "command"), t(" &"),
    t({"", "PID=$!"}),
    t({"", "wait $PID"}),
    t({"", ""}), i(0),
  }),

  -- Temporary file/directory
  s("tmpfile", {
    i(1, "TMPFILE"), t("=$(mktemp)"),
    t({"", "trap 'rm -f \"$"}), rep(1), t("\"' EXIT"),
    t({"", ""}), i(0),
  }),

  s("tmpdir", {
    i(1, "TMPDIR"), t("=$(mktemp -d)"),
    t({"", "trap 'rm -rf \"$"}), rep(1), t("\"' EXIT"),
    t({"", ""}), i(0),
  }),
}

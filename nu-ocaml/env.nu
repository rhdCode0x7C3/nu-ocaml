# src/env.nu
# Manage OPAM environment variables in Nushell

# Parse opam env output into a table of environment variables
def parse-env [] {
    ^opam env
        | lines
        | where $it != is-empty
        | split column "=" name value
        | update value {split column ";" path | get path.0 | str trim -c "'"}
    | update value {|it| if ($it.value | str contains ":") {$it.value | split row ":"} else {$it.value}}
    | reduce -f {} {|it acc| $acc | insert $it.name $it.value}
}

# Load opam environment variables into the current environment
    export def --env main [] {
        parse-env | load-env
    }

# Preview environment settings without applying
    export def "env show" [] {
        parse-env
    }

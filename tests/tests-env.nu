# tests/tests-env.nu
# Test suite for nu-ocaml/env.nu

use ../nu-ocaml/env.nu
use std assert

const dirs = [ 
    "OPAM_LAST_ENV"
    "OPAM_SWITCH_PREFIX"
    "CAML_LD_LIBRARY_PATH"
    "OCAML_TOPLEVEL_PATH"
    "PATH"
]

export def test-env-show [] {
    assert equal (env env show | columns) $dirs
}

export def test-env [] {
    env 
    for dir in $dirs {
        echo $dir
        assert equal ($dir in $env) true
    }
}

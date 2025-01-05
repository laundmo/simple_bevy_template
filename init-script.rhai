let os_arch = variable::get("os-arch");
let is_linux = os_arch.contains("linux");
let is_mac = os_arch.contains("macos");

variable::set("skip_config", false);

// assume all options are false until accepted
variable::set("use_mold", false);
variable::set("use_nightly", false);
variable::set("use_cranelift", false);
variable::set("use_parallel_frontend", false);

let skip_config = variable::prompt("Skip generating cargo/toolchain config? (expert only)", false);
variable::set("skip_config", skip_config);

if !skip_config {
    if is_linux {
        let use_mold = variable::prompt("Use mold linker?", true);

        if use_mold {
            try {
                system::command("which", ["mold", "clang"]);
            } catch {
                abort("You enabled 'mold' linker but do not have it installed. Install 'mold' and 'clang' from your system package manager. ")
            }
        }
        variable::set("use_mold", use_mold);
    }

    let use_nightly = variable::prompt("Use nightly (faster compiles)?", true);
    variable::set("use_nightly", use_nightly);
    
    if use_nightly {
        print("Cheking/Installing nightly Rust, please be patient!");
        try {
            system::command("rustup", ["toolchain", "install", "nightly"]);
        } catch {
            abort("Failed to run command `rustup toolchain install nightly` - run it manually to test!");
        }

        if is_linux || is_mac {
            let use_cranelift = variable::prompt("Use cranelift for faster compiles?", true);
            variable::set("use_cranelift", use_cranelift);
            if use_cranelift {
                print("Checking/Installing cranelift component, please be patient!");
                try {
                    system::command("rustup", ["component","add","rustc-codegen-cranelift-preview","--toolchain","nightly"]);
                } catch {
                    abort("Failed to run command `rustup component add rustc-codegen-cranelift-preview --toolchain nightly` - run it manually to test!");
                }
            }
        }

        let use_parallel_frontend = variable::prompt("Use parallel frontend for faster compiles?", true);
        variable::set("use_parallel_frontend", use_parallel_frontend);
    }

}

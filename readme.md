# Basic Bevy template
Basic Bevy project template to get started quickly.

Use this template with:
```bash
cargo generate laundmo/simple_bevy_template
```

Prerequesites for cranelift:
```bash
rustup toolchain install nightly
rustup component add rustc-codegen-cranelift-preview --toolchain nightly
```

- Always uses Mold on linux, you need it installed (!!)
- Optional Nightly Rust
  - Generics Sharing
  - Cranelift and Parallel frontend configurable
- Bacon for running on save
- KDE Window Rule for always on top without focus stealing
  - Import .kwinrule in the KDE "Window Rules" settings
  - Move window and detect properties, then click on checkmark for position and size to adjust to your screen layout
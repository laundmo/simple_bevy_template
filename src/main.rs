use bevy::prelude::*;

fn main() {
    App::new()
        .insert_resource(ClearColor(Color::srgba(0., 0., 0., 0.1)))
        .add_plugins(DefaultPlugins.set(WindowPlugin {
            primary_window: Some(Window {
                name: "bevy.app".to_string().into(),
                ..default()
            }),
            ..default()
        }))
        .add_systems(Startup, setup)
        .run();
}

fn setup(mut commands: Commands) {
    commands.spawn(Camera2d);
}

use image::{imageops, load_from_memory, GenericImageView, ImageFormat};
use std::io::Cursor;

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

type OverlayTexture = (
    Vec<u8>,     // overlay
    Option<i64>, // x
    Option<i64>, // y
    Option<u32>, // width
    Option<u32>, // height
);

pub fn add_overlay(background: Vec<u8>, texture: OverlayTexture) -> Vec<u8> {
    // Load the background and overlay images
    let mut bg_img = load_from_memory(&background).expect("Failed to decode background");
    let mut ol_img = load_from_memory(&texture.0).expect("Failed to decode overlay");

    // Calculate the size of the ol_img
    let (ol_width, ol_height) = ol_img.dimensions();

    // Resize the overlay image if necessary
    if texture.3.is_some() || texture.4.is_some() {
        let width = texture.3.unwrap_or(ol_width);
        let height = texture.4.unwrap_or(ol_height);
        ol_img = ol_img.resize(width, height, imageops::FilterType::Lanczos3);
    }

    // Overlay the images
    imageops::overlay(
        &mut bg_img,
        &ol_img,
        texture.1.unwrap_or(0),
        texture.2.unwrap_or(0),
    );

    // Create a buffer to hold the output image
    let mut output = Vec::new();

    // Save the overlaid image back to the buffer in PNG format
    bg_img
        .write_to(&mut Cursor::new(&mut output), ImageFormat::Png)
        .expect("Failed to encode image");

    // Return the buffer containing the overlaid image
    output
}

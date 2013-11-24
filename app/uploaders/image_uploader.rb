# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  version :large do
    process :resize_to_fill => [800, 800]
    process :rotate
    process :caption
  end
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
#    process :scale => [50, 50]
    process :resize_to_fill => [200,200]
#    process :resize_to_fit => [150, 220]
    process :rotate
  end

  version :small_thumb do
    process :resize_to_fill => [50, 50]
#    process :resize_to_fit => [150, 220]
    process :rotate
  end

  version :logo_icon do
    process :resize_to_fill => [30, 30]
#    process :resize_to_fit => [150, 220]
    process :rotate
  end

  def caption
    if model.class.name == "Picture" and model.imageable_type == "Bodycomp"
      # top right caption
      manipulate! do |source|
    #        img = Picture.last #picture that was just created
        txt = Magick::Draw.new
        txt.pointsize = 20
        txt.font_family = "Impact"
        txt.gravity = Magick::NorthEastGravity
        txt.stroke = "#000000"
        txt.fill = "#F3F315"
        txt.font_weight = Magick::BoldWeight
        caption = "Date: #{model.imageable.date.strftime("%m-%d-%Y")} \\r
                  Body Fat: #{model.imageable.bodyfat_percent.round(1)}% \\r
                  Lean: #{model.imageable.lean_mass.round} lb \\r
                  Fat: #{model.imageable.fat_mass.round} lb"
    #        source = source.resize_to_fill(400, 400).border(10, 10, "black")
        source = source.resize_to_fill(640, 480)
        source.annotate(txt, 0, 0, 0, 20, caption)
      end
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def rotate
    manipulate! do |image|
      image.auto_orient
    end
  end

end

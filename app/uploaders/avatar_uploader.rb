# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    '/tmp/3b-cache'
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    asset_path([version_name, "no_avatar.png"].compact.join('_'))
  end

  # Process files as they are uploaded:
  process :scale => [100, 100]
  #
  def scale(width, height)
    # do something
  end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_limit: [85, 85]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end

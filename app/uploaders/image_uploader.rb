class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "uploads/tmp/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    # ActionController::Base.helpers.asset_path("missing/" + [version_name, "image.png"].compact.join('_'))
    "/static/images/missing/" + [version_name, "image.png"].compact.join('_')
  end

  version :thumb do
    process resize_to_limit: [200, 200]
  end

  version :select do
    process resize_to_limit: [40, 40]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end

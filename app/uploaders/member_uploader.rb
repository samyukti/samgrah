class MemberUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "#{Rails.root}/files/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cache_dir
    "#{Rails.root}/tmp/files/cache/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    # ActionController::Base.helpers.asset_path("missing/" + [version_name, "member.png"].compact.join('_'))
    "#{Rails.root}/public/static/images/missing/" + [version_name, "member.png"].compact.join('_')
  end

  version :thumb do
    process resize_to_limit: [200, 200]
  end

  version :select do
    process resize_to_limit: [50, 50]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end
end

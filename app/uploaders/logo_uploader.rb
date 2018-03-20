class LogoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.upload.logo_width, Settings.upload.logo_height]

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def default_url *args
    ActionController::Base.helpers.asset_path([version_name, "logodefault.png"].compact.join("_"))
  end
end

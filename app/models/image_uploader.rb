require "image_processing/mini_magick"

class ImageUploader < Shrine
  # plugins and uploading logic

  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions
  plugin :delete_raw


  process(:store) do |io, context|
    original = io.download

    size_800 = resize_to_limit!(original, 800, 800) { |cmd| cmd.auto_orient }
    size_500 = resize_to_limit(size_800,  500, 500)
    size_300 = resize_to_limit(size_500,  300, 300)
    size_50  = resize_to_limit(size_300,  50, 50)

    {original: io, large: size_800, medium: size_500, small: size_300, thumbnail: size_50}
  end
end

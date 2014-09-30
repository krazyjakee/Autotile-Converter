gd = require('node-gd')
input_file = "tileset.png"
new_image = false
old_image = false

processAce = (offsetX, offsetY) ->
  newOffsetX = offsetX + (offsetX / 2)
  newOffsetY = offsetY + (offsetY / 3)

  old_image.copyResampled new_image, newOffsetX + 32, newOffsetY + 64, offsetX + 32, offsetY + 64, 16, 16, 16, 16 # mid top left
  old_image.copyResampled new_image, newOffsetX + 32, newOffsetY + 80, offsetX + 32, offsetY + 48, 16, 16, 16, 16 # mid bottom left
  old_image.copyResampled new_image, newOffsetX + 48, newOffsetY + 64, offsetX + 16, offsetY + 64, 16, 16, 16, 16 # mid top right
  old_image.copyResampled new_image, newOffsetX + 48, newOffsetY + 80, offsetX + 16, offsetY + 48, 16, 16, 16, 16 # mid bottom right

  old_image.copyResampled new_image, newOffsetX + 0, newOffsetY + 64, offsetX + 0, offsetY + 64, 16, 16, 16, 16 # left top left
  old_image.copyResampled new_image, newOffsetX + 0, newOffsetY + 80, offsetX + 0, offsetY + 48, 16, 16, 16, 16 # left bottom left
  old_image.copyResampled new_image, newOffsetX + 16, newOffsetY + 64, offsetX + 16, offsetY + 64, 16, 16, 16, 16 # left top right
  old_image.copyResampled new_image, newOffsetX + 16, newOffsetY + 80, offsetX + 16, offsetY + 48, 16, 16, 16, 16 # left bottom right

  old_image.copyResampled new_image, newOffsetX + 64, newOffsetY + 64, offsetX + 32, offsetY + 64, 16, 16, 16, 16 # right top left
  old_image.copyResampled new_image, newOffsetX + 64, newOffsetY + 80, offsetX + 32, offsetY + 48, 16, 16, 16, 16 # right bottom left
  old_image.copyResampled new_image, newOffsetX + 80, newOffsetY + 64, offsetX + 48, offsetY + 64, 16, 16, 16, 16 # right top right
  old_image.copyResampled new_image, newOffsetX + 80, newOffsetY + 80, offsetX + 48, offsetY + 48, 16, 16, 16, 16 # right bottom right

  old_image.copyResampled new_image, newOffsetX + 32, newOffsetY + 32, offsetX + 32, offsetY + 32, 16, 16, 16, 16 # top top left
  old_image.copyResampled new_image, newOffsetX + 32, newOffsetY + 48, offsetX + 32, offsetY + 48, 16, 16, 16, 16 # top bottom left
  old_image.copyResampled new_image, newOffsetX + 48, newOffsetY + 32, offsetX + 16, offsetY + 32, 16, 16, 16, 16 # top top right
  old_image.copyResampled new_image, newOffsetX + 48, newOffsetY + 48, offsetX + 16, offsetY + 48, 16, 16, 16, 16 # top bottom right

  old_image.copyResampled new_image, newOffsetX + 32, newOffsetY + 96, offsetX + 32, offsetY + 64, 16, 16, 16, 16 # bottom top left
  old_image.copyResampled new_image, newOffsetX + 32, newOffsetY + 112, offsetX + 32, offsetY + 80, 16, 16, 16, 16 # bottom bottom left
  old_image.copyResampled new_image, newOffsetX + 48, newOffsetY + 96, offsetX + 16, offsetY + 64, 16, 16, 16, 16 # bottom top right
  old_image.copyResampled new_image, newOffsetX + 48, newOffsetY + 112, offsetX + 16, offsetY + 80, 16, 16, 16, 16 # bottom bottom right
  
  # put existing tiles back in
  old_image.copyResampled new_image, newOffsetX + 0, newOffsetY + 0, offsetX + 0, offsetY + 0, 32, 32, 32, 32
  old_image.copyResampled new_image, newOffsetX + 64, newOffsetY + 0, offsetX + 32, offsetY + 0, 32, 32, 32, 32
  old_image.copyResampled new_image, newOffsetX + 0, newOffsetY + 32, offsetX + 0, offsetY + 32, 32, 32, 32, 32
  old_image.copyResampled new_image, newOffsetX + 64, newOffsetY + 32, offsetX + 32, offsetY + 32, 32, 32, 32, 32
  old_image.copyResampled new_image, newOffsetX + 0, newOffsetY + 96, offsetX + 0, offsetY + 64, 32, 32, 32, 32
  old_image.copyResampled new_image, newOffsetX + 64, newOffsetY + 96, offsetX + 32, offsetY + 64, 32, 32, 32, 32

gd.openPng input_file, (err, data) ->
  old_image = data
  cols = data.width / 64
  rows = data.height / 96

  new_image = gd.create (cols * 96), (rows * 128)

  offsetX = 0
  offsetY = -96
  for r in [0..rows]
    offsetY += 96
    offsetX = -64
    for c in [0..cols]
      offsetX += 64
      processAce offsetX, offsetY

  new_image.savePng input_file.replace(".png"," - Fixed.png"), 0, (err) -> console.log "Image saved!"

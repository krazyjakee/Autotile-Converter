gd = require('node-gd')
input_file = "tileset.png"
new_image = false
old_image = false

processSegment = (destX, destY, srcX, srcY) ->
  old_image.copyResampled new_image, destX, destY, srcX, srcY, 16, 16, 16, 16

processTile = (destX, destY, srcX, srcY) ->
  old_image.copyResampled new_image, destX, destY, srcX, srcY, 32, 32, 32, 32

processAce = (offsetX, offsetY) ->
  newOffsetX = offsetX + (offsetX / 2)
  newOffsetY = offsetY + (offsetY / 3)

  processSegment newOffsetX + 32, newOffsetY + 64, offsetX + 32, offsetY + 64 # mid top left
  processSegment newOffsetX + 32, newOffsetY + 80, offsetX + 32, offsetY + 48 # mid bottom left
  processSegment newOffsetX + 48, newOffsetY + 64, offsetX + 16, offsetY + 64 # mid top right
  processSegment newOffsetX + 48, newOffsetY + 80, offsetX + 16, offsetY + 48 # mid bottom right

  processSegment newOffsetX + 0, newOffsetY + 64, offsetX + 0, offsetY + 64 # left top left
  processSegment newOffsetX + 0, newOffsetY + 80, offsetX + 0, offsetY + 48 # left bottom left
  processSegment newOffsetX + 16, newOffsetY + 64, offsetX + 16, offsetY + 64 # left top right
  processSegment newOffsetX + 16, newOffsetY + 80, offsetX + 16, offsetY + 48 # left bottom right

  processSegment newOffsetX + 64, newOffsetY + 64, offsetX + 32, offsetY + 64 # right top left
  processSegment newOffsetX + 64, newOffsetY + 80, offsetX + 32, offsetY + 48 # right bottom left
  processSegment newOffsetX + 80, newOffsetY + 64, offsetX + 48, offsetY + 64 # right top right
  processSegment newOffsetX + 80, newOffsetY + 80, offsetX + 48, offsetY + 48 # right bottom right

  processSegment newOffsetX + 32, newOffsetY + 32, offsetX + 32, offsetY + 32 # top top left
  processSegment newOffsetX + 32, newOffsetY + 48, offsetX + 32, offsetY + 48 # top bottom left
  processSegment newOffsetX + 48, newOffsetY + 32, offsetX + 16, offsetY + 32 # top top right
  processSegment newOffsetX + 48, newOffsetY + 48, offsetX + 16, offsetY + 48 # top bottom right

  processSegment newOffsetX + 32, newOffsetY + 96, offsetX + 32, offsetY + 64 # bottom top left
  processSegment newOffsetX + 32, newOffsetY + 112, offsetX + 32, offsetY + 80 # bottom bottom left
  processSegment newOffsetX + 48, newOffsetY + 96, offsetX + 16, offsetY + 64 # bottom top right
  processSegment newOffsetX + 48, newOffsetY + 112, offsetX + 16, offsetY + 80 # bottom bottom right
  
  # put existing tiles back in
  processTile newOffsetX + 0, newOffsetY + 0, offsetX + 0, offsetY + 0
  processTile newOffsetX + 64, newOffsetY + 0, offsetX + 32, offsetY + 0
  processTile newOffsetX + 0, newOffsetY + 32, offsetX + 0, offsetY + 32
  processTile newOffsetX + 64, newOffsetY + 32, offsetX + 32, offsetY + 32
  processTile newOffsetX + 0, newOffsetY + 96, offsetX + 0, offsetY + 64
  processTile newOffsetX + 64, newOffsetY + 96, offsetX + 32, offsetY + 64

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

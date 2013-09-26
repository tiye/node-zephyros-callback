
z = require './bind.coffee'

do_in_screen = (callback) ->
  z.main_screen (screen_id) ->
    z.send screen_id, 'frame_including_dock_and_menu', (frame) ->
      {w, h} = frame
      round = Math.round
      rect =
        w: w
        w2: round (w / 3)
        w3: round (w / 2)
        w4: round (w / 3 * 2)
        h: h
        h1: round (h / 2)
      callback rect

new_frame = (x, y, w, h) ->
  {x, y, w, h}

divide_x = (key, x, y, w, h) ->
  z.bind key, ['ctrl', 'alt'], ->
    z.alert "ctrl alt #{key}", 0.3
    z.focused_window (window_id) ->
      frame = new_frame x, y, w, h
      z.send window_id, 'set_frame', frame

z.connect port: 1235, ->
  do_in_screen (rect) ->
    {w, w2, w3, w4, h, h1} = rect
    divide_x 'h', 0, 0, w3, h
    divide_x 'j', 0, 0, w4, h
    divide_x 'k', w2, 0, w4, h
    divide_x 'l', w3, 0, w3, h
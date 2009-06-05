def reload_desc
  "reload>: モジュールを読み込み直します"
end

def reload(msg)
  load_plugins
  load_filters
  "reload OK!"
end


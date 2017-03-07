BASE_URI = ENV["firebase_database_url"] + "/"
GAMES_URI = BASE_URI + "/games/"
FB = Firebase::Client.new(BASE_URI)
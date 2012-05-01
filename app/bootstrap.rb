require_relative 'core_ext/hash'

# Controllers
require_relative 'app'
require_relative 'controllers/authentication_controller'
require_relative 'controllers/home_controller'
require_relative 'controllers/decks_controller'

# Models
require_relative '../config/data_mapper'
require_relative 'models/user'
require_relative 'models/token_pair'
require_relative 'models/deck'
require_relative 'models/slide'
DataMapper.finalize
DataMapper.auto_upgrade!

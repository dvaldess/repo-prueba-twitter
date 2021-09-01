class Like < ApplicationRecord
    belongs_to :user #Configuracion de relacion, solo pertenece a un usuario
    belongs_to :tweet #Configuracion de relacion, solo pertenece a un tweet
end

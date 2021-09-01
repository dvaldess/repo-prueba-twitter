class ApplicationController < ActionController::Base
    before_action :configure_sign_up, if: :devise_controller?
    #Con esto evitamos crear el controlador de Users, y seteamos los nuevos atributos que agregamos a la tabla para que el usuario guarde su info
    def configure_sign_up
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :avatar])
    end
end

require 'sinatra'
require 'data_mapper'
#declaracion del modelo
class User
    include DataMapper::Resource  
    property :id       , Serial  
    property :ip       , String  
    property :navegador, Text
    property :server   , String 
    property :rqmet    , String 
    property :ubicacion, String
    property :fecha    , Date
end
DataMapper.finalize
$id=0
get '/' do
	if !params[:ubicacion]  #al principio no se la ubicacion, =>creo el registro
               @user = User.new :ip=>request.ip.to_s, 
				:navegador=> request.env['HTTP_USER_AGENT'].to_s,
				:server=>request.env['SERVER_SOFTWARE'].to_s,
				:rqmet=>request.env['REQUEST_METHOD'].to_s,
				:fecha=>Time.now
   if @user.save
     # si esta bien =>:)
   else
     @user.errors.each do |e|
       puts e
     end
   end

		$id=@user.id    #actualizo el $id
	else
		User.get($id).update(:ubicacion=>params[:ubicacion]) #obtengo el anterior agregado, asi no agrego 2, y actualizo la ubicacion
	end
       @users = User.all(:order => [ :id.asc ],:limit=>5)
 erb :vista
end

class App < Rack::App
  headers 'Content-Type' => 'text/plain; charset=utf8'
  get '/' do
    'Hello'
  end

  get '/metrics' do
    actors = Fritzbox::Smarthome::Heater.all

    actors.map do |actor|
      temp_is  = actor.hkr_temp_is
      temp_set = actor.hkr_temp_set == 126.5 ? 0.0 : actor.hkr_temp_set

      name = actor.name.tr('"', '')
      [
        %Q(temperature_#{actor.type}_is{actor="#{name}"} #{temp_is}),
        %Q(temperature_#{actor.type}_set{actor="#{name}"} #{temp_set})
      ]
    end.flatten.join("\n")
  rescue => e
    Rollbar.error(e)
    raise
  end
end

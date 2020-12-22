class App < Rack::App
  headers 'Content-Type' => 'text/plain; charset=utf8'
  get '/' do
    'Hello'
  end

  get '/metrics' do
    actors = Fritzbox::Smarthome::Actor.all

    actors.map do |actor|
      name = actor.name.tr('"', '')
      [
        %Q(temperature_#{actor.type}_is{actor="#{name}"} #{actor.hkr_temp_is}),
        %Q(temperature_#{actor.type}_set{actor="#{name}"} #{actor.hkr_temp_set})
      ]
    end.flatten.join("\n")
  rescue => e
    Rollbar.error(e)
    raise
  end
end

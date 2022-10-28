module App
  extend self

  def call(env)
    case env['PATH_INFO']
    when '/'
      body = root
      code = 200
    when '/metrics'
      body = metrics
      code = 200
    else
      body = not_found
      code = 404
    end

    [code, headers, [body]]
  end

  private

  def headers
    {
      'Content-Type' => 'text/plain; charset=utf8'
    }
  end

  def root
    'hello world'
  end

  def metrics
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
  end

  def not_found
    'not found'
  end
end

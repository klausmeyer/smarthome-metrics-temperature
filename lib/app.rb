module App
  extend self

  def call(env)
    [200, headers, [body]]
  end

  private

  def headers
    {
      'Content-Type' => 'text/plain; charset=utf8'
    }
  end

  def body
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
end

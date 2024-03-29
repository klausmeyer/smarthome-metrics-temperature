require 'rack/test'

RSpec.describe 'Metrics Endpoint' do
  include Rack::Test::Methods

  let(:app) { App }

  describe 'GET /' do
    subject { get '/' }

    it 'returns with hello world' do
      expect(subject.status).to eq 200
      expect(subject.body).to eq 'hello world'
    end
  end

  describe 'GET /metrics' do
    let(:actor_a) { instance_double('Fritzbox::Smarthome::Heater', type: :device, name: 'Actor A', hkr_temp_is: 22.0, hkr_temp_set: 23.0) }
    let(:actor_b) { instance_double('Fritzbox::Smarthome::Heater', type: :device, name: 'Actor B', hkr_temp_is: 20.0, hkr_temp_set: 18.0) }
    let(:actor_c) { instance_double('Fritzbox::Smarthome::Heater', type: :device, name: 'Actor C', hkr_temp_is: 18.0, hkr_temp_set: 126.5) }

    before do
      allow(Fritzbox::Smarthome::Heater).to receive(:all).and_return([
        actor_a,
        actor_b,
        actor_c,
      ])
    end

    subject { get '/metrics' }

    it 'returns with http 200 ok' do
      expect(subject.status).to eq 200
    end

    it 'returns rows for prometheus' do
      expect(subject.body).to eq <<~TXT.strip
        temperature_device_is{actor="Actor A"} 22.0
        temperature_device_set{actor="Actor A"} 23.0
        temperature_device_is{actor="Actor B"} 20.0
        temperature_device_set{actor="Actor B"} 18.0
        temperature_device_is{actor="Actor C"} 18.0
        temperature_device_set{actor="Actor C"} 0.0
      TXT
    end
  end

  describe 'GET /unknown' do
    subject { get '/unknown' }

    it 'returns with hello world' do
      expect(subject.status).to eq 404
      expect(subject.body).to eq 'not found'
    end
  end
end

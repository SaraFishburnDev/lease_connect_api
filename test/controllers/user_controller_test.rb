require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    User.destroy_all
    @users = User.create([
                           { name: 'Nic', email: 'nic@nic.com', password: 'Passw0rd!',
                             password_confirmation: 'Passw0rd!' },
                           { name: 'Sara', email: 'sara@sara.com', password: 'Passw0rd2!',
                             password_confirmation: 'Passw0rd2!' }
                         ])
  end

  test 'should get index' do
    get '/api/users'
    assert_response :success
    assert @response.body, @users.as_json(except: [:password_digest])
  end

  test 'should get show' do
    get "/api/users/#{@users[0].id}"
    assert_response :success
    assert @response.body, @users[0].as_json(except: [:password_digest])
  end

  test 'should get create' do
    post '/api/users',
         params: { name: 'Raf', email: 'raf@raf.com', password: 'Passw0rd3!', password_confirmation: 'Passw0rd3!',
                   role_name: 'admin', house_id: 10 }
    assert_response :success
    assert @response.body, @users[2].as_json(except: [:password_digest])
  end

  test 'should get update' do
    post '/api/sessions/sign_in', params: { email: 'test1', password: 'Passw0rd!' }
    token = JSON.parse(@response.body)[:authToken]

    put "/api/users/#{@users[0].id}", params: { name: 'Raf', email: 'raftest' },
                                      headers: { Authorization: "Bearer #{token}" }
    assert_response :success
    assert @response.body, @users[0].as_json({ name: 'Raf', email: 'raftest' })
  end

  test 'should update password when previous password was passed' do
    post '/api/sessions/sign_in', params: { email: 'nic@nic.com', password: 'Passw0rd!' }
    token = JSON.parse(@response.body)[:authToken]

    put "/api/users/#{@users[0].id}",
        params: { password: 'Passw0rd!', new_password: 'Passw0rd@', new_password_confirmation: 'Passw0rd@' }, headers: { Authorization: "Bearer #{token}" }
    assert_response :success
  end

  test 'should get destroy' do
    post '/api/sessions/sign_in', params: { email: 'test1', password: 'Passw0rd!' }
    token = JSON.parse(@response.body)[:authToken]

    delete "/api/users/#{@users[0].id}", headers: { Authorization: "Bearer #{token}" }
    assert_response :success
    assert User.count, 1
  end
end

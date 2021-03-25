Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :bookings
    end
  end

  resources :requested_slots

  get 'requested_slots/cancel_view/:id' => 'requested_slots#cancel_prayer_view', as: 'cancel_prayer_view'
  get 'requested_slots/cancel/:id' => 'requested_slots#cancel_prayer', as: 'cancel_prayer'
  get 'requested_slots/user_slots/:deviceId' => 'requested_slots#user_slots', as: 'user_slots'
end

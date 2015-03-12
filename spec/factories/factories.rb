FactoryGirl.define do 
  factory :user do 
    email "test@example.com"
    password "aaaaaaaa"
    password_confirmation "aaaaaaaa"
    confirmed_at Time.now
  end

  factory :category do
    name "Music"
  end

  factory :video do
    name "Test"
    description "This is a video"
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public', 'uploads', 'video', 'avatar', 'Minecraft_ ROCK PAPER SCISSORS OF DEATH GAME - Animation.mp4'))}
  end    
end
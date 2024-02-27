# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = User.new(
      email: "example@gmail.com",
      userid: "Tarou", 
      username: "Tarou",
      tel: 99911112222,
      birthday: 20001212,
      password: "password",
      password_confirmation: "password",
      confirmed_at: Date.today
    )
  end

  describe "validation" do
      it "useridがnilのとき、@userが無効なこと" do
        @user.userid = nil
        expect(@user).not_to be_valid
      end
      it "telがnilのとき、@userが無効なこと" do
        @user.tel = nil
        expect(@user).not_to be_valid
      end
      it "birthdayがnilのとき、@userが無効なこと" do
        @user.birthday = nil
        expect(@user).not_to be_valid
      end
      it "uidが存在するとき、telがnilでも@userが有効なこと" do
        @user.uid = "uid"
        @user.tel = nil
        expect(@user).to be_valid
      end
      it "uidが存在するとき、bithdayがnilでも@userが有効なこと" do
        @user.uid = "uid"
        @user.birthday = nil
        expect(@user).to be_valid
      end
      it "passwordが6文字未満のとき@userが無効なこと" do
        @user.password = "passw"
        @user.password_confirmation = "passw"
        expect(@user).not_to be_valid
      end


  end
end

require "rails_helper"

RSpec.describe "Users", type: :system do

  it "GET #new /users/sign_up" do
    visit "/users/sign_up"
    expect(page).to have_text("アカウントを作成")
  end
  it "全ての項目を入力したときアカウント作成が成功すること" do
    #アカウント作成ページに移動
    visit "/users/sign_up"
    fill_in "Userid", with: "Tarou"
    fill_in "Tel", with: 99901012233
    fill_in "Birthday", with: 19970325
    fill_in "メールアドレス", with: "example@gmail.com"
    fill_in "Username", with: "tarou"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"
    click_button "SignUp"

    expect(page).to have_text("ログイン")
  end
  it "入力項目が足りないときアカウント作成が失敗すること" do
    visit "/users/sign_up"
    fill_in "Userid", with: "Jiro"
    fill_in "Tel", with: 99901012233
    fill_in "Birthday", with: 19970325
    click_button "SignUp"

    expect(page).to have_text("エラーが発生したため")
  end

  it "有効なemailとpasswordを入力したとき、ログインに成功すること" do
    user = FactoryBot.create(:user)
    visit "/users/sign_in"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "Log in"

    expect(page).to have_text("ログインしました。")
  end

  it "無効な値を入力したとき、ログインに失敗すること" do
    user = FactoryBot.create(:user)
    visit "/users/sign_in"
    fill_in "メールアドレス", with: "aaaa"
    fill_in "パスワード", with: user.password
    click_button "Log in"

    expect(page).to have_text("メールアドレスまたはパスワードが違います。")
  end

  it "ツイートの本文が存在するとき、ツイートに成功すること" do
    tweet = FactoryBot.create(:tweet)
    visit "/users/sign_in"
    fill_in "メールアドレス", with: tweet.user.email
    fill_in "パスワード", with: tweet.user.password
    click_button "Log in"
    
    visit "/tweets/new"
    fill_in :content, with: "test"
    click_button "ツイートする"

    expect(page).to have_text("ツイートが成功しました。")
  end

  it "ツイートの本文が空のとき、ツイートに失敗すること" do
    tweet = FactoryBot.create(:tweet)
    visit "/users/sign_in"
    fill_in "メールアドレス", with: tweet.user.email
    fill_in "パスワード", with: tweet.user.password
    click_button "Log in"
    
    visit "/tweets/new"
    fill_in :content, with: nil
    click_button "ツイートする"

    expect(page).to have_text("blank")
  end


end


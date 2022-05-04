require 'rails_helper'

RSpec.describe 'チャット', type: :system do
  let(:login_user) { create(:user) }
  let(:user) { create(:user) }
  # OJT課題用なのでdescribeやcontextも書かない方がわかりやすいと思ったのであえてそうしている。

  it 'ユーザーの詳細ページに「メッセージ」ボタンが存在すること' do
    # ログインする
    login_as login_user
    # ユーザーの詳細画面に遷移する
    visit user_path(user)
    # メッセージボタンが存在する
    expect(page).to have_content('メッセージ')
  end

  it '「メッセージ」ボタンを押すと当該ユーザーとのチャットルームに遷移すること' do
    # ログインする
    login_as login_user
    # ユーザーの詳細画面に遷移する
    visit user_path(user)
    # メッセージボタンを押す
    click_link 'メッセージ'
    expect(current_path).to eq chatroom_path(Chatroom.first)
  end

  it 'テキストを入力しないで投稿ボタンを押すとエラーメッセージが表示されること', js: true do
    # ログインする
    login_as login_user
    # ユーザーの詳細画面に遷移する
    visit user_path(user)
    # メッセージボタンを押す
    click_link 'メッセージ'
    # 何も入力せず投稿ボタンを押す
    click_button '投稿'
    # アラートが表示されるまで待つ必要がある
    sleep 0.5
    expect(page.driver.browser.switch_to.alert.text).to eq 'メッセージを入力してください'
  end

  it 'テキストを入力して投稿ボタンを押すとメッセージが投稿されること' do
    # ログインする
    login_as login_user
    # ユーザーの詳細画面に遷移する
    visit user_path(user)
    # メッセージボタンを押す
    click_link 'メッセージ'
    # メッセージを入力する
    fill_in 'メッセージ', with: 'hello world'
    # 投稿ボタンを押す
    click_button '投稿'
    # メッセージが画面に反映される
    expect(page).to have_content 'hello world'
  end

  it 'コメントの編集ボタンを押すとモーダルが表示されコメントの更新ができること', js: true do
    # ログインする
    login_as login_user
    # ユーザーの詳細画面に遷移する
    visit user_path(user)
    # メッセージボタンを押す
    click_link 'メッセージ'
    # メッセージを入力する
    fill_in 'メッセージ', with: 'hello world'
    # 投稿ボタンを押す
    click_button '投稿'
    # メッセージが画面に反映される
    expect(page).to have_content 'hello world'
    # メッセージの編集ボタンを押す
    find(".edit-button").click
    within '#modal-container' do
      fill_in 'メッセージ', with: 'updated hello world'
      click_button '更新'
    end
    expect(page).to have_content('updated hello world')
  end

  it 'コメントの削除ボタンを押すと確認ダイアログが出て「OK」を押すとコメントが削除されて画面から消えること' do
    # ログインする
    login_as login_user
    # ユーザーの詳細画面に遷移する
    visit user_path(user)
    # メッセージボタンを押す
    click_link 'メッセージ'
    # メッセージを入力する
    fill_in 'メッセージ', with: 'hello world'
    # 投稿ボタンを押す
    click_button '投稿'
    # メッセージが画面に反映される
    expect(page).to have_content 'hello world'
    # メッセージの編集ボタンを押す
    page.accept_confirm { find(".delete-button").click }
    expect(page).not_to have_content('hello world')
  end
end
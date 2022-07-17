require 'rails_helper'
RSpec.describe User, type: :model do
  describe "ユーザー新規登録" do
    before do
      @user = FactoryBot.build(:user)
    end

    # 正常系テスト
    context 'ユーザー新規登録ができるとき' do
      it 'nicknameが登録できるとき' do
        @user.nickname = 'ほげほげ'
        expect(@user).to be_valid
      end

      it 'emailが登録できるとき' do
        @user.email = 'test@test.com'
        expect(@user).to be_valid
      end

      it 'passwordが登録できるとき' do
        @user.password
        expect(@user).to be_valid
      end

      it 'password確認' do
        @user.password_confirmation
        expect(@user).to be_valid
      end

      it 'first_name_kanjiが登録できる' do
        @user.first_name_kanji = '穂毛'
        expect(@user).to be_valid
      end

      it 'last_name_kanjiが登録できる' do
        @user.last_name_kanji = '穂毛'
        expect(@user).to be_valid
      end

      it 'first_name_kanaが登録できる' do
        @user.first_name_kana = 'ホゲ'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが登録で来る' do
        @user.last_name_kana = 'ホゲ'
        expect(@user).to be_valid
      end

      it '誕生日が登録できる' do
        @user.birthday = '19881109'
        expect(@user).to be_valid
      end
    end

    # 異常系テスト
    context 'ユーザー登録が失敗するとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      # メールアドレスが一意性であること
      # 一意性制約は、テーブル内で重複するデータを禁止する制約です
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      # メールアドレスは、@を含む必要があること
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'hog12'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英数字混合でないと登録できない' do
        @user.password = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが半角数字だけでは登録できない' do
        @user.password = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが半角英数以外ではエラーになる' do
        @user.password = '123abcほげ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'first_name_kanjiが空では登録できない' do
        @user.first_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it 'first_name_kanjiが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name_kanji = 'hogehohe'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji is invalid")
      end

      it 'last_name_kanjiが空では登録できない' do
        @user.last_name_kanji = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
      end

      it 'last_name_kanjiが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name_kanji = 'hogehoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji is invalid")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'first_name_kanaが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name_kana = 'ほげほげ'
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'last_name_kanaが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name_kana = 'ほげほげ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
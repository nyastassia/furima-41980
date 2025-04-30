require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'すべての項目が揃っていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
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

      it 'emailが＠を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'password_confirmationが空では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが5文字以下では登録できない ' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが半角英文字を含まないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが数字を含まないと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
    end

    it 'passwordが全角だと登録できないこと' do
      @user.password = 'ＡＢＣ１２３' # 全角英数字
      @user.password_confirmation = 'ＡＢＣ１２３'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers')
    end

    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = 'abcdef1'
      @user.password_confirmation = 'abcdef2'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'name_kanjiが空では登録できない ' do
      @user.name_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name kanji can't be blank")
    end

    it 'name_kanjiが全角漢字またはひらがな以外では登録できない' do
      @user.name_kanji = 'Yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Name kanji is invalid. Input full-width characters')
    end

    it 'surname_kanjiが空では登録できない' do
      @user.surname_kanji = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Surname kanji can't be blank")
    end

    it 'surname_kanjiが全角漢字またはひらがな以外では登録できない' do
      @user.surname_kanji = 'Taro'
      @user.valid?
      expect(@user.errors.full_messages).to include('Surname kanji is invalid. Input full-width characters')
    end

    it 'name_katakanaが空では登録できない' do
      @user.name_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name katakana can't be blank")
    end

    it 'name_katakanaがカタカナ以外では登録できない' do
      @user.name_katakana = 'たろう'
      @user.valid?
      expect(@user.errors.full_messages).to include('Name katakana is invalid. Input full-width katakana characters')
    end

    it 'surname_katakanaが空では登録できない' do
      @user.surname_katakana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Surname katakana can't be blank")
    end

    it 'surname_katakanaがカタカナ以外では登録できない' do
      @user.surname_katakana = 'やまだ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Surname katakana is invalid. Input full-width katakana characters')
    end

    it 'birthdayが空では登録できない' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end

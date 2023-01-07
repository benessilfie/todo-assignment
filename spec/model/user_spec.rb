require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do
      let (:user) { create(:user) }

      context 'first_name' do
        it 'returns an error when first_name is not present' do
          user.update(first_name: nil)

          expect(user.valid?).to be_falsey
          expect(user.errors.full_messages.first).to eq("First name can't be blank")
        end

        it 'returns no error when first_name is present' do
          expect(user.valid?).to be_truthy
          expect(user.errors.full_messages.first).to be_nil
        end
      end

      context 'last_name' do
        it 'returns an error when last_name is not present' do
          user.update(last_name: nil)

          expect(user.valid?).to be_falsey
          expect(user.errors.full_messages.first).to eq("Last name can't be blank")
        end

        it 'returns no error when last_name is present' do
          expect(user.valid?).to be_truthy
          expect(user.errors.full_messages.first).to be_nil
        end
      end

      context 'password_digest' do
        it 'returns an error when password_digest is not present' do
          user.update(password_digest: nil)

          expect(user.valid?).to be_falsey
          expect(user.errors.full_messages.first).to eq("Password digest can't be blank")
        end

        it 'returns no error when password_digest is present' do
          expect(user.valid?).to be_truthy
          expect(user.errors.full_messages.first).to be_nil
        end
      end

      context 'email' do
        it 'returns an error when email is not present' do
          user.update(email: nil)

          expect(user.valid?).to be_falsey
          expect(user.errors.full_messages.second).to eq("Email can't be blank")
        end

        it 'returns an error when email is not in the correct format' do
          user.update(email: 'invalid')

          expect(user.valid?).to be_falsey
          expect(user.errors.full_messages.first).to eq("Email invalid email")
        end

        it 'returns no error when email is present and in the correct format' do
          expect(user.valid?).to be_truthy
          expect(user.errors.full_messages.first).to be_nil
        end
      end
  end

  context 'associations' do
    context 'has many todos' do
      it 'has many todos' do
        assc = described_class.reflect_on_association(:todos)

        expect(assc.macro).to eq :has_many
      end
    end
  end

  context 'has secure password' do
    let (:user) { create(:user) }

    it 'has a password_digest attribute' do
      expect(user).to respond_to(:password_digest)
    end

    it 'has secure password' do
      expect(user).to respond_to(:authenticate)
    end

    it 'returns user when password is correct' do
      expect(user.authenticate(user.password)).to eq(user)
    end

    it 'returns false when password is incorrect' do
      expect(user.authenticate('invalid')).to be_falsey
    end
  end
end

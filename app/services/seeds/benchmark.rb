# frozen_string_literal: true

module Seeds
  class Benchmark
    def call
      insert_words
      puts "Inserted 100 words"
      insert_users
      puts "Inserted 1000 users"
      insert_matches
      puts "Inserted 100 matches per user"
      insert_attempts
      puts "Inserted 5 attempts per match"
    end

    private

    def insert_words
      # 100 words of the day
      ActiveRecord::Base.connection.execute(
        <<~SQL.squish
          INSERT INTO words (kind, value, created_at, updated_at)
          VALUES #{generate_word_values.join(', ')}
        SQL
      )
    end

    def generate_word_values
      (1..100).map do |i|
        "(1, '#{Faker::Lorem.unique.characters(number: 5)}', '#{(100-i).days.ago}', '#{(100-i).days.ago}')"
      end
    end

    def insert_users
      # 1000 users
      ActiveRecord::Base.connection.execute(
        <<~SQL.squish
          INSERT INTO users (name, email, username, password_digest, created_at, updated_at)
          VALUES #{generate_user_values.join(', ')}
        SQL
      )
    end

    def generate_user_values
      password_digest = BCrypt::Password.create("password")
      (1..1000).map do |i|
        "('user_#{i}', 'user_#{i}@worlde.com', 'user_#{i}', '#{password_digest}', '#{(100).days.ago}', '#{(100).days.ago}')"
      end
    end

    def insert_matches
      # 100 matches per user
      ActiveRecord::Base.connection.execute(
        <<~SQL.squish
          INSERT INTO matches (user_id, word_id, mode, created_at, updated_at)
          VALUES #{generate_match_values.join(', ')}
        SQL
      )
    end

    def generate_match_values
      (1..100).map do |word_id|
        (1..1000).map do |user_id|
          "(#{user_id}, #{word_id}, 0, '#{(100-word_id).days.ago}', '#{(100-word_id).days.ago}')"
        end
      end
    end

    def insert_attempts
      # 5 attempts per user_match
      ActiveRecord::Base.connection.execute(
        <<~SQL.squish
          INSERT INTO attempts (count, letters, letters_colours, user_id, match_id, created_at, updated_at)
          VALUES #{generate_attempt_values.join(', ')}
        SQL
      )
    end

    def generate_attempt_values
      Match.all.map do |match|
        (1..5).map do |attempt|
          "(0, '{}', '{}', #{match.user_id}, #{match.id}, '#{(100-match.word_id).days.ago}', '#{(100-match.word_id).days.ago}')"
        end
      end
    end
  end
end

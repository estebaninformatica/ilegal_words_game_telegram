require_relative 'ilegal_words_game.rb'
require 'telegram/bot'
require 'net/http'
require_relative 'settings.rb'
class IlegalWordsBot
  def call
    game = IlegalWordsGame.new
    game.mix

    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          kb = [
            Telegram::Bot::Types::KeyboardButton.new(text: 'Pedir carta'),
            Telegram::Bot::Types::KeyboardButton.new(text: 'Reglas')
          ]
          markup = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: kb)
          bot.api.send_message(chat_id: message.chat.id, text: 'Vamos a jugar !', reply_markup: markup)
        when 'Reglas'
          bot.api.send_message(chat_id: message.chat.id, text: "#{game.rules}", parse_mode: 'Markdown')
        when 'Pedir carta'
          bot.api.send_message(chat_id: message.chat.id, text: "#{game.get_awesome_cart}", parse_mode: 'Markdown')
        else
          bot.api.send_message(chat_id: message.chat.id, text: "No te entiendo :( ", parse_mode: 'Markdown')
        end
      end
    end
  end
end
IlegalWordsBot.new.call

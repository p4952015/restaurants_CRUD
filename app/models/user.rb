module Encryptor
  require 'digest'
  def self.encrypt(password)
    Digest::SHA1.hexdigest(password)
  end

  def self.salted(password, head = "123", tail = "xx")
    "#{head}#{password}#{tail}"
  end
end

class User < ApplicationRecord
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /.+\@.+\.+./ } #正規表達式

  validates :password, presence: true,
                       confirmation: true #rails的confirmation驗證方法

  before_create :encrypt_password

  has_many :restaurants #幫建出attr_reader.attr_writter

  def self.login(params)
    email = params[:email]
    password = params[:password]

    salted_password = Encryptor.salted(password)
    encrypted_password = Encryptor.encrypt(salted_password)

    find_by(email: email, password: encrypted_password)
  end

  private
  def encrypt_password
    salted_pwd = Encryptor.salted(password) 
    self.password = Encryptor.encrypt(salted_pwd)#對密碼加密，在create前先變成亂數在寫進資料庫
    # self.password = Digest::SHA1.hexdigest(password)
    # self.password=(Digest::SHA1.hexdigest(password))
    # password = Digest::SHA1.hexdigest(password)
  end
end

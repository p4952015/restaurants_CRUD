class Restaurant < ApplicationRecord
  validates :title, presence: true #title欄必填，空白寫不進資料庫
end

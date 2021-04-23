# class Restaurant < ApplicationRecord
#   validates :title, presence: true #title欄必填，空白寫不進資料庫

#     scope :available, -> { where(deleted_at: nil) } #可把scope想成簡化版的類別方法  
#                         #lambda, proc-> 物件化的Block
#     default_scope { where(deleted_at: nil) }

#   def destroy
#     update(deleted_at: Time.now) #controller的下架功能搬到model這裏
#   end

#   # Restaurant.deleted 列出所有被刪除的資料
#   # def self.deleted
#   #   upscope(:where).where.(deleted_at: nil)
#   # end

#   #真的destroy資料
#   # def really_destroy
#   #   super.destroy
#   # end
# end

class Restaurant < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true
  belongs_to :user #opptional預設是fales 欄位不能為空
  has_many :comments
end


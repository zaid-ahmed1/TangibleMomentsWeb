class AddQrCodeToMemory < ActiveRecord::Migration[7.1]
  def change
    add_column :memories, :qr_code, :string
  end
end

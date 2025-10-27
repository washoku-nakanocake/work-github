# if is_active = nil > is_active = true
# エラー防ぐのため

class MakeIsActiveNotNullAndDefault < ActiveRecord::Migration[6.1]
  def up
    # set default == true
    change_column_default :customers, :is_active, from: nil, to: true

    # if NULL >> TRUE (1 = true)
    execute "UPDATE customers SET is_active = 1 WHERE is_active IS NULL"

    change_column_null :customers, :is_active, false
  end

  def down
    change_column_null :customers, :is_active, true
    change_column_default :customers, :is_active, from: true, to: nil
  end
end
class ChangeColumnStructureOfRequests < ActiveRecord::Migration
  def change
    add_column :requests, :acc_curr_st_id, :integer
    add_column :requests, :acc_chgTo_st_id, :integer
    add_column :requests, :acc_old_st_id, :integer
    rename_column :requests, :state_id, :req_st_id
    rename_column :requests, :state, :req_st_desc
    rename_column :requests, :request_type, :req_type
  end
end

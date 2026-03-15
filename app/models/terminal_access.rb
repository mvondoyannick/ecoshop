class TerminalAccess < ApplicationRecord
  after_create_commit -> { 
    broadcast_prepend_to :terminal_accesses, 
                        target: "terminal_accesses_list", 
                        partial: "terminal_accesses/terminal_access_row", 
                        locals: { access: self } 
  }
end

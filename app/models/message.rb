class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_now self }
  after_create_commit :space_saver

  def space_saver
    if Message.all.count > 40
      Message.first.destroy
    end
  end
end

ALTER TABLE chats
  ADD CONSTRAINT fk_chats_model
  FOREIGN KEY (ai_model_id) REFERENCES bot_models(id)
  ON DELETE SET NULL;

ALTER TABLE messages
  ADD CONSTRAINT fk_messages_chat
  FOREIGN KEY (chat_uuid) REFERENCES chats(uuid)
  ON DELETE CASCADE;

ALTER TABLE message_feedbacks
  ADD CONSTRAINT fk_feedbacks_message
  FOREIGN KEY (message_id) REFERENCES messages(id)
  ON DELETE CASCADE;

ALTER TABLE feedback_analysis
  ADD CONSTRAINT fk_analysis_feedback
  FOREIGN KEY (feedback_id) REFERENCES message_feedbacks(id)
  ON DELETE CASCADE;

ALTER TABLE command_suggestions
  ADD CONSTRAINT fk_suggestions_message
  FOREIGN KEY (message_id) REFERENCES messages(id)
  ON DELETE CASCADE;

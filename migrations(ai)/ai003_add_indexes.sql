CREATE INDEX idx_chats_created_at ON chats(created_at);
CREATE INDEX idx_chats_model ON chats(ai_model_id);

CREATE INDEX idx_messages_chat_uuid ON messages(chat_uuid);
CREATE INDEX idx_messages_created_at ON messages(created_at);

CREATE INDEX idx_feedbacks_message_id ON message_feedbacks(message_id);
CREATE INDEX idx_analysis_feedback_id ON feedback_analysis(feedback_id);

CREATE INDEX idx_suggestions_message_id ON command_suggestions(message_id);

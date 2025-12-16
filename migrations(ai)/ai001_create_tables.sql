-- AI DB: все таблицы ИИ-сервиса (без users/roles/...)

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE bot_models (
  id BIGSERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  provider VARCHAR(100) NOT NULL,
  version VARCHAR(50),
  max_tokens INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ВАЖНО: PK = uuid. НЕТ id/chat_id. НЕТ user_id.
CREATE TABLE chats (
  uuid UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title VARCHAR(255),
  ai_model_id BIGINT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- messages теперь ссылается на chats по UUID
CREATE TABLE messages (
  id BIGSERIAL PRIMARY KEY,
  chat_uuid UUID NOT NULL,
  role VARCHAR(50) NOT NULL,           -- "user" / "assistant" / "system"
  content TEXT NOT NULL,
  tokens INT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE message_feedbacks (
  id BIGSERIAL PRIMARY KEY,
  message_id BIGINT NOT NULL,
  rating INT NOT NULL,                -- например: -1/0/1 или 1..5
  comment TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE feedback_analysis (
  id BIGSERIAL PRIMARY KEY,
  feedback_id BIGINT NOT NULL,
  sentiment VARCHAR(50),
  tags TEXT[],
  metadata JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE command_suggestions (
  id BIGSERIAL PRIMARY KEY,
  message_id BIGINT NOT NULL,
  command TEXT NOT NULL,
  confidence DOUBLE PRECISION NOT NULL DEFAULT 0,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

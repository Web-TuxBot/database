-- =============================================
-- MIGRATION 001: CREATE ALL TABLES
-- =============================================

-- 1. Create users table
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'user' 
        CHECK (role IN ('user', 'admin', 'moderator')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE users IS 'Пользователи системы';
COMMENT ON COLUMN users.role IS 'Роль: user, admin, moderator';

-- 2. Create bot_models table
CREATE TABLE bot_models (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    version VARCHAR(50) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE bot_models IS 'Модели ИИ для чатов';

-- 3. Create chats table
CREATE TABLE chats (
    id BIGSERIAL PRIMARY KEY,
    uuid UUID NOT NULL UNIQUE DEFAULT gen_random_uuid(),
    user_id BIGINT NOT NULL,
    model_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL DEFAULT 'New Chat',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE chats IS 'Чат-сессии пользователей';

-- 4. Create messages table
CREATE TABLE messages (
    id BIGSERIAL PRIMARY KEY,
    chat_id BIGINT NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('user', 'assistant')),
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE messages IS 'Сообщения в чатах';

-- 5. Create message_feedbacks table
CREATE TABLE message_feedbacks (
    id BIGSERIAL PRIMARY KEY,
    message_id BIGINT NOT NULL,
    model_id BIGINT NOT NULL,
    is_positive BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE message_feedbacks IS 'Оценки сообщений (лайки/дизлайки)';

-- 6. Create user_sessions table
CREATE TABLE user_sessions (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    refresh_token TEXT NOT NULL,
    expires_at TIMESTAMPTZ NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE user_sessions IS 'Сессии пользователей (JWT токены)';

-- 7. Create command_suggestions table
CREATE TABLE command_suggestions (
    id BIGSERIAL PRIMARY KEY,
    short_description VARCHAR(500) NOT NULL,
    command_example TEXT NOT NULL,
    usage_count INTEGER NOT NULL DEFAULT 0
);

COMMENT ON TABLE command_suggestions IS 'Подсказки команд для пользователей';

-- 8. Create system_metrics table
CREATE TABLE system_metrics (
    id BIGSERIAL PRIMARY KEY,
    metric_type VARCHAR(100) NOT NULL,
    metric_value DECIMAL(15,6) NOT NULL,
    endpoint VARCHAR(500) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE system_metrics IS 'Метрики производительности системы';

-- 9. Create audit_logs table
CREATE TABLE audit_logs (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NULL,
    action TEXT NOT NULL,
    ip_address VARCHAR(45) NOT NULL,
    user_agent TEXT NOT NULL,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE audit_logs IS 'Логи действий пользователей и системы';

-- 10. Create feedback_analysis table
CREATE TABLE feedback_analysis (
    id BIGSERIAL PRIMARY KEY,
    feedback_id BIGINT NOT NULL UNIQUE,
    analysis_note TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE feedback_analysis IS 'Анализ пользовательских оценок';
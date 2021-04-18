CREATE TABLE IF NOT EXISTS public.weather
(
    id BIGSERIAL PRIMARY KEY,
    timestamp    TEXT                        NOT NULL,
    location    TEXT                        NOT NULL,
    temperature    TEXT                        NOT NULL,
    humidity    TEXT                        NOT NULL
);

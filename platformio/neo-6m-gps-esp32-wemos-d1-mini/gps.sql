CREATE TABLE IF NOT EXISTS public.gps
(
    id BIGSERIAL PRIMARY KEY,
    timestamp    TEXT                        NOT NULL,
    longitude    TEXT                        NOT NULL,
    latitude    TEXT                         NOT NULL
);

CREATE TABLE IF NOT EXISTS courses(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date,
    deleted_at date
);

CREATE TABLE IF NOT EXISTS lessons(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    content text,
    course_id bigint REFERENCES courses(id),
    video_url text,
    -- squawk-ignore prefer-bigint-over-int
    position int,
    created_at date,
    updated_at date,
    deleted_at date
);

CREATE TABLE IF NOT EXISTS modules(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date,
    deleted_at date
);

CREATE TABLE IF NOT EXISTS programs(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    price numeric NOT NULL,
    program_type text,
    created_at date,
    updated_at date
);


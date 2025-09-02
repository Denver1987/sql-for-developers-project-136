CREATE TABLE IF NOT EXISTS courses(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date
);

CREATE TABLE IF NOT EXISTS lessons(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    content text,
    course_id bigint REFERENCES courses(id),
    video_link text,
    -- squawk-ignore prefer-bigint-over-int
    position_in_course int,
    created_at date,
    updated_at date,
    course_link text
);

CREATE TABLE IF NOT EXISTS modules(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id bigint,
    name text NOT NULL,
    description text,
    created_at date,
    updated_at date
);

CREATE TABLE IF NOT EXISTS programs(
    id bigint PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name text NOT NULL,
    price numeric NOT NULL,
    type text,
    created_at date,
    updated_at date
);

